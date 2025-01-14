import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/models/addressModel.dart';
import 'package:kabadiwala/models/cancelReasonModel.dart';
import 'package:kabadiwala/models/filterModel.dart';
import 'package:kabadiwala/models/leadRequestModel.dart';
import 'package:kabadiwala/models/scrapCategoryGroup.dart';
import 'package:kabadiwala/models/scrapCategoryModel.dart';
import 'package:kabadiwala/models/scrapListModel.dart';
import 'package:kabadiwala/models/userModel.dart';
import 'package:kabadiwala/screens/login/login.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/scrapImpact/scrapImpact.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrap.dart';
import 'package:kabadiwala/services/network.dart';
import 'package:kabadiwala/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LeadController extends GetxController implements DisposableInterface{

  static RxBool isLoading = false.obs;
  RxString selectedAddress = ''.obs;
  RxString selectedPlaceType = ''.obs;
  RxString selectedLongitude = ''.obs;
  RxString selectedLatitude = ''.obs;
   var selectedAddressId = Rx<int?>(null);
  var selectedScraps = <Map<String, String>>[].obs;
  RxList<LeadRequestModel> leadRequest = <LeadRequestModel>[].obs;
  RxList<CancelReasonModel> cancelReason = <CancelReasonModel>[].obs;
  
  Rx<LeadRequestModel> detailRequest = LeadRequestModel().obs;
  
  //RxList<AddressModel> address = <AddressModel>[].obs;
  final AppController controller = (Get.isRegistered<AppController>()) ? Get.find<AppController>() : Get.put(AppController());
  

   Future<void> updateSelectedAddress(dynamic address) async {
  
    String formattedAddress = '${address.street}, ${address.subLocality},${address.city}, ${address.state}, ${address.pincode}';
    
    selectedAddress.value = formattedAddress;
    selectedPlaceType.value = address.placeType;
     selectedAddressId.value = address.id; 
     selectedLatitude.value = address.latitude;
     selectedLongitude.value = address.longitude;

    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedAddress', formattedAddress);
     await prefs.setString('selectedPlaceType', selectedPlaceType.value);
     await prefs.setInt('selectedAddressId', address.id);
      await prefs.setString('selectedLatitude', selectedLatitude.value);
       await prefs.setString('selectedLongitude', selectedLongitude.value);
  }
 Future<void> loadSelectedAddress() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? storedAddress = prefs.getString('selectedAddress');
  String? storedPlaceType = prefs.getString('selectedPlaceType');
  String? storedLatitude = prefs.getString('selectedLatitude');
  String? storedLongitude = prefs.getString('selectedLongitude');
  int? storedAddressId = prefs.getInt('selectedAddressId');

  // If stored data exists, load it
  if (storedAddress != null && storedPlaceType != null) {
    selectedAddress.value = storedAddress;
    selectedPlaceType.value = storedPlaceType;
  }
  if (storedLatitude != null) selectedLatitude.value = storedLatitude;
  if (storedLongitude != null) selectedLongitude.value = storedLongitude;
  
  // Check if addressId is stored, otherwise set default address (first address)
  if (storedAddressId != null) {
    selectedAddressId.value = storedAddressId;
  } else {
    if (controller.address.isNotEmpty && selectedAddressId.value == null) {
      print('Setting default address: ${controller.address[0]}');
      updateSelectedAddress(controller.address[0]); // Set default address
    } else {
      print('No address selected, and address list is empty or ID is already set.');
    }
  }
}






 void toggleScrap(String scrapName, String price) {
  // Check if the scrap is already selected
  final existing = selectedScraps.firstWhereOrNull(
      (scrap) => scrap['scrap_name'] == scrapName);

  if (existing != null) {
    // Remove from the list if already selected
    selectedScraps.remove(existing);
    print('Removed: $scrapName');
  } else {
    // Add to the list if not selected
    selectedScraps.add({'scrap_name': scrapName, 'price': price});
    print('Added: $scrapName - Rs. $price/Kg');
  }

  // Log the updated list of selected scraps
  print('Current selected scraps: $selectedScraps');
}

// Check if a scrap is selected
bool isSelected(String scrapName) {
  bool selected = selectedScraps.any((scrap) => scrap['scrap_name'] == scrapName);
  print('Is "$scrapName" selected? $selected');
  return selected;
}

