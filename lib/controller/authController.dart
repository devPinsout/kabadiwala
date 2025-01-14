// auth_controller.dart
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/models/userModel.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/login/otpScreen.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/services/network.dart';
import 'package:kabadiwala/utils/common.dart';
import 'package:shared_preferences/shared_preferences.dart';





class AuthController extends GetxController {
  // AuthController() {
  //   init(); 
  // }
 String fcmToken = '';
  RxBool isLoading = false.obs;
  RxBool isSignedUp = false.obs;
  RxString mobileNumber = RxString('');
 

  void signup({
    required String mobile,
  }) async {
    try {
    showProgress(title: "Signing...");
     
      // call the signup api
        final body = {
         "mobile": mobile,
          "role": '2',
        };
    final response = await NetworkUtil.networkPost('/app-users/create',body: body);
    
   closeProgress();
    final jsonResponse = jsonDecode(response.body);
    if(response.statusCode == 200 || response.statusCode == 201)
    {
      mobileNumber.value= mobile;
      showSuccess(title: "SignUp Successfully", message: jsonResponse["message"]);
      //Navigate to otp screen
      Get.to(OtpScreen());
    }
    else if (response.statusCode == 402 || response.statusCode == 422){
      sendOtp("mobile", mobile);
      debugPrint(response.body);
      final errors = jsonResponse["data"];
      if(errors["mobile"]!=null)
      {
      showError(title: "Error Code ${response.statusCode}", message: errors["mobile"][0]); 
      }else if(errors["email"]!=null){
  showError(title: "Error Code ${response.statusCode}", message: errors["email"][0]); 
    
      }else{
showError(title: "Error Code ${response.statusCode}", message: jsonResponse["message"]);
      
      }
     } else{
      debugPrint(response.body);
      showError(title: "Error Code ${response.statusCode}", message: jsonResponse["message"]??"");

       }
      } finally {
        
  //  closeProgress();
    }
  }

  verifyOtp({required String otp,required String value, required String mode}) async{


    showProgress(title: "Loading...");
    final response = await NetworkUtil.networkPost('/verifyOtp',
    body: {
          "otp": otp,
          "value": value,
          "mode": mode,
          "fcm_token":fcmToken,
        }
    );
    final jsonResponse = jsonDecode(response.body);
    closeProgress();
    String? firstName;
    if(response.statusCode == 200 || response.statusCode == 201)
    {
      if(jsonResponse["data"]['token']!=null)
      {
        //create session
      createSession(jsonResponse["data"]);
      firstName = jsonResponse["data"]['user']['first_name'];
      print("First Name of the user is: ${firstName}");
      
      }
      showSuccess(title: "Otp Verified Successfully", message: jsonResponse["message"]);
      if(firstName == null || firstName.isEmpty){
        Get.to(BasicDetailScreen());
        print("First Name: $firstName");  // Check the value here

      }
      else{
         Get.to(MainScreen());
      }
     
     
    }
    else if (response.statusCode == 402 || response.statusCode == 422){
      debugPrint(response.body);
     
      showError(title: "Error Code ${response.statusCode}", message: jsonResponse['data']); 
     
     } else{
      debugPrint(response.body);
      showError(title: "Error Code ${response.statusCode}", message: jsonResponse["message"]??"");

       }
      } 

      
    
     
  sendOtp(String mode, String value,{ bool redirect=true}) async{
    
    
    showProgress(title: "Loading...");
     final response = await NetworkUtil.networkPost('/sendOtp',
    body: {
          "value": value,
          "mode": mode,
        }
    );
    final jsonResponse = jsonDecode(response.body);
    closeProgress();
    if(response.statusCode == 200 || response.statusCode == 201){
      print(jsonResponse["message"]);
      showSuccess(title: "OTP Sent Successfully", message: jsonResponse["message"]);
      if(redirect)
      {
      if(mode=="mobile")
      {
      
      mobileNumber.value= value;
      
        Get.to(()=> OtpScreen());
      }else if (mode =="email")
      {
        
        // Get.to(()=> EmailOtpPage());
      }
      }
  
    }
    else{
      debugPrint("Email verification failed"+response.body);
      showError(title: "Error Sending OTP", message: jsonResponse["message"] ?? "");
  
    }
    
   
  }




