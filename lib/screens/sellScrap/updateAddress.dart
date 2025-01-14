import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // For date formatting
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/leadController.dart';
import 'package:kabadiwala/screens/location/selectLocation.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapConfirmation.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';

class UpdateAddressScreen extends StatefulWidget {

  UpdateAddressScreen({super.key});

  @override
  _UpdateAddressScreenState createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
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
      WidgetsBinding.instance.addPostFrameCallback((_) {
    controller.readAddress();  // Load address data
    leadController.loadSelectedAddress();  // Load the selected address
  });
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
                        "Select Pickup Address",
                        style: TextStyle(
                            fontSize: 25.sp, fontWeight: FontWeight.bold),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      SizedBox(height: 20.h),

                        Obx(
  () {
    return Container(
   child: ListView.builder(
        shrinkWrap: true, // Prevent unbounded height
        physics: NeverScrollableScrollPhysics(), // Disable internal scrolling
        itemCount: controller.address.length,
        itemBuilder: (context, index) {
          final item = controller.address[index];
          final isSelected = leadController.selectedAddressId.value == item.id;

          // // Check if no address is selected and set default address to first item in the list
          // if (leadController.selectedAddressId.value == null && index == 0) {
          //   leadController.updateSelectedAddress(item); // Set first address as selected
          // }

          return Padding(
            padding: EdgeInsets.only(bottom: 8.h),
            child: InkWell(
              onTap: () {
                leadController.updateSelectedAddress(item);
                 Navigator.pushReplacement(
                           context,
                  MaterialPageRoute(
                    builder: (context) => SellScrapConfirmationScreen(),
                  ),
                );
              },
              child: Container(
                width: double.maxFinite,
                //height: 100.h,
                decoration: BoxDecoration(
                  color: isSelected
                      ? AppColors.backgroundColor // Background color for selected item
                      : AppColors.whiteColor,
                  border: Border.all(
                    color: isSelected
                        ? AppColors.primaryColor // Border color for selected item
                        : AppColors.greyColor, // Default border color
                    width: 2.0, // Border width
                  ),
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(8.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item.placeType.toString() ?? "",
                        style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 4.h),
                      Row(
                        children: [
                          Text(
                            item.street.toString() ?? "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            ",${item.subLocality.toString()} " ?? "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            ",${item.city.toString()}" ?? "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            ",${item.state.toString()}" ?? "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                          Text(
                            "${item.pincode.toString()}" ?? "",
                            style: TextStyle(fontSize: 14.sp),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  },
),
   SizedBox(height: 20.h,),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          height: 1.h,
                          width: 100.w,
                          color: AppColors.lightGreyColor,
                          
                        ),

                        SizedBox(width: 4.w,),


                        Text("or",style: TextStyle(fontSize: 14.sp,color: AppColors.lightGreyColor),textScaler: TextScaler.linear(1.0),),

                        SizedBox(width: 4.w,),
                        Container(
                          height: 1.h,
                          width: 100.w,
                          color: AppColors.lightGreyColor,
                        )
                      ],
                    ),

                    SizedBox(height: 20.h,),

                    InkWell(
                      
                      onTap: (){
                         Navigator.push(
                           context,
                  MaterialPageRoute(
                    builder: (context) => SelectLocationPage(),
                  ),
                );
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.location_city_outlined),
                          SizedBox(width: 15.w,),
                          Text("Add new Address",style: TextStyle(fontSize: 18.sp),textScaler: TextScaler.linear(1.0),)
                        ],
                      ),
                    ),

                                        ],
                  ),
                ),
              ],
            ),
          ),

         ],
      ),
    );
  }
}
