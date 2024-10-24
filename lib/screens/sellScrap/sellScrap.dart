import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/sellScrap/sellScrapDate.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';
import 'package:kabadiwala/screens/rateList/rateListComponent/rateListCard.dart';

class SellScrapScreen extends StatelessWidget {
  SellScrapScreen({super.key});

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

                // Paper Category
                SliverToBoxAdapter(
                  child: Text("Paper", style: TextStyle(fontSize: 18.sp, color: AppColors.greyColor), textScaler: TextScaler.linear(1.0)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 5.h)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80.h,
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
                SliverToBoxAdapter(child: SizedBox(height: 25.h)),

                // Plastic Category
                SliverToBoxAdapter(
                  child: Text("Plastic", style: TextStyle(fontSize: 18.sp, color: AppColors.greyColor), textScaler: TextScaler.linear(1.0)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 5.h)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80.h,
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
                SliverToBoxAdapter(child: SizedBox(height: 25.h)),

                // Metals Category
                SliverToBoxAdapter(
                  child: Text("Metals", style: TextStyle(fontSize: 18.sp, color: AppColors.greyColor), textScaler: TextScaler.linear(1.0)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 5.h)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80.h,
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
                SliverToBoxAdapter(child: SizedBox(height: 25.h)),

                // E-waste Category
                SliverToBoxAdapter(
                  child: Text("E-waste", style: TextStyle(fontSize: 18.sp, color: AppColors.greyColor), textScaler: TextScaler.linear(1.0)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 5.h)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80.h,
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
                SliverToBoxAdapter(child: SizedBox(height: 25.h)),

                // Other Items Category
                SliverToBoxAdapter(
                  child: Text("Other Items", style: TextStyle(fontSize: 18.sp, color: AppColors.greyColor), textScaler: TextScaler.linear(1.0)),
                ),
                SliverToBoxAdapter(child: SizedBox(height: 5.h)),
                SliverToBoxAdapter(
                  child: SizedBox(
                    height: 80.h,
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

                SliverToBoxAdapter(child: SizedBox(height: 25.h,)),

                 SliverToBoxAdapter(child:Divider(color: AppColors.lightGreyColor,)),

                 SliverToBoxAdapter(child: SizedBox(height: 25.h,)),

                
                 SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(Icons.image,color: AppColors.primaryColor,),
                      SizedBox(width: 4.w,),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Upload scraps item's pictures",style: TextStyle(fontSize: 19.sp),textScaler: TextScaler.linear(1.0),),
                            Text("This will help us identify your scrap items better.",style: TextStyle(fontSize: 13.sp,color: AppColors.greyColor),textScaler: TextScaler.linear(1.0),)
                          ],
                        ),
                      )
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
              text: "Continue",
              textSize: 18.sp,
              buttonColor: AppColors.primaryGradient,
              onPressed: () async{
                // final prefs = await SharedPreferences.getInstance();
                // prefs.setBool("welcome", true);
                // if(!mounted)return;
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SellScrapDateScreen(),
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
