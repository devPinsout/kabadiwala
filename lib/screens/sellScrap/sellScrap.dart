import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/sellScrap/components/selectScrap.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapConfirmation.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapDate.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';
import 'package:shimmer/shimmer.dart';
import 'package:image_picker/image_picker.dart';

class SellScrapScreen extends StatefulWidget {
   final bool isUpdateScrap;
  SellScrapScreen({super.key,this.isUpdateScrap = false});

  @override
  State<SellScrapScreen> createState() => _SellScrapScreenState();
}

class _SellScrapScreenState extends State<SellScrapScreen> {
  final AppController controller = (Get.isRegistered<AppController>())
      ? Get.find<AppController>()
      : Get.put(AppController());

      final ImagePicker _picker = ImagePicker();

     List<XFile> _selectedImages = [];

  // Function to pick multiple images from the gallery
  Future<void> _pickImages() async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage(); // Using pickMultiImage
      if (images != null) {
        setState(() {
          _selectedImages.addAll(images);
        });
      }
    } catch (e) {
      print('Error picking images: $e');
    }
  }

   void _removeImage(int index) {
    setState(() {
      _selectedImages.removeAt(index);
    });
  }


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
              "Sell Scrap",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
              textScaler: TextScaler.linear(1.0),
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Select scrap items for pickup",
                        style: TextStyle(fontSize: 25.sp, fontWeight: FontWeight.bold),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      SizedBox(height: 5.h),
                      Text(
                        "Price may fluctuate because of the recycling industry.",
                        style: TextStyle(fontSize: 13.sp, color: AppColors.greyColor),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      SizedBox(height: 20.h),
                    ],
                  ),
                ),

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
                                child: SelectScrapCard(
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
              else if(controller.groupedScrapList.isNotEmpty && AppController.isLoading.value){
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
          
          
                 SliverToBoxAdapter(child:Divider(color: AppColors.lightGreyColor,)),

                 SliverToBoxAdapter(child: SizedBox(height: 25.h,)),

                
                SliverToBoxAdapter(
  child: Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: Icon(Icons.image, color: AppColors.primaryColor, size: 40.sp),
            onPressed: _pickImages, // Call the function to pick an image
          ),
          SizedBox(width: 4.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload scraps item's pictures",
                  style: TextStyle(fontSize: 19.sp),
                  textScaler: TextScaler.linear(1.0),
                ),
                Text(
                  "This will help us identify your scrap items better.",
                  style: TextStyle(fontSize: 13.sp, color: AppColors.greyColor),
                  textScaler: TextScaler.linear(1.0),
                )
              ],
            ),
          )
        ],
      ),
      SizedBox(height: 10.h),

      // GridView for displaying selected images
      _selectedImages.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true, // Ensures the GridView takes only necessary space
              physics: NeverScrollableScrollPhysics(), // Prevents scrolling inside the GridView
              itemCount: _selectedImages.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, // Number of columns
                crossAxisSpacing: 10.w, // Spacing between columns
                mainAxisSpacing: 10.h, // Spacing between rows
              ),
              itemBuilder: (context, index) {
                return Stack(
                          children: [
                            // Image
                            ClipRRect(
                              borderRadius: BorderRadius.circular(8.r),
                              child: Image.file(
                                File(_selectedImages[index].path),
                                fit: BoxFit.cover,
                                width: double.infinity,
                                height: double.infinity,
                              ),
                            ),

                            // Remove Icon
                            Positioned(
                              top: 5,
                              right: 5,
                              child: GestureDetector(
                                onTap: () => _removeImage(index),
                                child: CircleAvatar(
                                  radius: 12.r,
                                  backgroundColor: Colors.red,
                                  child: Icon(
                                    Icons.close,
                                    size: 14.sp,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
              },
            )
          : Text(
              "No images selected yet.",
              style: TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
            ),
    ],
  ),
),
 SliverToBoxAdapter(child: SizedBox(height: 80.h,)),
              ],
            ),
          ),

          // Fixed Button at the Bottom
          Positioned(
            left: 0,
            right: 0,
            bottom: 10.h,
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomElevatedButton(
              width: double.maxFinite,
              height: 50.h,
              text: widget.isUpdateScrap ? "Update" : "Continue",
              textSize: 18.sp,
              buttonColor: AppColors.primaryGradient,
              onPressed: () async{
               if (widget.isUpdateScrap) {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellScrapConfirmationScreen(),
                  ),
                );
              } else {
                  Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellScrapDateScreen(),
                  ),
                );

               }
               
              },
            ),
            ),
          ),
        ],
      ),
    );
  }
}
