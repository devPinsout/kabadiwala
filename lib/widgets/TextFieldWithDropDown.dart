import 'package:flutter/material.dart';
import 'package:kabadiwala/utils/colors.dart';

class DropdownWithBorder extends StatelessWidget {
  final List<String> items;
  final String? value;
  final void Function(String?)? onChanged;
  final TextStyle? hintStyle;
  final String hintText;
  final Color? borderColor;
  final double? borderRadius;
  final Color? backgroundColor;

  DropdownWithBorder({
    required this.items,
    required this.hintText,
    this.value,
    this.onChanged,
    this.hintStyle,
    this.borderColor,
    this.borderRadius,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      value: value,
      onChanged: onChanged ?? (String? newValue) {},
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 12,horizontal: 15),
        hintText: hintText,
        hintStyle: hintStyle,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(borderRadius ?? 10.0),
          borderSide: BorderSide(color: borderColor ?? AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: AppColors.borderColor, width: 1.0),
        ),
        filled: true,
        fillColor: backgroundColor ?? Colors.transparent,
      ),
    );
  }
}
