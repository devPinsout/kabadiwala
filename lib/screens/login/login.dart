import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});

  final TextEditingController _mobileController = TextEditingController();

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
                  "Type your mobile number",
                  style: TextStyle(
                    fontSize: 28.h,
                    fontWeight: FontWeight.bold,
                  ),
                  textScaler: TextScaler.linear(1.0),
                ),
                
                SizedBox(height: 30.h),
                TextFieldWithBorder(
                  controller: _mobileController,
                  hintText: "Enter Mobile Number",
                  hintStyle: TextStyle(
                    color: AppColors.hinttextColor,
                    fontSize: 17.sp,
                    fontFamily: 'Regular',
                  ),
                  borderColor: AppColors.blackColor,
                  borderRadius: 10.0,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter mobile number';
                    }
                    return null;
                  },
                ),

                SizedBox(height: 3.h,),
                Text("We will recognize existing customer",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
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
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BasicDetailScreen(),
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
