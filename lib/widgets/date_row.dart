import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/detail_text.dart';
import 'package:intl/intl.dart';

class DateRow extends StatelessWidget {
  final String date;
  final int total;
  const DateRow({super.key, required this.date, required this.total});

  @override
  Widget build(BuildContext context) {
    var totalText = NumberFormat.decimalPattern().format(total);
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      color: Appcolors.lightGreyColor,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        DetailText(
          text: date,
          color: Appcolors.darkGreyColor,
        ),
        DetailText(
          text: "IDR " + totalText,
          color: Appcolors.darkGreyColor,
        ),
      ]),
    );
  }
}
