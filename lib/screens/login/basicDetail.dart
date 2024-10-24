import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/login/otpScreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';

class BasicDetailScreen extends StatelessWidget {
  BasicDetailScreen({super.key});

  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
               Image.asset("assets/images/logo-kabad2.png",height: 50.h,width: 100.w,),
                SizedBox(height: 40.h),
                Text(
                  "What's your name?",
                  style: TextStyle(
                    fontSize: 28.h,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: TextScaler.linear(1.0),
                ),
                
                SizedBox(height: 30.h),
                TextFieldWithBorder(
                  controller: _nameController,
                  hintText: "Enter your name",
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

            CustomElevatedButton(
              width: double.maxFinite,
              height: 50.h,
              text: "Continue",
              textSize: 18.sp,
              buttonColor: AppColors.primaryGradient,
              onPressed: () async{
                // final prefs = await SharedPreferences.getInstance();
                // prefs.setBool("welcome", true);
                // if(!mounted)return;
              
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OtpScreen(),
                  ),
                );
              },
            ),
            
          ],
        ),
      ),
    );
  }
}
