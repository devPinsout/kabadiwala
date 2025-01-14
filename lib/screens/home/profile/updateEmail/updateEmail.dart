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

class UpdateEmailScreen extends StatelessWidget {
  UpdateEmailScreen({super.key});

  final TextEditingController _emailController = TextEditingController();
   final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
     _emailController.text = AppController.userDetails.value.email ?? '';
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
                    AppController.userDetails.value.email != null ?"Update you email":"Add your email",
                    style: TextStyle(
                      fontSize: 28.h,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaler: TextScaler.linear(1.0),
                  ),
                  
                  SizedBox(height: 30.h),
                  TextFieldWithBorder(
                     controller: _emailController,
                    hintText: "Enter your email",
                    hintStyle: TextStyle(
                      color: AppColors.hinttextColor,
                      fontSize: 17.sp,
                      fontFamily: 'Regular',
                    ),
                    borderColor: AppColors.blackColor,
                    borderRadius: 10.0,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
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
                            firstName: AppController.userDetails.value.firstName ?? '',     
                            lastName: AppController.userDetails.value.lastName ?? '',   
                            email:  _emailController.text,     
                            imageid: AppController.userDetails.value.profileImg.toString() ?? '',                               
                            );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
