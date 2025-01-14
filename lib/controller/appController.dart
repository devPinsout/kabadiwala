import 'dart:convert';
import 'dart:io';
import 'package:get/get.dart';
import 'package:kabadiwala/models/addressModel.dart';
import 'package:kabadiwala/models/filterModel.dart';
import 'package:kabadiwala/models/scrapCategoryGroup.dart';
import 'package:kabadiwala/models/scrapCategoryModel.dart';
import 'package:kabadiwala/models/scrapListModel.dart';
import 'package:kabadiwala/models/userModel.dart';
import 'package:kabadiwala/screens/location/selectLocation.dart';
import 'package:kabadiwala/screens/login/login.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/scrapImpact/scrapImpact.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrap.dart';
import 'package:kabadiwala/services/network.dart';
import 'package:kabadiwala/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppController extends GetxController implements DisposableInterface{
  //Bottom navigation
  var currentNavIndex=0.obs;
  RxBool isLoggedIn = false.obs;
  static Rx<UserModel> userDetails = UserModel().obs;
  static RxString authToken = "".obs;
  static RxBool isLoading = false.obs;
  RxList<ScrapListModel> scrapList = List<ScrapListModel>.empty().obs;
  RxList<ScrapListModel> scrapCategoryList = List<ScrapListModel>.empty().obs;
  RxList<ScrapCategoryGroup> groupedScrapList = <ScrapCategoryGroup>[].obs;
  RxMap<String, FilterModel> filters = <String, FilterModel>{}.obs; 
  RxList<ScrapListModel> scrapSearch = <ScrapListModel>[].obs;
  RxList<AddressModel> address = <AddressModel>[].obs;
  RxList<String> tempSelectedCategories = <String>[].obs;
   RxInt currentPage = 0.obs;
   RxInt lastPage = 0.obs;
   RxBool isButtonDisabled = true.obs;
   RxBool isCategoryPage = false.obs;

void toggleCategory(String categoryId) {
  if (tempSelectedCategories.contains(categoryId)) {
    tempSelectedCategories.remove(categoryId);
  } else {
    tempSelectedCategories.add(categoryId);
  }

  print('Selected categories: $tempSelectedCategories');
   isButtonDisabled.value = tempSelectedCategories.isEmpty;
}

void clearTempSelectedCategories() {
    tempSelectedCategories.clear();
  }

  @override
  void onClose() {
    super.onClose();
    clearTempSelectedCategories(); // Clear the selected categories when the controller is disposed
  }
  


   // Update profile
 updateProfile({
   firstName,
   lastName,
   email,
   imageid
  
  }) async{
    try{
      showProgress(title: "Updating....");
      final response  = await NetworkUtil.networkPatch('/app-users',
      body: {
        "first_name":firstName,
        "last_name":lastName,
        "email":email,
        "profile_img":imageid,
      },
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}'
      }
      );
      closeProgress();
      print(response.body);
      print(authToken);
      final jsonResponse = jsonDecode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        print(jsonResponse['message']);
        AppController.userDetails.value = userModelFromJson(jsonEncode(jsonResponse["data"]));
        showSuccess(title: "Congrulations !!", message: "Your profile created successfully");
        final prefs = await SharedPreferences.getInstance();
        prefs.setString('user', jsonEncode(jsonResponse["data"]));
      
        Get.to(SelectLocationPage());
      }
    }catch(error){
      print("Account Failed $error" );
    }
 }  
 
// Profile Image Update
Future<void> updateProfileImage(File? imagePath) async {
  try {
    // First API call to upload the image
    final response = await NetworkUtil.uploadImage(imagePath);
    final jsonResponse = jsonDecode(response.body);
    
    if (response.statusCode == 200) {
      print('Image uploaded successfully!');
      showSuccess(title: "Congratulations!!", message: "Image uploaded successfully");

      // Extract the image ID from the response
      final int? imageId = jsonResponse['data']['id'];
      if (imageId != null) {
        userDetails.value.profileImg = imageId;

        // Call the second API with the image ID
        await updateProfile(
        firstName: AppController.userDetails.value.firstName??'',
        lastName: AppController.userDetails.value.lastName??'',
        email: AppController.userDetails.value.email??'',
        imageid: AppController.userDetails.value.profileImg.toString(),
        );
      } else {
        print("Image ID not found in response");
      }
      
    } else {
      print('Failed to upload image: ${response.statusCode}');
      showError(title: "Failed", message: "Image upload failed");
    }
  } catch (error) {
    print("Fetching error: $error");
  }
}


 

  readUserDetails() async {
  try {
    String userId = AppController.userDetails.value.id.toString();
    final response = await NetworkUtil.networkGet(
      '/app-users/$userId',
      null,
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
    );

    if (response.data["data"] != null) {
      AppController.userDetails.value = userModelFromJson(jsonEncode(response.data["data"]));
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('user', jsonEncode(response.data["data"]));
      print('User details saved successfully');
    } else {
      print('User data is null');
    }
  } catch (e) {
    print('Error fetching user details: $e');
  }
}


//Logout
  logout() async {
  await clearUserDetails();
 Get.offAll(() => LoginScreen());
}

