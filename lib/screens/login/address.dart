import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/authController.dart';
import 'package:kabadiwala/screens/login/otpScreen.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';

class AddressScreen extends StatelessWidget {
  AddressScreen({super.key});

  final TextEditingController _streetController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();
  final TextEditingController _stateController = TextEditingController();
   final TextEditingController _pincodeController = TextEditingController();
   final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Image.asset("assets/images/logo-kabad2.png",height: 50.h,width: 100.w,),
                    SizedBox(height: 40.h),
                    Text(
                      "What's your address?",
                      style: TextStyle(
                        fontSize: 28.h,
                        fontWeight: FontWeight.bold,
                      ),
                      textScaler: TextScaler.linear(1.0),
                    ),
                    
                    SizedBox(height: 30.h),
                    TextFieldWithBorder(
                       controller: _streetController,
                      hintText: "Enter street",
                      hintStyle: TextStyle(
                        color: AppColors.hinttextColor,
                        fontSize: 17.sp,
                        fontFamily: 'Regular',
                      ),
                      borderColor: AppColors.blackColor,
                      borderRadius: 10.0,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your street';
                        }
                        return null;
                      },
                    ),
          
                    SizedBox(height: 10.h,),
          
                    TextFieldWithBorder(
                       controller: _cityController,
                      hintText: "Enter city name",
                      hintStyle: TextStyle(
                        color: AppColors.hinttextColor,
                        fontSize: 17.sp,
                        fontFamily: 'Regular',
                      ),
                      borderColor: AppColors.blackColor,
                      borderRadius: 10.0,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter city name';
                        }
                        return null;
                      },
                    ),
                     SizedBox(height: 10.h,),
          
                    TextFieldWithBorder(
                       controller: _stateController,
                      hintText: "Enter state name",
                      hintStyle: TextStyle(
                        color: AppColors.hinttextColor,
                        fontSize: 17.sp,
                        fontFamily: 'Regular',
                      ),
                      borderColor: AppColors.blackColor,
                      borderRadius: 10.0,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter state name';
                        }
                        return null;
                      },
                    ),
          
                     SizedBox(height: 10.h,),
          
                    TextFieldWithBorder(
                       controller: _pincodeController,
                      hintText: "Enter pincode name",
                      hintStyle: TextStyle(
                        color: AppColors.hinttextColor,
                        fontSize: 17.sp,
                        fontFamily: 'Regular',
                      ),
                      borderColor: AppColors.blackColor,
                      borderRadius: 10.0,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter pincode';
                        }
                        return null;
                      },
                    ),
                    ],
                ),
              ),

              SizedBox(height: 20.h,),
          
              CustomElevatedButton(
                width: double.maxFinite,
                height: 50.h,
                text: "Continue",
                textSize: 18.sp,
                buttonColor: AppColors.primaryGradient,
                onPressed: () async{
                  controller.createAddress(
                               userId: AppController.userDetails.value.id.toString(),
                              street: _streetController.text,     
                              city: _cityController.text, 
                              state: _stateController.text,     
                              pincode: _pincodeController.text                              
                              );
                },
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
