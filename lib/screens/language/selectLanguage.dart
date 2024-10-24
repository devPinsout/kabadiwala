import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:kabadiwala/screens/welcome/welcome.dart';
import 'package:kabadiwala/widgets/customTextButton.dart';

class SelectLanguage extends StatelessWidget {
  const SelectLanguage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal:30.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset("assets/images/logo-kabad2.png",height: 50.h,width: 100.w,),

            SizedBox(height: 40.h,),

            Text("Select App Language",style: TextStyle(fontSize: 28.h,fontWeight: FontWeight.bold),textScaler: TextScaler.linear(1.0),),

            SizedBox(height: 30.h,),

            Row(
              children: [
                Expanded(
                  child: CustomTextButton(
                    onPressed: (){
                      Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
                    },
                   text: "English",
                   ),
                ),
              ],
            ),

            SizedBox(height: 30.h,),

           Row(
              children: [
                Expanded(
                  child: CustomTextButton(
                     onPressed: (){
                      Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WelcomeScreen(),
                  ),
                );
                    },
                   text: "Hindi",
                   ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}