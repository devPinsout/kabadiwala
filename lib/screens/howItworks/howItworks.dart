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

class HowItWorksScreen extends StatelessWidget {
  HowItWorksScreen({super.key});

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
              "How Scrap Adda works ?",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
              textScaler: TextScaler.linear(1.0),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 20.h),
          child: Column(
            children: [
              Text("Sell your scrap in 4 easy steps.",style: TextStyle(fontSize: 20.sp),textScaler: TextScaler.linear(1.0),),
        
              SizedBox(height: 25.h,),
        
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/selectScrap.png",height: 80.h,width: 80.w,),
        
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("1.",style: TextStyle(fontSize: 20.sp,),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 3.h,),
                        Text("Select scrap items for selling",style: TextStyle(fontSize: 18.sp,),textScaler: TextScaler.linear(1.0)),
                        SizedBox(height: 3.h,),
                         Text("We collect scrap from wide list of items like Newspaper, Iron, Electronic machine, Beer Bottle etc. We do not pick up cloth, wood and glass.",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0))
                      ],
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 25.h,),
        
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/Calendar.png",height: 80.h,width: 80.w,),
        
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("2.",style: TextStyle(fontSize: 20.sp,),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 3.h,),
                        Text("Choose a date for scrap pickup",style: TextStyle(fontSize: 18.sp,),textScaler: TextScaler.linear(1.0)),
                        SizedBox(height: 3.h,),
                         Text("Choose a date when you want our executives to come for scrap pickup. You can book a request for the next day. Our pickup time will be between 10 am to 6 pm.",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0))
                      ],
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 25.h,),
        
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/selectScrap.png",height: 80.h,width: 80.w,),
        
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("3.",style: TextStyle(fontSize: 20.sp,),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 3.h,),
                        Text("Pickup boys will arrive at your home",style: TextStyle(fontSize: 18.sp,),textScaler: TextScaler.linear(1.0)),
                        SizedBox(height: 3.h,),
                         Text("Our pickup executives will call you 1 hour before coming. They will bring an electronic machine to weigh each scrap item separately.",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0))
                      ],
                    ),
                  ),
                ],
              ),
        
              SizedBox(height: 25.h,),
        
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset("assets/images/selectScrap.png",height: 80.h,width: 80.w,),
        
                  SizedBox(width: 8.w,),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("4.",style: TextStyle(fontSize: 20.sp,),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 3.h,),
                        Text("Scrap sold :)",style: TextStyle(fontSize: 18.sp,),textScaler: TextScaler.linear(1.0)),
                        SizedBox(height: 3.h,),
                         Text("You will get a bill on your mobile and the amount will be transferred to your bank account immediately. The rates are non-negotiable, please check the rates before booking a pickup request.",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0))
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      )
    );
  }
}
