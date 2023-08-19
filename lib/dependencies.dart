import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/api_client.dart';
import 'package:food_sales_recording_application/repository/customer_repo.dart';
import 'package:food_sales_recording_application/repository/menu_repo.dart';
import 'package:food_sales_recording_application/controllers/menu_controller.dart'
    as foodMenuController;
import 'package:get/get.dart';

import 'controllers/customer_controller.dart';

Future<void> init() async {
  Get.lazyPut(
    () => ApiClient(appBaseUrl: "https://64de1e95825d19d9bfb21bec.mockapi.io"),
  );

  Get.lazyPut(
    () => MenuRepo(apiClient: Get.find()),
  );
  Get.lazyPut(
    () => CustomerRepo(apiClient: Get.find()),
  );

  Get.lazyPut(
    () => foodMenuController.MenuController(menuRepo: Get.find()),
  );
  Get.lazyPut(
    () => CustomerController(customerRepo: Get.find()),
  );
}
