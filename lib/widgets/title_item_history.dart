import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../utils/app_colors.dart';
import 'detail_text.dart';
import 'icon_box.dart';

class TitleItemHistory extends StatelessWidget {
  final IconData icon;
  final String title;
  // final String subTitle;
  final int total;
  bool isPaidOff;
  TitleItemHistory(
      {super.key,
      required this.icon,
      required this.title,
      // required this.subTitle,
      required this.total,
      this.isPaidOff = false});

  @override
  Widget build(BuildContext context) {
    var totalText = NumberFormat.decimalPattern().format(total);

    return Container(
      margin: EdgeInsets.only(left: 20),
      color: Colors.white,
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        IconBox(
          icon: isPaidOff
              ? Icons.assignment_outlined
              : Icons.warning_amber_rounded,
          iconColor: isPaidOff ? Appcolors.greenColor : Appcolors.mediumColor,
          backgroundColor: Colors.transparent,
          size: MediaQuery.of(context).size.width * 0.15,
          marginRight: 4,
        ),
        Expanded(
          child: Container(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      DetailText(
                        text: title,
                      ),
                      isPaidOff
                          ? DetailText(
                              text: "PAID OFF",
                              color: Appcolors.greenColor,
                              isBold: true,
                            )
                          : DetailText(
                              text: "UNPAID",
                              color: Appcolors.mediumColor,
                              isBold: true,
                            )
                    ],
                  ),
                  DetailText(
                    text: totalText,
                    color: Appcolors.greenColor,
                    isBold: true,
                  )
                ]),
          ),
        ),
      ]),
    );
  }
}
