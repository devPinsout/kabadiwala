import 'package:flutter/material.dart';
import 'package:kabadiwala/screens/home/homeComponents/homeCategoryCard.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/commonLayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrap.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonPageLayout(
      title: "Kabadiwala",
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Good evening, Shalini",
                  style: TextStyle(fontSize: 18.sp),
                  textScaler: TextScaler.linear(1.0),
                ),
                SizedBox(height: 10.h),
                Text(
                  "What would you like to sell?",
                  style: TextStyle(
                      fontSize: 25.sp, fontWeight: FontWeight.bold),
                  textScaler: TextScaler.linear(1.0),
                ),
                SizedBox(height: 10.h),

                // Grid of categories
                Expanded(
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 30.h,
                      childAspectRatio: 0.74,
                    ),
                    itemCount: 5,
                     itemBuilder: (context, index) {
                  return HomeCategoryCard(index: index); // Pass the index
                },
                  ),
                ),
              ],
            ),
          ),

          // Positioned button at the bottom
          Positioned(
            bottom: 20.h,
            left: 20.w,
            right: 20.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("We do not pickup wood, cloth and glass",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                
                SizedBox(height: 5.h,),

                CustomElevatedButton(
                  width: double.infinity,
                  height: 50.h,
                  text: "Raise pickup request",
                  textSize: 18.sp,
                  buttonColor: AppColors.primaryGradient,
                  onPressed: () async {
                    // final prefs = await SharedPreferences.getInstance();
                    // prefs.setBool("welcome", true);
                    // if(!mounted)return;
                
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SellScrapScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
     
      
      );
      
     
  }
}
