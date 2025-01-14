import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/authController.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class OtpScreen extends StatelessWidget {
  OtpScreen({super.key});

  final TextEditingController _otpController = TextEditingController();
   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
     final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
 
  AuthController authController = Get.put(AuthController(), permanent: true);



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 10.h),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 Image.asset("assets/images/logo-kabad2.png",height: 50.h,width: 100.w,),
                  SizedBox(height: 40.h),
                  Text(
                    "Type your OTP",
                    style: TextStyle(
                      fontSize: 28.h,
                      fontWeight: FontWeight.bold,
                    ),
                    textScaler: TextScaler.linear(1.0),
                  ),
                  
                SizedBox(height: 30.h),
                 Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                   children: [
                     OtpTextField(
                     numberOfFields: 6,
                                   borderColor: Color(0xFF512DA8),
                                   showFieldAsBox: true, 
                                   fieldWidth: 40.w,
                     onCodeChanged: (String code) {
                                 //handle validation or checks here           
                                  },
                                  //runs when every textfield is filled
                                 onSubmit: (String verificationCode) {
                          _otpController.text = verificationCode;  // Set the OTP in the controller
                        },
                         ),
                   ],
                 ),
                  SizedBox(height: 3.h,),
                  Text("We have sent OTP to your mobile number.",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                ],
              ),
          
              CustomElevatedButton(
                width: double.maxFinite,
                height: 50.h,
                text: "Continue",
                textSize: 18.sp,
                buttonColor: AppColors.primaryGradient,
                onPressed: () async{
                   authController.verifyOtp(
                                    otp: _otpController.text,
                                    value: authController.mobileNumber.value,
                                    mode: "mobile"
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
