import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/leadController.dart';
import 'package:kabadiwala/models/leadRequestModel.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/pickupRequest/requestTrackScreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';
import 'package:shimmer/shimmer.dart';

class PickupRequestDetailScreen extends StatefulWidget {
  final String leadtId;

  PickupRequestDetailScreen({required this.leadtId,super.key});

  @override
  State<PickupRequestDetailScreen> createState() => _PickupRequestDetailScreenState();
}

class _PickupRequestDetailScreenState extends State<PickupRequestDetailScreen> {
  final AppController controller = (Get.isRegistered<AppController>()) ? Get.find<AppController>() : Get.put(AppController());

  final LeadController leadController = (Get.isRegistered<LeadController>()) ? Get.find<LeadController>() : Get.put(LeadController());

  @override
void initState() {
  super.initState();
  
  // Clear the existing value
  leadController.detailRequest.value = LeadRequestModel();
  // leadController.readOneLeadRequest(leadId: widget.leadtId);

  //Use WidgetsBinding to make the API call after the widget is built
  WidgetsBinding.instance.addPostFrameCallback((_) {
    leadController.readOneLeadRequest(leadId: widget.leadtId); // Fetch lead request
    leadController.readCancelReason();
  });
}


 String _getFormattedPickupDate(DateTime? pickupDate) {
  if (pickupDate == null) return DateFormat('dd-MM-yyyy').format(DateTime.now());

  final now = DateTime.now();
  final pickupDay = DateTime(pickupDate.year, pickupDate.month, pickupDate.day);  // Strip time part

  if (pickupDay.isAtSameMomentAs(now)) {
    return 'Today, ${DateFormat('dd-MM-yyyy').format(pickupDate)}';
  } else if (pickupDay.isAtSameMomentAs(now.add(Duration(days: 1)))) {
    return 'Tomorrow, ${DateFormat('dd-MM-yyyy').format(pickupDate)}';
  } else {
    // For future dates, show the day of the week and the full date (e.g., "Monday, 05-03-2025")
    return '${DateFormat('EEEE').format(pickupDate)}, ${DateFormat('dd-MM-yyyy').format(pickupDate)}';
  }
}

void _showCancelDialog(BuildContext context) {
    // Manage selected reason state
    int? selectedReasonId;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              surfaceTintColor: Colors.transparent,
              backgroundColor: AppColors.whiteColor,
              title: Text("Select a Cancel Reason"),
              content: Obx(
                () => leadController.cancelReason.isEmpty
                    ? CircularProgressIndicator() // Show a loading indicator while fetching data
                    : SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: leadController.cancelReason.map((reason) {
                            return RadioListTile<int>(
                              title: Text(reason.cancellationReasons.toString()),
                              value: reason.id!.toInt(),
                              groupValue: selectedReasonId,
                              onChanged: (int? value) {
                                setState(() {
                                  selectedReasonId = value;
                                });
                              },
                            );
                          }).toList(),
                        ),
                      ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context), // Close dialog
                  child: Text("Cancel"),
                ),
                TextButton(
                  onPressed: () {
                    if (selectedReasonId != null) {
                      print("Selected Reason ID: $selectedReasonId"); // Debugging
                      Navigator.pop(context); // Close dialog
                    }
                  },
                  child: Text("Submit"),
                ),
              ],
            );
          },
        );
      },
    );
  }




 @override
  Widget build(BuildContext context) {
    // leadController.detailRequest.value = LeadRequestModel();
    // leadController.readOneLeadRequest(leadId: widget.leadtId); // Call to fetch the lead requests

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
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
              "Upcoming",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
            ),

        actions: [
        PopupMenuButton<String>(
          icon: Icon(Icons.more_vert, color: Colors.white),
          onSelected: (value) {
            if (value == "Cancel") {
              _showCancelDialog(context); // Function to handle the "Cancel" action
            }
          },
          offset: Offset(0, 40), // Adjust the position below the three dots icon
          itemBuilder: (BuildContext context) {
            return [
              PopupMenuItem(
                value: "Cancel",
                child: Text("Cancel"),
              ),
            ];
          },
        ),
      ],
          ),
        ),
      ),
      body:  Obx(
        () {
          if (LeadController.isLoading.value) {
        // Show shimmer while loading
        return SingleChildScrollView(
          child: Column(
            children: List.generate(5, (index) {
              return Shimmer.fromColors(
                baseColor: Colors.grey[300]!,
                highlightColor: Colors.grey[100]!,
                child: Container(
                  margin: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
                  height: 100.h,
                  color: Colors.white,
                ),
              );
            }),
          ),
        );
      } else if (leadController.detailRequest.value == null) {
        // Handle error or empty state
        return Center(
          child: Text(
            "No data available.",
            style: TextStyle(fontSize: 16.sp, color: AppColors.greyColor),
          ),
        );
      }
          return SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                         Padding(
                          padding: EdgeInsets.only(left: 10.w,top: 10.h,bottom: 5.h),
                          child: Row(
                            children: [
                              SvgPicture.asset("assets/images/processing.svg",color: AppColors.primaryColor,width: 25.w,height: 25.h,),
                              SizedBox(width: 8.w,),
                              Text("Request processing",style: TextStyle(fontSize: 22.sp,color: AppColors.blackColor,fontWeight: FontWeight.w700),textScaler: TextScaler.linear(1.0),),
                            ],
                          ),
                        ),
              
                        Container(
                                      margin: EdgeInsets.only(top: 10.h),
                                      padding: EdgeInsets.all(15.h),
                              color: AppColors.whiteColor,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Expected Pickup",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                                      SizedBox(height: 3.h,),
                                      Obx(
                                        () {
                                          return Text(  _getFormattedPickupDate(leadController.detailRequest.value.pickupDate),style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),);
                                        }
                                      ),
                                      SizedBox(height: 3.h,),
                                      Text("10 AM - 6 PM",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                                    
                                    ],
                                  ),
                                  
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Request Id",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                                      Obx(
                                        () {
                                          return Text(leadController.detailRequest.value.id.toString(),style: TextStyle(fontSize: 17.sp),textScaler: TextScaler.linear(1.0),);
                                        }
                                      )
                                    ],
                                  )
                                ],
                              )
                  
              
                                
                                    ),
                        
                        SizedBox(height: 5.h,),
                        Container(
            padding: EdgeInsets.all(15.h),
            color: AppColors.whiteColor,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
          Text(
            "Scrap Items",
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.greyColor,
            ),
            textScaler: TextScaler.linear(1.0),
          ),
          SizedBox(height: 3.h),
          
          // Display the ListView.builder here
          Obx(() {
            final scrapItems = leadController.detailRequest.value.scrapItems ?? [];
          
            // Check if the scrapItems list is empty
            if (scrapItems.isEmpty) {
              return Text(
                "No scrap items available",
                style: TextStyle(fontSize: 14.sp, color: AppColors.greyColor),
              );
            }
          
            // Use ListView.builder to show the scrap items
            return ListView.builder(
              physics: NeverScrollableScrollPhysics(), // Prevent ListView from scrolling
              shrinkWrap: true, // Allow ListView to adjust its height based on children
              itemCount: scrapItems.length,
              itemBuilder: (context, index) {
                final scrapItem = scrapItems[index];
                return Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        scrapItem.scrapName ?? "Unknown Item",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        "₹${scrapItem.price.toString()}",
                        style: TextStyle(
                          fontSize: 18.sp,
                          color: AppColors.blackColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          }),
              ],
            ),
          ),
          
                          SizedBox(height: 5.h,),
                        
                         Container(
                                      //margin: EdgeInsets.symmetric(vertical: 10.h),
                                      padding: EdgeInsets.all(15.h),
                              color: AppColors.whiteColor,
                              child: Row(
                                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Icon(Icons.location_on_outlined),
                                  SizedBox(width: 5.w,),
                                  Obx(
                                    () {
                                      return Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Address - ${leadController.detailRequest.value.placeType.toString()}",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor,), softWrap: true,textScaler: TextScaler.linear(1.0),),
                                            SizedBox(height: 3.h,),
                                            Text(leadController.detailRequest.value.address.toString(),style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),),
                                            
                                          ],
                                        ),
                                      );
                                    }
                                  ),
                                  
                               
                                ],
                              )
                                    ),
              
                                    
                          SizedBox(height: 5.h,),
                         Container(
                    color: AppColors.whiteColor,
                    child: Padding(
                      padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                               Icon(Icons.payment_outlined,size: 30.sp,color: AppColors.greyColor,),
                          SizedBox(width: 8.w,),
                          Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text("Payment Method",style: TextStyle(fontSize: 14.sp,color: AppColors.greyColor,),textScaler: TextScaler.linear(1.0),),
                                //SizedBox(height: 3.h,),
                                Text("Cash",style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor,),textScaler: TextScaler.linear(1.0),),
                                ],
                            ),
                          ),
                         
                            ],
                          ),
                          
                          SizedBox(width: 20.w,),
                          Text("Change",style: TextStyle(fontSize: 17.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),)
                        ],
                      ),
                      ),
                   ),
          
                    SizedBox(height: 5.h,),
                         InkWell(
                          onTap: (){
                            String leadId = widget.leadtId.toString();
                                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => RequestTrackScreen(leadtId:leadId),
                      ),
                    );
                          },
                           child: Container(
                                           color: AppColors.whiteColor,
                                           child: Padding(
                                             padding:EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
                                             child: Row(
                                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                               children: [
                            Row(
                              children: [
                                SvgPicture.asset("assets/images/truck.svg",height: 25.h,width: 25.w,),
                                SizedBox(width: 8.w,),
                             Text("Track Your Order",style: TextStyle(fontSize: 16.sp,color: AppColors.blackColor,),textScaler: TextScaler.linear(1.0),),
                                  
                              ],
                            ),
                            
                             Icon(Icons.arrow_forward_ios,size: 25.sp,color: AppColors.greyColor,),
                            
                           ],
                                             ),
                                             ),
                                          ),
                         ),
                 
                        
                       ],
                    ),
                  );
        }
      ),
        
            
    );
  }
}
