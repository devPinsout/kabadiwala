import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/screens/mainscreen/commonLayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:shimmer/shimmer.dart';

class RateListScreen extends StatelessWidget {
  final AppController controller = (Get.isRegistered<AppController>())
      ? Get.find<AppController>()
      : Get.put(AppController());
  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    controller.readScrapList();
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
                    style:
                        TextStyle(fontSize: 15.sp, color: AppColors.greyColor),
                    textScaler: TextScaler.linear(1.0),
                  ),
                  SizedBox(height: 20.h),
                  TextField(
                    controller: searchController,
                    onChanged: (search) {
                      controller.readScrapList(searchPhrase: search);
                    },
                    decoration: InputDecoration(
                      prefixIcon:
                          Icon(Icons.search, color: AppColors.primaryColor),
                      hintText: "Search any scrap items..",
                      hintStyle: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.greyColor,
                          fontWeight: FontWeight.normal),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.greyColor), // Underline color
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(
                            color: AppColors.greyColor), // Color when focused
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                ],
              ),
            ),

            // Wrap the dynamic category and rate list in Obx
            Obx(() {
              if (controller.groupedScrapList.isNotEmpty) {

                
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final group = controller.groupedScrapList[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Category Name
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 8.h),
                          child: Text(
                            group.categoryName,
                            style: TextStyle(
                              fontSize: 18.sp,
                              color: AppColors.greyColor,
                            ),
                            textScaler: TextScaler.linear(1.0),
                          ),
                        ),
                        SizedBox(height: 5.h),

                        // Horizontal Rate List
                        SizedBox(
                          height: 80.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: group.scrapItems.length,
                            itemBuilder: (context, scrapIndex) {
                              final scrapItem = group.scrapItems[scrapIndex];
                              return Padding(
                                padding: EdgeInsets.only(right: 10.w),
                                child: RateListCard(
                                  scrapName: scrapItem.scrapName ?? "Unknown",
                                  price: scrapItem.price?.toStringAsFixed(2) ??
                                      "N/A",
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 25.h),
                      ],
                    );
                  },
                  childCount: controller.groupedScrapList.length,
                ),
              );

              
              }
              else if(controller.groupedScrapList.isEmpty && AppController.isLoading.value){
                 return SliverToBoxAdapter(
  child: Shimmer.fromColors(
    baseColor: AppColors.greyColor,
    highlightColor: AppColors.lightGreyColor,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 30.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(height: 10.h,),

        Row(
          children: [
            Container(
          height: 80.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(width: 10.w,),

         Container(
          height: 80.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
          ],
        ),

        SizedBox(height: 30.h,),

        Container(
          height: 30.h,
          width: 90.w,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(height: 10.h,),

        Row(
          children: [
            Container(
          height: 80.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),

        SizedBox(width: 10.w,),

         Container(
          height: 80.h,
          width: 120.w,
          decoration: BoxDecoration(
            color: AppColors.lightGreyColor,
            borderRadius: BorderRadius.circular(4.r),
          ),
        ),
          ],
        )
      ],
    ),
  ),
);

               
              }

              else{

                  return SliverToBoxAdapter(
                  child: Center(
                    child: Text(
                      "No data available",
                      style:
                          TextStyle(fontSize: 16.sp, color: AppColors.greyColor),
                    ),
                  ),
                );
              
              }

            }),
          
          ],
        ),
      ),
    );
  }
}
