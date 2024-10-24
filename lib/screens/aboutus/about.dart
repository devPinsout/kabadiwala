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

class AboutScreen extends StatelessWidget {
  AboutScreen({super.key});

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
                  "Who we are",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
                  textScaler: TextScaler.linear(1.0),
                ),

                SizedBox(width: 10.w,),

                Image.asset("assets/images/logo-kabad2.png",height: 70.h,width: 70.w,)
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Text("The Scrap Adda is a doorstep service intends to help out people to sell their household scrap like Newspaper, iron, plastic book, copies, metal etc. and get paid for it.",style: TextStyle(
                fontSize: 17.sp
               ),textScaler: TextScaler.linear(1.0),),
             
               SizedBox(height: 25.h,),

                Text("The Scrap Adda is a doorstep service intends to help out people to sell their household scrap like Newspaper, iron, plastic book, copies, metal etc.",style: TextStyle(
                  fontSize: 17.sp,
                ),textScaler: TextScaler.linear(1.0),),
             
             ],
          ),
        ),
      )
    );
  }
}
