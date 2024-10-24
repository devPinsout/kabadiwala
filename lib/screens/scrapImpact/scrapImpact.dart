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

class ScrapImpactScreen extends StatelessWidget {
  ScrapImpactScreen({super.key});

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
              "Scrap Impact",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
              textScaler: TextScaler.linear(1.0),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right: 10.w),
                child: Icon(Icons.recycling,color: AppColors.whiteColor,),
              )
            ],
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 30.w,vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your contribution of 0 Kg scrap has helped our environment.",style: TextStyle(fontSize: 20.sp),textScaler: TextScaler.linear(1.0),),
            
            SizedBox(height: 20.h,),
            
             ListTile(
              leading: Image.asset("assets/images/tree1-removebg.png"),
              title: Text('0',style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
              subtitle: Text("Trees saved",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),),
            ),

             ListTile(
              leading: Image.asset("assets/images/tree1-removebg.png"),
              title: Text('0',style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
              subtitle: Text("Trees saved",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),),
            ),

            ListTile(
              leading: Image.asset("assets/images/tree1-removebg.png"),
              title: Text('0',style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
              subtitle: Text("Trees saved",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),),
            ),

            ListTile(
              leading: Image.asset("assets/images/tree1-removebg.png"),
              title: Text('0',style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
              subtitle: Text("Trees saved",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),),
            ),

            ListTile(
              leading: Image.asset("assets/images/tree1-removebg.png"),
              title: Text('0',style: TextStyle(fontSize: 18.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
              subtitle: Text("Trees saved",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),),
            ),
          ],
        ),
      )
    );
  }
}
