import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/utils/colors.dart';

class HomeCategoryCard extends StatelessWidget {
   final int index;
  HomeCategoryCard({required this.index,super.key});
  

  final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
 

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
       
        return GestureDetector(
           onTap: () {
            controller.toggleSelection(index); // Toggle the selected state when tapped
          },
          child: Container(
            child: Column(
              children: [
                Container(
                  
                  decoration: BoxDecoration(
                    color: controller.selectedCards[index]
                  ? AppColors.backgroundColor
                  : Colors.white,
                                    borderRadius: BorderRadius.circular(4.r),
                                   border: Border.all(
                                  
                                    color: controller.selectedCards[index]
                                   ? AppColors.primaryColor 
                                   : AppColors.blackColor, 
                                    width: 1.w, // Border width
                                ),),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                    child: Column(
                      children: [
                        Image.asset("assets/images/paper.png",height: 60.h,width: 60.w,),
                        SizedBox(height: 4.h,),
                        Text("Paper",style: TextStyle(fontSize: 16.sp),)
                      ],
                    ),
                  ),
                ),
            
                Expanded(child: Text("Newspaper, Books, Cartons",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),))
              ],
            ),
          ),
        );
      }
    );
  }
}