import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomStatusWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color containerColor;
  final Color iconColor;
  final Color textColor;

  CustomStatusWidget({
    required this.icon,
    required this.text,
    required this.containerColor,
    required this.iconColor,
    required this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(5.0.w),
          decoration: BoxDecoration(
            color: containerColor,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Icon(icon, color: iconColor),
        ),
        SizedBox(width: 5.w),
        Text(text,style: TextStyle(fontSize: 16,fontFamily: 'SemiBold',color: textColor),),
      ],
    );
  }
}
