import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/date_row.dart';
import 'package:food_sales_recording_application/widgets/title_text.dart';

import '../widgets/children_detail_item_history.dart';
import '../widgets/title_item_history.dart';
import '../widgets/trailing_item_history.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  List<String> listOfMonth = [
    "Jan",
    "Feb",
    "Mar",
    "Apr",
    "May",
    "Jun",
    "Jul",
    "Aug",
    "Sep",
    "Oct",
    "Nov",
    "Dec"
  ];

  int choosedMonth = 8;

  final isExpandedList1 = List<bool>.generate(1, (int index) => false);
  final isExpandedList2 = List<bool>.generate(3, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.green,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              width: double.infinity,
              color: Appcolors.darkColor,
              child: TitleText(
                text: "2023",
                isBold: true,
              ),
            ),
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              height: 48,
              color: Appcolors.mediumColor,
              child: ListView.builder(
                controller: ScrollController(
                    initialScrollOffset: MediaQuery.of(context).size.width /
                        3 *
                        (choosedMonth - 2)),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: listOfMonth.length,
                itemBuilder: (BuildContext context, int index) {
                  return Center(
                    child: Container(
                        height: 48,
                        width: MediaQuery.of(context).size.width / 3,
                        alignment: Alignment.center,
                        // color: Colors.red,
                        // padding: EdgeInsets.symmetric(horizontal: 24),
                        child: TitleText(
                          text: listOfMonth[index],
                          isBold: (index == choosedMonth - 1) ? true : false,
                        )),
                  );
                },
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(children: [
                  DateRow(
                    date: "SATURDAY, 30 JULY",
                    total: 5525000,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 1,
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
                                    setState(
                                        () => isExpandedList1[index] = value);
                                  },
                                  trailing: TrailingItemHistory(
                                    isExpanded: isExpandedList1[index],
                                  ),
                                  title: TitleItemHistory(
                                    icon: Icons.warning_amber_rounded,
                                    title: 'Kezia Angeline',
                                    subTitle: 'UNPAID',
                                    total: 300000,
                                  ),
                                  children: [
                                    for (int i = 0; i < 3; i++)
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
                  DateRow(
                    date: "FRIDAY, 28 JULY",
                    total: 5525000,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 3,
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
                                    setState(
                                        () => isExpandedList2[index] = value);
                                  },
                                  trailing: TrailingItemHistory(
                                    isExpanded: isExpandedList2[index],
                                  ),
                                  title: TitleItemHistory(
                                    icon: Icons.warning_amber_rounded,
                                    title: 'Kezia Angeline',
                                    subTitle: 'UNPAID',
                                    total: 300000,
                                  ),
                                  children: [
                                    for (int i = 0; i < 3; i++)
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
                  DateRow(
                    date: "Saturday, 01 JULY",
                    total: 5525000,
                  ),
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemCount: 3,
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
                                    setState(
                                        () => isExpandedList2[index] = value);
                                  },
                                  trailing: TrailingItemHistory(
                                    isExpanded: isExpandedList2[index],
                                  ),
                                  title: TitleItemHistory(
                                    icon: Icons.warning_amber_rounded,
                                    title: 'Kezia Angeline',
                                    subTitle: 'UNPAID',
                                    total: 300000,
                                  ),
                                  children: [
                                    for (int i = 0; i < 3; i++)
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
                ]),
              ),
            )
            // Expanded(
            //   child: Column(
            //     children: [
            //       DateRow(
            //         date: "SATURDAY, 30 JULY",
            //         total: 5525000,
            //       ),
            //       Expanded(
            //         child: Container(
            //           color: Colors.white,
            //           child: ListView.builder(
            //             shrinkWrap: true,
            //             padding: EdgeInsets.zero,
            //             itemCount: 1,
            //             itemBuilder: (context, index) {
            //               return Container(
            //                 color: Colors.white,
            //                 child: ListTileTheme(
            //                   shape: Border.all(color: Colors.green),
            //                   contentPadding: EdgeInsets.zero,
            //                   horizontalTitleGap: 0,
            //                   child: Theme(
            //                     data: Theme.of(context)
            //                         .copyWith(dividerColor: Colors.transparent),
            //                     child: Column(
            //                       children: [
            //                         ExpansionTile(
            //                           onExpansionChanged: (value) {
            //                             setState(() =>
            //                                 isExpandedList1[index] = value);
            //                           },
            //                           trailing: TrailingItemHistory(
            //                             isExpanded: isExpandedList1[index],
            //                           ),
            //                           title: TitleItemHistory(
            //                             icon: Icons.warning_amber_rounded,
            //                             title: 'Kezia Angeline',
            //                             subTitle: 'UNPAID',
            //                             total: 300000,
            //                           ),
            //                           children: [
            //                             for (int i = 0; i < 3; i++)
            //                               ChildrenDetailItemHistory(
            //                                 pcs: 1,
            //                                 name: "Beef Galantine",
            //                                 total: 120000,
            //                               )
            //                           ],
            //                         ),
            //                         Divider()
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
            // aaaa
            // Expanded(
            //   child: Column(
            //     children: [
            //       DateRow(
            //         date: "SATURDAY, 30 JULY",
            //         total: 5525000,
            //       ),
            //       Expanded(
            //         child: Container(
            //           color: Colors.white,
            //           child: ListView.builder(
            //             padding: EdgeInsets.zero,
            //             itemCount: 3,
            //             itemBuilder: (context, index) {
            //               return Container(
            //                 color: Colors.white,
            //                 child: ListTileTheme(
            //                   shape: Border.all(color: Colors.green),
            //                   contentPadding: EdgeInsets.zero,
            //                   horizontalTitleGap: 0,
            //                   child: Theme(
            //                     data: Theme.of(context)
            //                         .copyWith(dividerColor: Colors.transparent),
            //                     child: Column(
            //                       children: [
            //                         ExpansionTile(
            //                           onExpansionChanged: (value) {
            //                             setState(() =>
            //                                 isExpandedList2[index] = value);
            //                           },
            //                           trailing: TrailingItemHistory(
            //                             isExpanded: isExpandedList2[index],
            //                           ),
            //                           title: TitleItemHistory(
            //                             icon: Icons.warning_amber_rounded,
            //                             title: 'Kezia Angeline',
            //                             subTitle: 'UNPAID',
            //                             total: 300000,
            //                           ),
            //                           children: [
            //                             for (int i = 0; i < 3; i++)
            //                               ChildrenDetailItemHistory(
            //                                 pcs: 1,
            //                                 name: "Beef Galantine",
            //                                 total: 120000,
            //                               )
            //                           ],
            //                         ),
            //                         Divider()
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               );
            //             },
            //           ),
            //         ),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
