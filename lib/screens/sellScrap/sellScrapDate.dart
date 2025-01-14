import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/leadController.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapConfirmation.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';

class SellScrapDateScreen extends StatefulWidget {
  final bool isUpdate;
  SellScrapDateScreen({super.key, this.isUpdate = false});

  @override
  _SellScrapDateScreenState createState() => _SellScrapDateScreenState();
}

class _SellScrapDateScreenState extends State<SellScrapDateScreen> {
  final AppController controller = (Get.isRegistered<AppController>()) ? Get.find<AppController>() : Get.put(AppController());
  final LeadController leadController = (Get.isRegistered<LeadController>()) ? Get.find<LeadController>() : Get.put(LeadController());

    Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: leadController.selectedDate.value, // Use controller's selected date
      firstDate: DateTime.now(), // Set minimum date to today
      lastDate: DateTime(2101), // Set max date
    );
    if (picked != null && picked != leadController.selectedDate.value) {
      leadController.setSelectedDate(picked); // Update the selected date
    }
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
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Sell Scrap",
                  style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
                  textScaler: TextScaler.linear(1.0),
                ),

                SizedBox(width: 10.w,),

                InkWell(
                  onTap: (){
                    Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MainScreen(),
                  ),
                );
                  },
                  child: Text(
                    "Cancel",
                    style: TextStyle(color: AppColors.whiteColor, fontSize: 17.sp),
                    textScaler: TextScaler.linear(1.0),
                  ),
                ),

              ],
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
                        "Select a date for scrap pickup",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      SizedBox(height: 20.h),

                      // Container with dropdown arrow
                      GestureDetector(
                        onTap: () => _selectDate(context), // Show date picker
                        child: Container(
                          width: double.maxFinite,
                          padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.primaryColor, width: 2.w),
                            borderRadius: BorderRadius.circular(4.r),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Obx(
                                    () {
                                      return Text(
                                        leadController.getDayLabel(),
                                        style: TextStyle(fontSize: 18.sp,color: AppColors.primaryColor,fontWeight: FontWeight.bold),
                                      );
                                    }
                                  ),
                                  SizedBox(height: 5.h), // Space between day label and date
                              
                                  // Show the selected date
                                  Obx(
                                    () {
                                      return Text(
                                        leadController.getFormattedDate(),
                                        style: TextStyle(fontSize: 16.sp, color: AppColors.greyColor),
                                      );
                                    }
                                  ),
                                ],
                              ),

                              Icon(Icons.arrow_drop_down,size: 30.sp,color: AppColors.primaryColor,)
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: 20.h),

                      Text(
                        "Pickup time between 10 am - 6 pm. Our pickup executive will call you before coming.",
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: AppColors.greyColor,
                        ),
                        textScaler: TextScaler.linear(1.0),
                      ),
                    ],
                  ),
                ),
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
                text: widget.isUpdate ? "Update" : "Continue",
                textSize: 18.sp,
                buttonColor: AppColors.primaryGradient,
                onPressed: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SellScrapConfirmationScreen(),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
