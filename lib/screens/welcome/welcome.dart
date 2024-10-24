import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/login/login.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:get/get.dart';


class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  //static double textScaleFactor = Get.context!.textScaleFactor;
  PageController _pageController = PageController();
  int pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: 4,
            onPageChanged: (index) {
              setState(() {
                pageIndex = index;
              });
            },
            itemBuilder: (context, index) {
              return _buildPageItem(index);
            },
          ),
      Positioned(
        top:380.h,
        left:100.w,
        right:100.w,
        child: new DotsIndicator(
          dotsCount: 4,
          position: pageIndex.toInt(),
          decorator: DotsDecorator(
            size: const Size(18.0,9.0),
            activeSize: const Size(30.0, 9.0),
            color: AppColors.tertiaryColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(5.r),  // Set the shape of the dots
            ),
            activeColor: AppColors.primaryColor,
            activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.r)),
          ),
         ),
      ),
        ],
      ),
    );
  }


  Widget _buildPageItem(int index) {
    List<String> imagePaths = [
      "assets/images/scrap-select.png",
      "assets/images/choose-date.png",
      "assets/images/pickup-boy.png",
      "assets/images/sell-scrap2.png",
    ];
    String imagePath = imagePaths[index];

    String headingContent;
    switch (index) {
      case 0:
        headingContent = "Select scrap items for selling";
        break;
      case 1:
        headingContent = "Choose a date for scrap pickup";
        break;
      case 2:
        headingContent = "Pickup boys will arrive at your home";
        break;
      default:
        headingContent = "Scrap sold :)";
    }

    String textContent;
    switch (index) { 
      case 0:
        textContent = "We collect scrap wide list of items like Newspaper, Iron, Electronic machine.";
        break;
      case 1:
        textContent = "Choose a date when you want our executives to come scrap pickup";
        break;
      case 2:
        textContent = "Our pickup executives will call you 1 hour before coming. They will bring an electronic machine";
        break;
      default:
        textContent = "You will get a bill on your mobile and the amount will be transferred to your bank account immediately";
    }

    return Stack(
      children: [
        // Positioned(
        //   top: 0,
        //   left: 0,
        //   bottom: 0,
        //   right: 0,
        //   child: Container(
        //     color: AppColors.whiteColor,
        //   ),
        // ),

        Positioned(
          top: 70.h,
          child: Image.asset(imagePath, width: 400.w, height: 280.h),
        ),

        Positioned(
          top: 430.h,
          child: Center(
            child: Column(
              children: [
                Container(
                   width: 300.w,
                  margin: EdgeInsets.only(left: 30.w, right: 30.w),
                  child: Text(
                    headingContent,
                    style: TextStyle(fontSize: 22.sp, color: AppColors.blackColor,fontWeight: FontWeight.bold,),textScaler: TextScaler.linear(1.0),
                    // textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height:15.h),

                Container(
               width: 300.w,
              margin: EdgeInsets.only(left: 30.w, right: 30.w),
              child: Text(
                textContent,
                style: TextStyle(fontSize: 20.sp, color: AppColors.blackColor),textScaler: TextScaler.linear(1.0),
                // textAlign: TextAlign.center,
              ),
                ),
              ],
            ),
          ),
        ),
        
        Positioned(
          bottom: 20.h,
          left: 30.w,
          right: 30.w,
          child: Center(
            child: CustomElevatedButton(
              width: double.maxFinite,
              height: 50.h,
              text: "Get started",
              textSize: 18.sp,
              buttonColor: AppColors.primaryGradient,
              onPressed: () async{
                // final prefs = await SharedPreferences.getInstance();
                // prefs.setBool("welcome", true);
                // if(!mounted)return;
              
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
