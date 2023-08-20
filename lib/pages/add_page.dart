import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/pages/add_sale_page.dart';
import 'package:food_sales_recording_application/pages/menu_page.dart';

import '../utils/app_colors.dart';
import '../widgets/title_text.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 8),
            alignment: Alignment.center,
            width: double.infinity,
            color: Appcolors.darkColor,
            child: TitleText(
              text: "Add Transaction",
              isBold: true,
            ),
          ),
          Expanded(
              child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                  child: AddSalePage())),
          // Expanded(
          //   child: DefaultTabController(
          //     length: 2,
          //     child: Column(
          //       mainAxisSize: MainAxisSize.min,
          //       children: <Widget>[
          //         Container(
          //           child: Material(
          //             color: Appcolors.lightColor,
          //             child: Theme(
          //               data: ThemeData().copyWith(
          //                 splashColor: Appcolors.mediumColor,
          //               ),
          //               child: TabBar(
          //                   unselectedLabelColor: Appcolors.darkGreyColor,
          //                   labelColor: Appcolors.darkColor,
          //                   indicatorColor: Appcolors.darkColor,
          //                   tabs: [
          //                     Tab(text: "Sale"),
          //                     Tab(text: "Purchase"),
          //                   ]),
          //             ),
          //           ),
          //         ),
          //         Expanded(
          //           child: Container(
          //             margin:
          //                 EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          //             child: TabBarView(children: [
          //               Container(
          //                 child: AddSalePage(),
          //               ),
          //               Container(
          //                 child: Text("Material Purchase"),
          //               ),
          //             ]),
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          // )
        ],
      )),
    );
  }
}
