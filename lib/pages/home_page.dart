import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/sql/sale_helper.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/children_detail_item_history.dart';
import 'package:food_sales_recording_application/widgets/date_row.dart';
import 'package:food_sales_recording_application/widgets/icon_box.dart';
import 'package:food_sales_recording_application/widgets/title_item_history.dart';
import 'package:food_sales_recording_application/widgets/title_text.dart';
import 'package:iconify_flutter/icons/zondicons.dart';

import '../widgets/detail_text.dart';
import '../widgets/trailing_item_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var isExpanded = false;
  final isExpandedList = List<bool>.generate(10, (int index) => false);
  List<Map<String, dynamic>> _data = [];

  void _refreshData() async {
    final data = await SaleHelper.getSales();

    setState(() {
      _data = data;
    });

    print("DATA SQL HOME: " + _data.length.toString());
    print(_data.toString());
  }

  @override
  void initState() {
    super.initState();
    _refreshData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Container(
              color: Appcolors.darkColor,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TitleText(
                    text: "Saturday, 29 July 2023",
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: [
                      IconBox(
                        icon: Icons.assignment_outlined,
                        iconColor: Appcolors.darkColor,
                        backgroundColor: Appcolors.lightColor,
                        size: MediaQuery.of(context).size.width * 0.16,
                      ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.16,
                      //   height: MediaQuery.of(context).size.width * 0.16,
                      //   decoration: BoxDecoration(
                      //       color: Colors.orange[100],
                      //       borderRadius: BorderRadius.circular(8.0)),
                      //   child: FittedBox(
                      //     child: Icon(
                      //       Icons.assignment_outlined,
                      //     ),
                      //   ),
                      // ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            DetailText(
                              text: "Target This Month",
                              color: Appcolors.lightColor,
                              size: 10,
                            ),
                            TitleText(
                              text: "IDR 1,000,000",
                              isBold: true,
                            ),
                            Container(
                              height: 24,
                              decoration: BoxDecoration(
                                // color: Colors.blue,
                                gradient: LinearGradient(colors: [
                                  Appcolors.greenColor,
                                  Appcolors.greenColor,
                                  Appcolors.whiteColor,
                                  Appcolors.whiteColor,
                                ], stops: [
                                  0.0,
                                  0.3,
                                  0.3,
                                  1.0
                                ]),
                                border:
                                    Border.all(color: Colors.black, width: 1.0),
                                borderRadius: BorderRadius.circular(4.0),
                              ),
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: DetailText(
                                text: "700,000 more",
                                color: Appcolors.lightColor,
                                size: 10,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            DateRow(
              date: "Saturday, 29 July 2023",
              total: 525000,
            ),
            // Container(
            //   padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            //   color: Colors.grey[300],
            //   child: Row(
            //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //       children: [
            //         Text("Saturday, 29 July 2023"),
            //         Text("IDR 525,000")
            //       ]),
            // ),
            Expanded(
              child: Container(
                color: Colors.white,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Container(
                      color: Colors.white,
                      child: ListTileTheme(
                        shape: Border.all(color: Colors.green),
                        contentPadding: EdgeInsets.zero,
                        horizontalTitleGap: 0,
                        child: Theme(
                          data: Theme.of(context)
                              .copyWith(dividerColor: Colors.transparent),
                          child: Column(
                            children: [
                              ExpansionTile(
                                onExpansionChanged: (value) {
                                  setState(() => isExpandedList[index] = value);
                                },
                                trailing: TrailingItemHistory(
                                  isExpanded: isExpandedList[index],
                                ),
                                title: TitleItemHistory(
                                  icon: Icons.warning_amber_rounded,
                                  title: 'Kezia Angeline',
                                  subTitle: 'UNPAID',
                                  total: 300000,
                                ),
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    ChildrenDetailItemHistory(
                                      pcs: 1,
                                      name: "Beef Galantine",
                                      total: 120000,
                                    )
                                ],
                              ),
                              Divider()
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
