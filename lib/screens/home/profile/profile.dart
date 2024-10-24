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

class ProfileScreen extends StatelessWidget {
  ProfileScreen({super.key});

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
                  "Profile",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
                  textScaler: TextScaler.linear(1.0),
                ),

                SizedBox(width: 10.w,),

                Icon(Icons.person_2_outlined,color: AppColors.whiteColor,size: 25.sp,),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
           Padding(
             padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
             child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                     
                Row(
                  children: [
                     
                    Container(
                      height: 70.h,
                      width: 70.w,
                       padding: EdgeInsets.all(10.w), 
                       decoration: BoxDecoration(
                        color: AppColors.backgroundColor, 
                        border: Border.all(
                        color: AppColors.primaryColor, 
                        width: 2.0, 
                      ),
                      borderRadius: BorderRadius.circular(70.r), 
                      ),
                    child: Icon(
                      Icons.upload_file_outlined,
                       color: AppColors.primaryColor,
                       size: 40.sp,
                     ),
                  ),
                     
                    SizedBox(width: 5.w,),
                    Text("Dev",style: TextStyle(fontSize: 20.sp,),textScaler: TextScaler.linear(1.0),),
                     
                  ],
                ),
                
                SizedBox(width: 10.w,),
                     
                Text("Change",style: TextStyle(fontSize: 18.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
              ],
             ),
           ),

           SizedBox(height: 15.h,),

           Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Mobile number",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor,fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1.0),),

                          SizedBox(height: 4.h,),
                          Text("8130785678",style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0))
                        ],
                      ),

                      SizedBox(width: 20.w,),
                      Text("Change",style: TextStyle(fontSize: 17.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
                    ],
                  ),

                  SizedBox(height: 20.h,),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Email",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor,fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1.0)),
                          SizedBox(height: 4.h,),
                          Text("N/A",style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0))
                        ],
                      ),

                      SizedBox(width: 20.w,),

                      Text("Add",style: TextStyle(fontSize: 17.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0))
                    ],
                  )
                ],
              ),
              ),
           ),

           Padding(padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
           
           child: Text("Pickup address",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),),

            Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                  Icon(Icons.location_on_outlined,size: 25.sp,color: AppColors.primaryColor,),
                  SizedBox(width: 5.w,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("House - Default",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor,fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1.0),),
                                  
                        SizedBox(height: 4.h,),
                        Text("103, Railway Colony, Lucknow",style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0))
                      ],
                    ),
                  ),
              
                    ],
                  ),
                  
                  SizedBox(width: 20.w,),
                  Text("Change",style: TextStyle(fontSize: 17.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
                ],
              ),
              ),
           ),

           Padding(padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
           
           child: Text("Money acceptance mode",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),),

            Container(
            color: AppColors.whiteColor,
            child: Padding(
              padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(Icons.payment_outlined,size: 25.sp,color: AppColors.primaryColor,),
                  SizedBox(width: 5.w,),
                  Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("No Payment Method selected",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor,),textScaler: TextScaler.linear(1.0),),
                        ],
                    ),
                  ),
                  
                  SizedBox(width: 20.w,),
                  Text("Manage",style: TextStyle(fontSize: 17.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
                ],
              ),
              ),
           ),
          ],
        ),
      )
    );
  }
}
