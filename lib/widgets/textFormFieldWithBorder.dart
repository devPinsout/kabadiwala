import 'package:flutter/material.dart';
import 'package:kabadiwala/utils/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TextFieldWithBorder extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final double? borderRadius;
  final Color? backgroundColor;

  TextFieldWithBorder({
    required this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.onChanged,
    this.hintStyle,
    this.validator,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
        hintText: hintText,
        hintStyle: hintStyle ?? TextStyle(color: AppColors.hinttextColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          //borderSide: BorderSide(color: borderColor ?? AppColors.tertiaryColor),
        ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: AppColors.borderColor, width: 0.3.w),
      ),
        filled: true,
        fillColor: backgroundColor ?? Colors.transparent,
      ),
    );
  }
}
