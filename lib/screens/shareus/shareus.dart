import 'package:flutter/cupertino.dart';
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

class ShareusScreen extends StatelessWidget {
  ShareusScreen({super.key});

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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Share us",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
                  textScaler: TextScaler.linear(1.0),
                ),

                SizedBox(width: 10.w,),

                Icon(Icons.share,size: 25.sp,color: AppColors.whiteColor,)
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
             Column(
               children: [
                 Text("Ask your friends to sell their scrap with us.",style: TextStyle(
                  fontSize: 20.sp,fontWeight: FontWeight.w600
                 ),textScaler: TextScaler.linear(1.0),),
      
                 
             SizedBox(height: 25.h,),
             
      
              Text("Now sell your scrap easily from your doorsteps with the scrap adda. Download our app and raise a pickup request.",style: TextStyle(
                fontSize: 15.sp,color: AppColors.greyColor
              ),textScaler: TextScaler.linear(1.0),),

              SizedBox(height: 20.h,),

              Image.asset("assets/images/share.png")
      
               ],
             ),
           
            CustomElevatedButton(
            width: double.maxFinite,
            height: 50.h,
            text: "Share us",
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
