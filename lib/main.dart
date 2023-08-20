import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/pages/home_page.dart';
import 'package:food_sales_recording_application/sql/sale_helper.dart';
import 'package:food_sales_recording_application/widgets/bottom_nav_bar.dart';
import 'package:food_sales_recording_application/controllers/menu_controller.dart'
    as foodMenuController;
import 'package:get/get.dart';
import 'controllers/customer_controller.dart';
import 'dependencies.dart' as dep;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dep.init();
  await Get.find<foodMenuController.MenuController>().getMenuList();
  await Get.find<CustomerController>().getCustomerList();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetBuilder<foodMenuController.MenuController>(builder: (context) {
      return GetBuilder<CustomerController>(builder: (context) {
        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: SafeArea(child: BottomNavBar()),
        );
      });
    });
  }
}
