import 'package:flutter/material.dart';
import 'package:kabadiwala/screens/home/homeComponents/homeCategoryCard.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/commonLayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';

class RateListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CommonPageLayout(
      title: "Kabadiwala",
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Today's scrap price list",
                    style: TextStyle(
                        fontSize: 25.sp, fontWeight: FontWeight.bold),
                    textScaler: TextScaler.linear(1.0),
                  ),
                  SizedBox(height: 10.h),
                  Text(
                    "Price may fluctuate because of the recycling industry.",
                    style: TextStyle(fontSize: 15.sp, color: AppColors.greyColor),
                    textScaler: TextScaler.linear(1.0),
                  ),
                  SizedBox(height: 20.h),

                  TextField(
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.search, color: AppColors.primaryColor),
                      hintText: "Search any scrap items..",
                      hintStyle: TextStyle(
                        fontSize: 18.sp,
                        color: AppColors.greyColor,
                        fontWeight: FontWeight.normal
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor), // Underline color
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: AppColors.greyColor), // Color when focused
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),

            // Paper Category
            SliverToBoxAdapter(
              child: Text("Paper",style: TextStyle(fontSize: 18.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
            ),

            SliverToBoxAdapter(
              child: SizedBox(height: 5.h,),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 80.h, // Set height to limit the card height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Change this to the number of paper rate cards you have
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: RateListCard(), // Your rate list card widget
                    );
                  },
                ),
              ),
            ),

             SliverToBoxAdapter(
              child: SizedBox(height: 25.h,),
            ),

            // Plastic Category
            SliverToBoxAdapter(
              child: Text("Plastic",style: TextStyle(fontSize: 18.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
            ),

             SliverToBoxAdapter(
              child: SizedBox(height: 5.h,),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 80.h, // Set height to limit the card height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Change this to the number of plastic rate cards you have
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: RateListCard(), // Your rate list card widget
                    );
                  },
                ),
              ),
            ),

             SliverToBoxAdapter(
              child: SizedBox(height: 25.h,),
            ),

            // Metals Category
            SliverToBoxAdapter(
              child: Text("Metals",style: TextStyle(fontSize: 18.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
            ),

             SliverToBoxAdapter(
              child: SizedBox(height: 5.h,),
            ),

            SliverToBoxAdapter(
              child: SizedBox(
                height: 80.h, // Set height to limit the card height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Change this to the number of metal rate cards you have
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: RateListCard(), // Your rate list card widget
                    );
                  },
                ),
              ),
            ),


            SliverToBoxAdapter(
              child: SizedBox(height: 25.h,),
            ),

            // E-waste Category
            SliverToBoxAdapter(
              child: Text("E-waste",style: TextStyle(fontSize: 18.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
            ),

             SliverToBoxAdapter(
              child: SizedBox(height: 5.h,),
            ),


            SliverToBoxAdapter(
              child: SizedBox(
                height: 80.h, // Set height to limit the card height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Change this to the number of e-waste rate cards you have
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: RateListCard(), // Your rate list card widget
                    );
                  },
                ),
              ),
            ),

             SliverToBoxAdapter(
              child: SizedBox(height: 25.h,),
            ),

            // Other Items Category
            SliverToBoxAdapter(
              child: Text("Other items",style: TextStyle(fontSize: 18.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
            ),

             SliverToBoxAdapter(
              child: SizedBox(height: 5.h,),
            ),


            SliverToBoxAdapter(
              child: SizedBox(
                height: 80.h, // Set height to limit the card height
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 5, // Change this to the number of other rate cards you have
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: EdgeInsets.only(right: 10.w),
                      child: RateListCard(), // Your rate list card widget
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
