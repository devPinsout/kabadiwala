import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';

class PickupRequestScreen extends StatelessWidget {
  PickupRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text(
              "Pickup requests",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
              textScaler: TextScaler.linear(1.0),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 60.w,vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/pickup.png"),
            SizedBox(height: 20.h,),
            Text("You have not raised any request till now.",style: TextStyle(fontSize: 18.sp),textScaler: TextScaler.linear(1.0),textAlign: TextAlign.center,),
            
            SizedBox(height: 20.h,),
            
            CustomElevatedButton(
              width: double.maxFinite,
              height: 50.h,
              text: "Raise pickup request",
              textSize: 18.sp,
              buttonColor: AppColors.primaryGradient,
              onPressed: () async{
                // final prefs = await SharedPreferences.getInstance();
                // prefs.setBool("welcome", true);
                // if(!mounted)return;
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
              },
            ),
            
          ],
        ),
      )
    );
  }
}
