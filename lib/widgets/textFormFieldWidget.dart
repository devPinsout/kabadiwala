import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType keyboardType;
  final TextStyle? hintStyle;
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final double? borderRadius;
  final Color? backgroundColor;

  CustomTextField({
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
        hintStyle: hintStyle,
        
        filled: true,
        fillColor: backgroundColor ?? Colors.transparent,
      ),
    );
  }
}