  createSession(sessionData)
  async {
    //session data will have token and userData
    debugPrint("token: "+sessionData["token"]);
    debugPrint("user: "+jsonEncode(sessionData["user"]));
   final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isLoggedIn', true); // Set the user as logged in
    prefs.setString('token', sessionData["token"]); // Set the user as logged in
    prefs.setString('user', jsonEncode(sessionData["user"])); // Set the user as logged in
    AppController controller=(!Get.isRegistered<AppController>())?Get.put(AppController(), permanent: true):Get.find<AppController>();
    controller.currentNavIndex.value=0;
    AppController.userDetails.value = userModelFromJson(jsonEncode(sessionData["user"]));
    AppController.authToken.value = sessionData["token"];
     await _verifyStoredData();
  }

  // Method to verify if data is saved correctly
  Future<void> _verifyStoredData() async {
    final prefs = await SharedPreferences.getInstance();

    bool? isLoggedIn = prefs.getBool('isLoggedIn');
    String? token = prefs.getString('token');
    String? user = prefs.getString('user');

    debugPrint("Verification - isLoggedIn: $isLoggedIn");
    debugPrint("Verification - token: $token");
    debugPrint("Verification - user: $user");

    if (isLoggedIn == true && token != null && user != null) {
      debugPrint("Data successfully saved to SharedPreferences.");
    } else {
      debugPrint("Error saving data to SharedPreferences.");
    }
  }

  Future<void> saveUserDetails(String name, String email, String mobile, String referralCode) async {
    // Use shared_preferences to store user details
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('name', name);
    prefs.setString('email', email);
    prefs.setString('mobile', mobile);
    prefs.setString('referralCode', referralCode);
    prefs.setBool('isLoggedIn', true); // Set the user as logged in
  }

  Future<Map<String, String>> getUserDetails() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name') ?? '';
    final email = prefs.getString('email') ?? '';
    final mobile = prefs.getString('mobile') ?? '';
    final referralCode = prefs.getString('referralCode') ?? '';

    return {'name': name, 'email': email, 'mobile': mobile, 'referralCode': referralCode};
  }

    Future<bool> isLoggedIn() async {
    try {
     //showProgress(title: "Updating...");
    final prefs = await SharedPreferences.getInstance();
    
  //    bool isFirstTime = prefs.getBool('isFirstTime') ?? true;
  //   if(isFirstTime){
  //    prefs.setBool('isFirstTime', false);
  //    Get.to(WelcomeScreen());
  //  }
    
    String user = prefs.getString('user')??"";
    
    AppController controller=(!Get.isRegistered<AppController>())?Get.put(AppController(), permanent: true):Get.find<AppController>();
    // controller.currentNavIndex.value=0;
    // final response = NetworkUtil.networkGet('/advisor-accounts/');
    print(user.runtimeType);
    final userDecoded = jsonDecode(user);
    print(userDecoded["first_name"]);
    AppController.userDetails.value = userModelFromJson(user);
    AppController.authToken.value = prefs.getString('token')??"";
    //closeProgress();
    return prefs.getBool('isLoggedIn') ?? false;
   
    } catch (e) {
      print("Error ${e}");
      return false;  
    }}

    Future<void> loadUserDataFromPreferences() async {
  final prefs = await SharedPreferences.getInstance();
  final storedToken = prefs.getString('token');
  final storedUser = prefs.getString('user');

  if (storedToken != null && storedUser != null) {
    AppController.authToken.value = storedToken;
    AppController.userDetails.value = userModelFromJson(storedUser);
    print("Loaded user data from SharedPreferences successfully.");
  } else {
    print("No user data found in SharedPreferences.");
  }
}


  
}
