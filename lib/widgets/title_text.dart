import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';

class TitleText extends StatelessWidget {
  final String text;
  bool isBold;

  TitleText({super.key, required this.text, this.isBold = false});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
          color: Appcolors.lightColor,
          fontSize: 18,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal),
    );
  }
}