Future<void> clearUserDetails() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.remove('name');
  prefs.remove('email');
  prefs.remove('mobile');
  prefs.remove('isLoggedIn');
  
  AppController controller = Get.find<AppController>();
  AppController.userDetails.value=UserModel();
  AppController.authToken.value= "";
  controller.isLoggedIn.value=false;
}

readScrapList({String? searchPhrase = "" ,int page = 1, List<String>? selectedCategories, Function? navigateTo }) async {
  try {
     if (page == 1) {
    scrapList.clear();
  }
    scrapList.clear();
    isLoading.value = true;

      // Initialize request body
          Map<String, dynamic> requestBody = {
          'page': page.toString(),
          'search_phrase':searchPhrase,
          };
          if (selectedCategories != null && selectedCategories.isNotEmpty) {
      for (var categoryId in selectedCategories) {
        requestBody['scrap_category[$categoryId]'] = categoryId; // Send each category individually
      }
    }
           if (searchPhrase != null && searchPhrase.isNotEmpty) {
                   requestBody['search_phrase'] = searchPhrase;
                  }
          
    print("Request Body:");
    requestBody.forEach((key, value) {
      print('$key: $value');
    });

    // API Call
    final response = await NetworkUtil.networkPost(
      '/scrap/search',
     body: requestBody,
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
    );

    isLoading.value = false;
     final responseBody = jsonDecode(response.body);
     print(responseBody);
    // Parse response and group by category
    scrapList.clear();
    scrapList.addAll(scrapListModelFromJson(jsonEncode(responseBody['data']['data'])));

    Map<String, List<ScrapListModel>> groupedData = {};
    Map<String, String> categoryIconUrls = {}; 

    for (var item in scrapList) {
      groupedData.putIfAbsent(item.categoryName.toString(), () => []).add(item);

    
    }

    groupedScrapList.clear();
    groupedScrapList.addAll(groupedData.entries
        .map((entry) => ScrapCategoryGroup(
              categoryName: entry.key,
              scrapItems: entry.value,
              categoryIconUrl: categoryIconUrls[entry.key] ?? "", 
            ))
        .toList());
          if (navigateTo != null) {
           navigateTo();
          }

        final selectedScrapCategory = RxMap<int, Option>();
         if (filters.containsKey("scrap_categories")) {
         selectedScrapCategory.addAll(filters["scrap_categories"]!.selectedOptions);
         print("Selected options from sectors ${selectedScrapCategory}");
        }

        final scrapCategoryOptions = filterOptionsFromJson(jsonEncode(responseBody['data']['data']), "category_name");
        
        final scrapCategoryFilter = FilterModel(
        name: "Scrap Category",
        key: "scrap_category[]",
        options: scrapCategoryOptions,
        selectedOptions: selectedScrapCategory,
    );

     filters.value["scrap_categories"] = scrapCategoryFilter;
      print("Scrap Category ${filters["scrap_categories"]?.toJson()}");
      print("Length of selected category ${groupedScrapList.length}");
  } catch (e) {
    isLoading.value = false;
    print('Error reading scrap list: $e');
  }
}


// Read Scrap Category
 readScrapCategory() async {
  try {
    isLoading.value = true;

    // API Call
    final response = await NetworkUtil.networkGet(
      '/master-data/scrap-categories/read',
      null,
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
    );

    isLoading.value = false;

    // Parse response and group by category
    scrapCategoryList.clear();
    scrapCategoryList.addAll(scrapListModelFromJson(jsonEncode(response.data['data'])));

  } catch (e) {
    isLoading.value = false;
    print('Error reading scrap list: $e');
  }
}

// address

createAddress({
  userId,
  placeType,
   street,
   subLocality,
   city,
   state,
   pincode,
   latitude,
   longitude
  
  }) async{
    try{
      showProgress(title: "Updating....");
      final response  = await NetworkUtil.networkPost('/master-data/address/create',
      body: {
        "user_id":userId,
        "place_type":placeType,
        "street":street,
        "sub_locality":subLocality,
        "city":city,
        "state":state,
        "pincode":pincode,
        "latitude":latitude,
        "longitude":longitude
      },
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}'
      }
      );
      closeProgress();
      print(response.body);
      print(authToken);
      final jsonResponse = jsonDecode(response.body);
      if(response.statusCode == 200 || response.statusCode == 201){
        print(jsonResponse['message']);
        showSuccess(title: "Congrulations !!", message: "Your address created successfully");
       
        Get.offAll(MainScreen());
      }
    }catch(error){
      print("Account Failed $error" );
    }
 } 

 // Read Address
   readAddress() async {
  try {
    isLoading.value = true;

    // API Call
    final response = await NetworkUtil.networkGet(
      '/master-data/address/read',
      null,
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
    );

    isLoading.value = false;

    // Parse response and group by category
    if(response.statusCode == 200){
      address.clear();
    address.addAll(addressModelFromJson(jsonEncode(response.data['data'])));
    print("Length of Address ${address.length}");
    }
    else{
      print("Error in fetching address");
    }

  } catch (e) {
   // isLoading.value = false;
    print('Error reading addresses: $e');
  }
}

 

 }

