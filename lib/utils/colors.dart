import 'dart:ui';
import 'package:flutter/material.dart';


class AppColors{
  static final Color primaryColor = const Color(0xff9C5DF7);
  static final Color lightprimaryColor = Color.fromARGB(255, 245, 238, 255);
  static final Color secondaryColor = const Color(0xffCA91FA);
  static final Color tertiaryColor = const Color(0xffC3C2FE);
  static final Color yellowColor = const Color(0xffF0C400);
    static final Color blueColor = const Color(0xff1D9BF2);
  static final Color pinkColor = const Color(0xffFF005C);
  static final Color lightPinkColor = const Color(0x33FF005C);
  static final Color blackColor = const Color(0xff242424);
  static final Color blackLight = const Color(0xff333333);
  static final Color blackShade = const Color(0xff000040);
  static final Color purpleShade = const Color(0xff5665E3);
  static final Color whiteColor = const Color(0xffFFFFFF);
  static final Color textColor = const Color(0xff797979);
  static final Color textLightColor = const Color(0xff898989);
  static final Color greyColor = const Color(0xff737373);
  static final Color lightGreyColor = const Color(0x33737373);
  static final Color darkYellowColor = const Color(0xffFFE381);
  static final Color lightYellowColor = const Color(0xffFFEDAD);
  static final Color backgroundColor = const Color(0xffF1F2FD);
  static final Color greenColor = const Color(0xff00B649);
  static final Color lightGreenColor = const Color(0x333FF552);
  static final Color reportCardBorder = const Color(0x33333D94);
  static final Color hinttextColor = const Color(0x55333D94);
  static final Color borderColor = const Color(0xff7279ED);
  static final Color pendingStatus = const Color(0xffFFCC4D);
  static final Color confirmedStatus = const Color(0xff00B649);
  static final Color rejectedStatus = const Color(0xffF64241);
  static final Color expiredStatus = const Color(0xff7279ED);
  static final Color purpleColor = const Color(0xff4551C3);
  static final Color sellBackground = Color.fromARGB(255, 242, 243, 250);
  static final Color darkRed = const Color(0xffF93054);
  static final Color redColor = const Color(0xffFA7091);
  static final Color lightYellow = const Color(0xffFFE39D);
  static final Color lightGreen = const Color(0xff4DC27C);
  static final Color lightPurple = const Color(0xff9BA1FB);
  static final Gradient primaryGradient = LinearGradient(
    colors: [secondaryColor, primaryColor],
    //begin: Alignment.left,
    //end: Alignment.bottomRight,
  );
  static final Gradient secondaryGradient= LinearGradient(
    colors: [redColor, darkRed],
    //begin: Alignment.left,
    //end: Alignment.bottomRight,
  );

   static final Gradient pendingGradient= LinearGradient(
    colors: [lightYellow, pendingStatus],
    //begin: Alignment.left,
    //end: Alignment.bottomRight,
  );

  static final Gradient confirmedGradient= LinearGradient(
    colors: [lightGreen, confirmedStatus],
    //begin: Alignment.left,
    //end: Alignment.bottomRight,
  );

  static final Gradient greyGradient= LinearGradient(
    colors: [lightGreyColor, lightGreyColor],
    //begin: Alignment.left,
    //end: Alignment.bottomRight,
  );

  static final Gradient expiredGradient= LinearGradient(
    colors: [lightPurple, expiredStatus],
    //begin: Alignment.left,
    //end: Alignment.bottomRight,
  );


}