void clearSelectedScraps() {
  // Clear all selected scraps
  selectedScraps.clear();
  
  // Log the action for debugging purposes
  print('All selected scraps have been cleared.');
  
  // Log the updated state
  print('Current selected scraps: $selectedScraps');
}


  var selectedDate = DateTime.now().obs; // Default to today's date

  // Function to update the selected date
  void setSelectedDate(DateTime date) {
    selectedDate.value = date;
  }

  // Function to get the day label (Today, Tomorrow, or Weekday)
  String getDayLabel() {
    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));

    // Check if selected date is today or tomorrow
    if (DateFormat('yyyy-MM-dd').format(selectedDate.value) == DateFormat('yyyy-MM-dd').format(today)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(selectedDate.value) == DateFormat('yyyy-MM-dd').format(tomorrow)) {
      return "Tomorrow";
    } else {
      // Else, return the weekday name (e.g., Monday, Tuesday)
      return DateFormat('EEEE').format(selectedDate.value);
    }
  }

  // Function to get the formatted date (e.g., 24-10-2024)
  String getFormattedDate() {
    return DateFormat('dd-MM-yyyy').format(selectedDate.value);
  }


  //Send Order
 void createLead({
  required String address,
  required String addressId,
  required String pickupDate,
  required String latitude,
  required String longitude,
  required String placeType,
  required String userId,
  required List<Map<String, dynamic>> scrapItems,
}) async {
  try {
    showProgress(title: "Creating Lead...");
     
    // Prepare the base body with lead data
    Map<String, dynamic> body = {
      "address": address,
      "address_id": addressId,
      "pickup_date": pickupDate,
      "latitude": latitude,
      "longitude": longitude,
      "place_type": placeType,
      "user_id": userId,
      "order_progress":"1",
      "status":"1",
    };

      for (int i = 0; i < scrapItems.length; i++) {
      body["scrap_items[$i][scrap_name]"] = scrapItems[i]["scrap_name"].toString(); // Ensure scrap_name is a string
      body["scrap_items[$i][price]"] = scrapItems[i]["price"].toString(); // Ensure price is a string
    }
    // Send the request to the backend
    final response = await NetworkUtil.networkPost(
      '/lead/create',
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
      body: body,
    );
    
    closeProgress();
    
    final jsonResponse = jsonDecode(response.body);
    if (response.statusCode == 200 || response.statusCode == 201) {
      showSuccess(title: "Lead Created Successfully", message: jsonResponse["message"]);
      // Navigate to another screen if needed
       Get.to(MainScreen());
    } else {
      // Handle any errors from the response
      showError(title: "Error", message: jsonResponse["message"]);
    }
  } catch (e) {
    print("Error in  $e");
    closeProgress();
    showError(title: "Error", message: "Something went wrong.");
  }
}

// Pickup Requests
readLeadRequests() async {
  try {
    isLoading.value = true;

    // API Call
    final response = await NetworkUtil.networkGet(
      '/leads/read',
      null,
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
    );

    isLoading.value = false;

    // Parse response and group by category
    leadRequest.clear();
    leadRequest.addAll(leadRequestModelFromJson(jsonEncode(response.data['data']['orders'])));
    print("Length of leadsRequests ${leadRequest.length}");

  } catch (e) {
    isLoading.value = false;
    print('Error reading scrap list: $e');
  }
}

readOneLeadRequest({required String leadId}) async {
  try {
    isLoading.value = true;

    // API Call
    final response = await NetworkUtil.networkGet(
      '/lead/$leadId',
      null,
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
    );

    isLoading.value = false;
    print(response.data);
    print(response.statusCode);

    detailRequest.value = LeadRequestModel.fromJson(response.data['data']['order']);
    print("Detail Lead Request");

  } catch (e) {
    //isLoading.value = false;
    print('Error reading detail request: $e');
  }
}

readCancelReason() async {
  try {
    isLoading.value = true;

    // API Call
    final response = await NetworkUtil.networkGet(
      '/master-data/cancel-reasons/read',
      null,
      headers: {
        'Authorization': 'Bearer ${AppController.authToken}',
      },
    );

    isLoading.value = false;
    print(response.data);
    print(response.statusCode);

    cancelReason.clear();
    cancelReason.addAll(cancelReasonModelFromJson(jsonEncode(response.data['data'])));
    print("Length of leadsRequests ${cancelReason.length}");

  } catch (e) {
    //isLoading.value = false;
    print('Error reading detail request: $e');
  }
}


 }

