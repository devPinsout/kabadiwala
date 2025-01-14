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

class UpdateNameScreen extends StatelessWidget {
  UpdateNameScreen({super.key});

  final TextEditingController _firstNameController = TextEditingController();
final TextEditingController _lastNameController = TextEditingController();
   final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
     _firstNameController.text = AppController.userDetails.value.firstName ?? '';
     _lastNameController.text = AppController.userDetails.value.lastName ?? '';
    
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
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
                    "Update your name",
                    style: TextStyle(
                      fontSize: 28.h,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaler: TextScaler.linear(1.0),
                  ),
                  
                  SizedBox(height: 30.h),
                  TextFieldWithBorder(
                     controller: _firstNameController,
                    hintText: "Enter your first name",
                    hintStyle: TextStyle(
                      color: AppColors.hinttextColor,
                      fontSize: 17.sp,
                      fontFamily: 'Regular',
                    ),
                    borderColor: AppColors.blackColor,
                    borderRadius: 10.0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: 10.h,),

                  TextFieldWithBorder(
                     controller: _lastNameController,
                    hintText: "Enter your last name",
                    hintStyle: TextStyle(
                      color: AppColors.hinttextColor,
                      fontSize: 17.sp,
                      fontFamily: 'Regular',
                    ),
                    borderColor: AppColors.blackColor,
                    borderRadius: 10.0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  ],
              ),
            ),

            CustomElevatedButton(
              width: double.maxFinite,
              height: 50.h,
              text: "Update",
              textSize: 18.sp,
              buttonColor: AppColors.primaryGradient,
              onPressed: () async{
                controller.updateProfile(
                            firstName: _firstNameController.text,     
                            lastName: _lastNameController.text,   
                            email: AppController.userDetails.value.email ?? '',   
                            imageid: AppController.userDetails.value.profileImg ?? '',                                 
                            );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
