import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/title_text.dart';
import 'package:get/get.dart';

void customSnackbar(String message,
    {bool isError = true, String title = "Error"}) {
  Get.snackbar(title, message,
      titleText: TitleText(text: title),
      messageText: Text(
        message,
        style: TextStyle(color: Colors.white),
      ),
      snackPosition: SnackPosition.TOP,
      backgroundColor: isError ? Appcolors.redColor : Appcolors.greenColor);
}
