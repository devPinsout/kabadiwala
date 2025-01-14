import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/leadController.dart';
import 'package:kabadiwala/screens/home/homeComponents/homeCategoryCard.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/commonLayout.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrap.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:shimmer/shimmer.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final AppController controller = (Get.isRegistered<AppController>()) ? Get.find<AppController>() : Get.put(AppController());

   final LeadController leadController = (Get.isRegistered<LeadController>()) ? Get.find<LeadController>() : Get.put(LeadController());


    @override
  void initState() {
    super.initState();

    // Initialize state here
   WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.readUserDetails();
      controller.readScrapCategory();
     // controller.readAddress();
      //controller.clearTempSelectedCategories();
      //leadController.loadSelectedAddress();
      //leadController.clearSelectedScraps();
      
    });
  }
  String getGreetingMessage() {
  final hour = DateTime.now().hour;

  if (hour >= 5 && hour < 12) {
    return "Good Morning";
  } else if (hour >= 12 && hour < 17) {
    return "Good Afternoon";
  } else if (hour >= 17 && hour < 21) {
    return "Good Evening";
  } else {
    return "Good Night";
  }
}

  @override
  Widget build(BuildContext context) {
    // controller.readUserDetails();
    // controller.readScrapCategory();
    // controller.clearTempSelectedCategories();
    // leadController.loadSelectedAddress();
     WidgetsBinding.instance.addPostFrameCallback((_) async{
      controller.clearTempSelectedCategories();
      leadController.clearSelectedScraps();
     await controller.readAddress();

    // Check if the address list is not empty and select the first address
    if (controller.address.isNotEmpty && leadController.selectedAddressId.value == null) {
      // Directly pass the first address to updateSelectedAddress
      leadController.updateSelectedAddress(controller.address[0]);
    }
     leadController.loadSelectedAddress();  // Load the selected address
  });
   

    return CommonPageLayout(
      title: "Kabadiwala",
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
            child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(
                      () {
                        return Text(
                           "${getGreetingMessage()}, ${AppController.userDetails.value.firstName ?? ''}",
                             style: TextStyle(fontSize: 18.sp),
                             textScaler: TextScaler.linear(1.0),
                            );
                      }
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
                    // Grid of categories
Expanded(
  child: Obx(
    () {
      if(controller.scrapCategoryList.isNotEmpty){
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 30.h,
          childAspectRatio: 0.95,
        ),
        itemCount: controller.scrapCategoryList.length, 
        itemBuilder: (context, index) {
      
           return HomeCategoryCard(
           scrapCategory:controller.scrapCategoryList[index]
        );
        },
      );
      }
    else if (controller.scrapCategoryList.isEmpty && AppController.isLoading.value) {
  return GridView.builder(
    physics: NeverScrollableScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3,
      crossAxisSpacing: 10.w,
      mainAxisSpacing: 30.h,
      childAspectRatio: 0.95,
    ),
    itemCount: 6, // Number of shimmer placeholders
    itemBuilder: (context, index) {
      return Shimmer.fromColors(
        baseColor: Colors.grey.shade300,
        highlightColor: Colors.grey.shade100,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
        ),
      );
    },
  );
}

      else{
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("No data found"),
          ],
        );
      }
    }
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

                Obx(() {
  return Container(
    width: double.maxFinite,
    decoration: BoxDecoration(
      gradient: controller.isButtonDisabled.value
          ? LinearGradient(
              colors: [Colors.grey.shade400, Colors.grey.shade400], // Disabled gradient
            )
          : AppColors.primaryGradient,
      borderRadius: BorderRadius.circular(8), // Rounded corners for the button
    ),
    child: ElevatedButton(
      onPressed: controller.isButtonDisabled.value
          ? null // Disable the button when true
          : () {
            //AppController().isCategoryPage.value = true;
              controller.readScrapList(
                selectedCategories: controller.tempSelectedCategories.toList(),
                navigateTo: () {
              Get.to(SellScrapScreen());
                }
              );
              //Get.to(SellScrapScreen());
            },
      style: ElevatedButton.styleFrom(
        elevation: 0, 
        backgroundColor: Colors.transparent, 
        disabledForegroundColor: Colors.transparent, 
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.r), 
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12.w), 
        child: Text(
          "Raise pickup request",
          style: TextStyle(
            fontSize: 16.sp,
            color: 
            controller.isButtonDisabled.value
                ? Colors.white.withOpacity(0.7) // Faded text for disabled
                : Colors.white, // Normal text color
          ),
          textScaler: TextScaler.linear(1.0),
        ),
      ),
    ),
  );
}),

              ],
            ),
          ),
        ],
      ),
     
      
      );
      
     
  }
}
