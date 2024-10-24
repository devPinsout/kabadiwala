import 'package:flutter/material.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String text;

  const CustomTextButton({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        side: BorderSide(
          color: AppColors.blackColor, // Border color
          width: 1, 
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.r), // Border radius
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10.h),
        child: Text(
          text,
          style: TextStyle(
            color: AppColors.blackLight, 
            fontSize: 20.sp
          ),
          textAlign: TextAlign.start,
          textScaler: TextScaler.linear(1.0),
        ),
      ),
    );
  }
}
