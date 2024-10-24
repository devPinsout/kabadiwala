import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapConfirmation.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';

class SellScrapDateScreen extends StatefulWidget {
  SellScrapDateScreen({super.key});

  @override
  _SellScrapDateScreenState createState() => _SellScrapDateScreenState();
}

class _SellScrapDateScreenState extends State<SellScrapDateScreen> {
  DateTime? selectedDate = DateTime.now(); // Default to today's date

  // Function to show the date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(), // Default to current date
      firstDate: DateTime.now(), // Set minimum date to today
      lastDate: DateTime(2101), // Set max date
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Function to get the day label (Today, Tomorrow, or the weekday name)
  String getDayLabel() {
    if (selectedDate == null) return "Select a date";

    DateTime today = DateTime.now();
    DateTime tomorrow = today.add(Duration(days: 1));

    // Check if selected date is today or tomorrow
    if (DateFormat('yyyy-MM-dd').format(selectedDate!) == DateFormat('yyyy-MM-dd').format(today)) {
      return "Today";
    } else if (DateFormat('yyyy-MM-dd').format(selectedDate!) == DateFormat('yyyy-MM-dd').format(tomorrow)) {
      return "Tomorrow";
    } else {
      // Else, return the weekday name (e.g., Monday, Tuesday)
      return DateFormat('EEEE').format(selectedDate!);
    }
  }

  // Function to get the formatted date
  String getFormattedDate() {
    if (selectedDate == null) return "Select a date";
    return DateFormat('dd-MM-yyyy').format(selectedDate!);
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
                                  Text(
                                    getDayLabel(),
                                    style: TextStyle(fontSize: 18.sp,color: AppColors.primaryColor,fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 5.h), // Space between day label and date
                              
                                  // Show the selected date
                                  Text(
                                    getFormattedDate(),
                                    style: TextStyle(fontSize: 16.sp, color: AppColors.greyColor),
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
                text: "Continue",
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
