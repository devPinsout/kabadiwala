import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/utils/colors.dart';

class RateListCard extends StatelessWidget {
  final String scrapName;
  final String price;

  RateListCard({
    required this.scrapName,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4.r),
        border: Border.all(
          color: AppColors.blackColor,
          width: 1.w,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w, vertical: 10.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              scrapName,
              style: TextStyle(
                fontSize: 17.sp,
                fontWeight: FontWeight.bold,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
            SizedBox(height: 4.h),
            Text(
              "Rs. $price/Kg",
              style: TextStyle(
                fontSize: 15.sp,
                color: AppColors.greyColor,
              ),
              textScaler: TextScaler.linear(1.0),
            ),
          ],
        ),
      ),
    );
  }
}

  

    
  
