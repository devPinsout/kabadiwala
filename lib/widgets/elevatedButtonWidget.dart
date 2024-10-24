import 'package:flutter/material.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final double? width;
  final double? height;
  final Gradient? buttonColor;
  final Color? textColor;
  final double? textSize;
  final double? borderRadius;
  final String? font;

  CustomElevatedButton({
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
    this.buttonColor,
    this.textColor,
    this.textSize,
    this.borderRadius,
    this.font,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          gradient: buttonColor,
          borderRadius: BorderRadius.circular(borderRadius ?? 8.0),
        ),
        child: Center(
          child: Text(
              text,
              style: TextStyle(
                color: textColor ?? Colors.white,
                fontSize: textSize,
                fontFamily: font,
              ),
          ),
        ),
      ),
    );
  }
}
