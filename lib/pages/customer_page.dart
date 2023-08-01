import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/widgets/detail_text.dart';

import '../utils/app_colors.dart';
import '../widgets/children_detail_item_history.dart';
import '../widgets/title_item_history.dart';
import '../widgets/title_text.dart';
import '../widgets/trailing_item_history.dart';

class CustomerPage extends StatefulWidget {
  const CustomerPage({super.key});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  final isExpandedList = List<bool>.generate(10, (int index) => false);

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
              text: "Customer",
              isBold: true,
            ),
          ),
          Expanded(
            child: Container(
              color: Colors.white,
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: 10,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Container(
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    DetailText(
                                      text: "Kezia Angeline",
                                      isBold: true,
                                      size: 16,
                                    ),
                                    DetailText(
                                      text: "Melati IV/12",
                                      color: Appcolors.mediumColor,
                                    )
                                  ]),
                            ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: FittedBox(
                                child: Icon(
                                  Icons.keyboard_arrow_right,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Divider()
                    ],
                  );
                },
              ),
            ),
          )
        ],
      )),
    );
  }
}
