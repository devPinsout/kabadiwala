import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/utils/colors.dart';

class RateListCard extends StatelessWidget {
  RateListCard({super.key});
  

  final AppController controller = (Get.isRegistered<AppController>())?Get.find<AppController>():Get.put(AppController());
 

  @override
  Widget build(BuildContext context) {
    return  Container(
      
      decoration: BoxDecoration(
      
                        borderRadius: BorderRadius.circular(4.r),
                       border: Border.all(
                      
                        color: AppColors.blackColor, 
                        width: 1.w, // Border width
                    ),),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 25.w,vertical: 10.h),
        child: Column(
          children: [
            
           
            Text("Newspaper",style: TextStyle(fontSize: 17.sp,fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1.0),),
             SizedBox(height: 4.h,),
             Text("Rs. 10/Kg")
          ],
        ),
      ),
    );
    
    
    
  }
}