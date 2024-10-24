import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/login/basicDetail.dart';
import 'package:kabadiwala/screens/mainscreen/mainscreen.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';
import 'package:kabadiwala/widgets/elevatedButtonWidget.dart';
import 'package:kabadiwala/widgets/textFormFieldWithBorder.dart';

class SetLocationScreen extends StatelessWidget {
  SetLocationScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.0), // Set the height of the AppBar
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.primaryColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(20.0),
              bottomRight: Radius.circular(20.0),
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent, // Make AppBar transparent
            automaticallyImplyLeading: true,
             leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.white), //
        onPressed: () {
          Navigator.pop(context); // Go back to the previous screen
        },
      ),
            title: Text("Set Your Location",style: TextStyle(color: AppColors.whiteColor,fontSize: 22.sp),textScaler: TextScaler.linear(1.0),),
            actions: [
              IconButton(
                icon: Icon(Icons.search, color: Colors.white),
                onPressed: (){},
              ),
            ],
          ),
        ),
      ),
      
      body: Stack(
        children: [
          Positioned(
            top: 0,
            bottom: 0,
            left: 0,
            right: 0,
            child: Image.asset("assets/images/maps.png",fit: BoxFit.cover,)
            ),

         Positioned(
            bottom: 10.h,
            left: 0,
            right: 0,
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
                
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MainScreen(),
                    ),
                  );
                },
              ),
            ),
            ),

            
        ],
      )
      );
  }
}
