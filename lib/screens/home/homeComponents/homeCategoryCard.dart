import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/models/scrapListModel.dart';
import 'package:kabadiwala/services/network.dart';
import 'package:kabadiwala/utils/colors.dart';

class HomeCategoryCard extends StatelessWidget {
  final ScrapListModel scrapCategory;

  HomeCategoryCard({required this.scrapCategory, super.key});

  final AppController controller = Get.find<AppController>(); // GetX controller

  

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Toggle selection when card is tapped
        controller.toggleCategory(scrapCategory.id.toString());
      },
      child: Obx(() {
        // Only rebuild the parts of the UI that depend on `tempSelectedCategories`
        bool isSelected = controller.tempSelectedCategories.contains(scrapCategory.id.toString());

        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(4.r),
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : AppColors.blackColor,
              width: isSelected?2.w:1.w,
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: Column(
              children: [
                Image.network(
                  NetworkUtil.imageUrl + '/storage/app/' + scrapCategory.url.toString(),
                  height: 60.h,
                  width: 60.w,
                ),
                SizedBox(height: 4.h),
                Text(
                  scrapCategory.categoryName ?? '',
                  style: TextStyle(fontSize: 16.sp),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
