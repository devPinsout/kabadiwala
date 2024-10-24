import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapDate.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';

class SellScrapConfirmationScreen extends StatelessWidget {
  SellScrapConfirmationScreen({super.key});

  final TextEditingController _instructionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
                  "Sell Scrap",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
                  textScaler: TextScaler.linear(1.0),
                ),

                 SizedBox(width: 10.w,),

                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 17.sp),
                    textScaler: TextScaler.linear(1.0),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
              child: Text(
                          "Pickup confirmation",
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                          textScaler: TextScaler.linear(1.0),
                        ),
            ),
           
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
              color: AppColors.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Scrap items",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 5.h,),
                        Text("Newspaper",style: TextStyle(fontSize: 17.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 5.h,),
                        Text("Rs.10/kg",style: TextStyle(fontSize: 20.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),)
                      ],
                    ),
                  ),

                  SizedBox(width: 5.w,),
                  Text("Change",style: TextStyle(fontSize: 16.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
                ],

              ),
            ),

            SizedBox(height: 10.h,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Address - Home",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                            SizedBox(height: 5.h,),
                            Text("103, Railway Coloney, Luccknow",style: TextStyle(fontSize: 17.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
                            ],
                        ),
                      ),
                  
                      SizedBox(width: 5.w,),
                      Text("Change",style: TextStyle(fontSize: 16.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
                    ],
                  
                  ),

                  SizedBox(height: 10.h,),

                  Container(
                    height: 200.h,
                    width: double.maxFinite,
                    child: Image.asset("assets/images/maps.png",fit: BoxFit.fill,),
                    )
                ],
              ),
            ),

            SizedBox(height: 10.h,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
              color: AppColors.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pickup",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 5.h,),
                        Text("Tomorrow, 24 October 2024",style: TextStyle(fontSize: 17.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 5.h,),
                        Text("10 AM - 6 PM",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),)
                      ],
                    ),
                  ),

                  SizedBox(width: 5.w,),
                  Text("Change",style: TextStyle(fontSize: 16.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
                ],

              ),
            ),

            SizedBox(height: 10.h,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text("Any instructions",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor,fontWeight: FontWeight.w600),textScaler: TextScaler.linear(1.0),),
              ),

              SizedBox(height: 10.h,),

              Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFieldWithBorder(controller: _instructionController, 
              hintText: "Any instructions for our pickup...."),
              ),

              SizedBox(height: 20.h,),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomElevatedButton(
                  width: double.maxFinite,
                  height: 50.h,
                  text: "Continue",
                  textSize: 18.sp,
                  buttonColor: AppColors.primaryGradient,
                  onPressed: () async {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MainScreen(),
                      ),
                    );
                  },
                ),
            ),
          ],
        ),
      )
    );
  }
}
