import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kabadiwala/controller/appController.dart';
import 'package:kabadiwala/controller/leadController.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrap.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapDate.dart';
import 'package:kabadiwala/screens/sellScrap/updateAddress.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';

class SellScrapConfirmationScreen extends StatelessWidget {
  SellScrapConfirmationScreen({super.key});

  final TextEditingController _instructionController = TextEditingController();

  final AppController controller = (Get.isRegistered<AppController>()) ? Get.find<AppController>() : Get.put(AppController());
  final LeadController leadController = (Get.isRegistered<LeadController>()) ? Get.find<LeadController>() : Get.put(LeadController());


  @override
  Widget build(BuildContext context) {
    leadController.loadSelectedAddress();
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
      body:SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.h),
              child: Text(
                          "Pickup confirmation",
                          style: TextStyle(
                              fontSize: 25.sp, fontWeight: FontWeight.bold),
                          textScaler: TextScaler.linear(1.0),
                        ),
            ),
           
  Container(
  padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
  color: AppColors.whiteColor,
  child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text("Scrap Items",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
      SizedBox(height: 10.h,),
      Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // The grid displaying the scrap items
          Expanded(
            flex: 3, // Adjust flex to allocate space between the grid and the "Change" text
            child: Obx(() {
              return GridView.builder(
                shrinkWrap: true, // Ensures the grid takes only the necessary space
                physics: NeverScrollableScrollPhysics(), // Prevents inner scrolling
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // Number of columns in the grid
                  crossAxisSpacing: 10.w, // Space between columns
                  mainAxisSpacing: 10.h, // Space between rows
                  childAspectRatio: 3 /1.5, // Adjust the size of the grid items
                ),
                itemCount: leadController.selectedScraps.length,
                itemBuilder: (context, index) {
                  final item = leadController.selectedScraps[index];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['scrap_name']!, // Scrap item name
                        style: TextStyle(fontSize: 15.sp, color: AppColors.blackColor),
                        textScaler: TextScaler.linear(1.0),
                      ),
                      SizedBox(height: 4.h),
                     Text(
                     'Rs.${double.tryParse(item['price'].toString())?.toStringAsFixed(0) ?? item['price']}/Kg',
                     style: TextStyle(fontSize: 18.sp, color: AppColors.blackColor),
                     textScaler: TextScaler.linear(1.0),
                    ),
      
                    ],
                  );
                },
              );
            }),
          ),
      
          SizedBox(width: 10.w), // Space between the grid and the "Change" text
          
          // "Change" text
          Expanded(
            flex: 1,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                   builder: (context) => SellScrapScreen(isUpdateScrap: true),
                   ),
                  );

                  },
                  child: Text(
                    "Change",
                    style: TextStyle(fontSize: 16.sp, color: AppColors.primaryColor),
                    textScaler: TextScaler.linear(1.0),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ],
  ),
),


         
            SizedBox(height: 10.h,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
              color: AppColors.whiteColor,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Address",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                            SizedBox(height: 5.h,),
                            Obx(
                              () {
                                return Text("${leadController.selectedAddress.value}",style: TextStyle(fontSize: 17.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),);
                              }
                            ),
                            ],
                        ),
                      ),
                  
                      SizedBox(width: 5.w,),
                      InkWell(
                        onTap: (){
                          Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                   builder: (context) => UpdateAddressScreen(),
                   ),
                  );

                        },
                        child: Text("Change",style: TextStyle(fontSize: 16.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),))
                    ],
                  
                  ),

                  SizedBox(height: 10.h,),

                  Container(
                    height: 200.h,
                    width: double.maxFinite,
                    child: Image.asset("assets/images/maps.png",fit: BoxFit.fill,),
                    )
                ],
              ),
            ),

            SizedBox(height: 10.h,),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w,vertical: 10.w),
              color: AppColors.whiteColor,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Pickup",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),),
                        SizedBox(height: 5.h,),
                        Obx(
                          () {
                            return Text("${leadController.getDayLabel()}, ${leadController.getFormattedDate()}",style: TextStyle(fontSize: 17.sp,color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),);
                          }
                        ),
                        SizedBox(height: 5.h,),
                        Text("10 AM - 6 PM",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),)
                      ],
                    ),
                  ),

                  SizedBox(width: 5.w,),
                  InkWell(
                    onTap:(){
                   Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                   builder: (context) => SellScrapDateScreen(isUpdate: true),
                   ),
                  );

                    },
                    child: Text("Change",style: TextStyle(fontSize: 16.sp,color: AppColors.primaryColor),textScaler: TextScaler.linear(1.0),))
                ],

              ),
            ),

            SizedBox(height: 10.h,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: Text("Any instructions",style: TextStyle(fontSize: 15.sp,color: AppColors.greyColor,fontWeight: FontWeight.w600),textScaler: TextScaler.linear(1.0),),
              ),

              SizedBox(height: 10.h,),

              Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: TextFieldWithBorder(controller: _instructionController, 
              hintText: "Any instructions for our pickup...."),
              ),

              SizedBox(height: 20.h,),
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.w),
              child: CustomElevatedButton(
                  width: double.maxFinite,
                  height: 50.h,
                  text: "Continue",
                  textSize: 18.sp,
                  buttonColor: AppColors.primaryGradient,
                  onPressed: () async {
                    leadController.createLead(
                      address: leadController.selectedAddress.toString(), 
                      addressId: leadController.selectedAddressId.toString(), 
                      latitude: leadController.selectedLatitude.toString(),
                      longitude: leadController.selectedLongitude.toString(),
                      placeType: leadController.selectedPlaceType.toString(),
                      pickupDate: leadController.selectedDate.toString(), 
                      userId: AppController.userDetails.value.id.toString(), 
                      scrapItems: leadController.selectedScraps,
                      );
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => MainScreen(),
                    //   ),
                    // );
                  },
                ),
            ),
          ],
        ),
      )
    );
  }
}
