import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/leadController.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/pickupRequest/pickupRequestDetail.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';
import 'package:shimmer/shimmer.dart';

class PickupRequestScreen extends StatelessWidget {
  final AppController controller = (Get.isRegistered<AppController>()) ? Get.find<AppController>() : Get.put(AppController());
  final LeadController leadController = (Get.isRegistered<LeadController>()) ? Get.find<LeadController>() : Get.put(LeadController());

  PickupRequestScreen({super.key});

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


 @override
  Widget build(BuildContext context) {
    leadController.readLeadRequests(); // Call to fetch the lead requests
   // leadController.readOneLeadRequest();

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
              "Pickup requests",
              style: TextStyle(color: AppColors.whiteColor, fontSize: 22.sp),
            ),
          ),
        ),
      ),
      body: Obx(() {
        // If loading, show a loading indicator
        if (LeadController.isLoading.value) {
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
        }
        
        // If no requests, display the "No Requests" message
        else if (leadController.leadRequest.isEmpty) {
          return Column(
            children: [
              Image.asset("assets/images/pickup.png"),
      SizedBox(height: 20.h),
      Text(
        "You have not raised any request till now.",
        style: TextStyle(fontSize: 18.sp),
        textAlign: TextAlign.center,
      ),
      SizedBox(height: 20.h),
      CustomElevatedButton(
        width: double.maxFinite,
        height: 50.h,
        text: "Raise pickup request",
        textSize: 18.sp,
        buttonColor: AppColors.primaryGradient,
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MainScreen(),
            ),
          );
        },
      ),
      
               
            ],
          );
        }
            
        else{
          return SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Padding(
                  padding: EdgeInsets.only(left: 10.w,top: 10.h,bottom: 5.h),
                  child: Text("Your Scrap Pickups",style: TextStyle(fontSize: 22.sp,color: AppColors.blackColor,fontWeight: FontWeight.w700),textScaler: TextScaler.linear(1.0),),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w,top: 10.h),
                  child: Text("Upcoming",style: TextStyle(fontSize: 17.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                itemCount: leadController.leadRequest
                .where((request) => request.status == 1) // Filter requests with status 1
                .toList()
                .length,
                   itemBuilder: (context, index) {
                   final leadRequest = leadController.leadRequest
                   .where((request) => request.status == 1) // Filter requests with status 1
                   .toList()[index];
                   String scrapNames = leadRequest.scrapItems!
                  .map((scrap) => scrap.scrapName ?? "N/A")
                  .join(", "); // Joining all scrap names with a comma and space
                      
                            return InkWell(
                              
                              onTap: (){
                                String leadId = leadRequest.id.toString();
                                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PickupRequestDetailScreen(leadtId:leadId),
                  ),
                );
                              },
                              child: Container(
                                margin: EdgeInsets.symmetric(vertical: 10.h),
                                padding: EdgeInsets.all(15.h),
                                                    color: AppColors.whiteColor,
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                              children: [
                                SvgPicture.asset("assets/images/upcoming.svg",color: AppColors.yellowColor),
                                SizedBox(width: 5.w,),
                                Text("Id: ${leadRequest.id}",style: TextStyle(fontSize: 16.sp),textScaler: TextScaler.linear(1.0),),
                                
                              ],
                                                        ),
                                                        SizedBox(height: 10.h,),
                                                        Text("$scrapNames",style: TextStyle(fontSize: 17.sp),textScaler: TextScaler.linear(1.0),), 
                                                        SizedBox(height: 5.h,),
                                                       Text(
                                _getFormattedPickupDate(leadRequest.pickupDate),
                                style: TextStyle(fontSize: 16.sp, color: AppColors.greyColor),
                                textScaler: TextScaler.linear(1.0),
                              )
                                  
                              
                                                      ],
                                                    ),
                              ),
                            );   },
                        ),

                        Padding(
                  padding: EdgeInsets.only(left: 10.w,top: 20.h),
                  child: Text("Completed and Cancelled",style: TextStyle(fontSize: 17.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                ),
                ListView.builder(
                  padding: EdgeInsets.zero,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                itemCount: leadController.leadRequest
                .where((request) => request.status == 2 || request.status == 3) // Filter requests with status 1
                .toList()
                .length,
                   itemBuilder: (context, index) {
                   final leadRequest = leadController.leadRequest
        .where((request) => request.status == 2 || request.status == 3) // Filter requests with status 1
        .toList()[index];
                   String scrapNames = leadRequest.scrapItems!
                  .map((scrap) => scrap.scrapName ?? "N/A")
                  .join(", "); // Joining all scrap names with a comma and space
                      
                            return Container(
                              margin: EdgeInsets.symmetric(vertical: 10.h),
                              padding: EdgeInsets.all(10.h),
                      color: AppColors.whiteColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                              leadRequest.status == 2
                                ? Icons.cancel_outlined
                               : leadRequest.status == 3
                                 ? Icons.check_circle_outline
                                   : Icons.info_outline, // Default icon if status is not 2 or 3
                               color: leadRequest.status == 2
                             ? AppColors.redColor
                           : leadRequest.status == 3
                              ? AppColors.greenColor
                              : AppColors.greyColor, // Adjust colors for each status
                           size: 25.sp,
                            ),
                            SizedBox(width: 5.w,),
                              Text("Id: ${leadRequest.id}",style: TextStyle(fontSize: 16.sp),textScaler: TextScaler.linear(1.0),),
                              
                            ],
                          ),
                          SizedBox(height: 10.h,),
                          Text("$scrapNames",style: TextStyle(fontSize: 17.sp),textScaler: TextScaler.linear(1.0),), 
                          SizedBox(height: 5.h,),
                         Text(
  _getFormattedPickupDate(leadRequest.pickupDate),
  style: TextStyle(fontSize: 16.sp, color: AppColors.greyColor),
  textScaler: TextScaler.linear(1.0),
)
    

                        ],
                      ),
                            );   
                            
                          
                            },
                        ),
              ],
            ),
          );
            
            
        }
            
        // Otherwise, display the list of requests
      }
      ),
    );
  }
}
