import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/leadController.dart';
import 'package:kabadiwala/utils/colors.dart';

class SelectScrapCard extends StatelessWidget {
  final String scrapName;
  final String price;

final LeadController leadController = (Get.isRegistered<LeadController>()) ? Get.find<LeadController>() : Get.put(LeadController());

  SelectScrapCard({
    required this.scrapName,
    required this.price,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      // Check if the card is selected
      bool isSelected = leadController.isSelected(scrapName);

      return GestureDetector(
        onTap: () {
          // Toggle the selection when tapped
          leadController.toggleScrap(scrapName, price);
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : AppColors.blackColor,
              width: 1.w,
            ),
            color: isSelected ? AppColors.primaryColor.withOpacity(0.2) : Colors.transparent,
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
                    color: isSelected ? AppColors.primaryColor : AppColors.blackColor,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  "Rs. $price/Kg",
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: isSelected ? AppColors.primaryColor : AppColors.greyColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    });
  }
}