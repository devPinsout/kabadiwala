import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';


class CustomDottedLine extends StatelessWidget {
  final double height;
  final Axis direction;
  final WrapAlignment alignment;
  final double lineLength;
  final double lineThickness;
  final double dashLength;
  final Color dashColor;
  final double dashRadius;
  final double dashGapLength;
  final Color dashGapColor;

  CustomDottedLine({
    required this.height,
    required this.direction,
    required this.alignment,
    required this.lineLength,
    required this.lineThickness,
    required this.dashLength,
    required this.dashColor,
    required this.dashRadius,
    required this.dashGapLength,
    required this.dashGapColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 15,right: 15),
      height: height,
      child: DottedLine(
        direction: direction,
        alignment: alignment,
        lineLength: lineLength,
        lineThickness: lineThickness,
        dashLength: dashLength,
        dashColor: dashColor,
        dashRadius: dashRadius,
        dashGapLength: dashGapLength,
        dashGapColor: dashGapColor,
      ),
    );
  }
}
