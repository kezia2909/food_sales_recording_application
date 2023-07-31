import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/date_row.dart';
import 'package:food_sales_recording_application/widgets/icon_box.dart';
import 'package:food_sales_recording_application/widgets/title_text.dart';
import 'package:iconify_flutter/icons/zondicons.dart';

import '../widgets/detail_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // var isExpanded = false;
  final isExpandedList = List<bool>.generate(10, (int index) => false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.amberAccent,
        child: Column(
          children: [
            Container(
              color: Colors.brown,
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
                                trailing: Container(
                                  margin: EdgeInsets.only(right: 20),
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: FittedBox(
                                    child: Icon(
                                      isExpandedList[index]
                                          ? Icons.keyboard_arrow_up
                                          : Icons.keyboard_arrow_right,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                title: Container(
                                  margin: EdgeInsets.only(left: 20),
                                  color: Colors.white,
                                  child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        IconBox(
                                          icon: Icons.warning_amber_rounded,
                                          iconColor: Appcolors.mediumColor,
                                          backgroundColor: Colors.transparent,
                                          size: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.15,
                                          marginRight: 4,
                                        ),
                                        // Container(
                                        //   margin: EdgeInsets.only(right: 4),
                                        //   width: MediaQuery.of(context)
                                        //           .size
                                        //           .width *
                                        //       0.15,
                                        //   height: MediaQuery.of(context)
                                        //           .size
                                        //           .width *
                                        //       0.15,
                                        //   child: FittedBox(
                                        //     child: Icon(
                                        //       Icons.warning_amber_rounded,
                                        //       color: Colors.brown,
                                        //     ),
                                        //   ),
                                        // ),
                                        Expanded(
                                          child: Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      DetailText(
                                                        text: "Kezia Angeline",
                                                      ),
                                                      DetailText(
                                                        text: "UNPAID",
                                                        color: Appcolors
                                                            .mediumColor,
                                                        isBold: true,
                                                      )
                                                    ],
                                                  ),
                                                  DetailText(
                                                    text: "300,000",
                                                    color: Appcolors.greenColor,
                                                    isBold: true,
                                                  )
                                                ]),
                                          ),
                                        ),
                                      ]),
                                ),
                                children: [
                                  for (int i = 0; i < 5; i++)
                                    Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Expanded(
                                              child: Container(
                                                color: Colors.white,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Container(
                                                        margin: EdgeInsets.only(
                                                            right: 4),
                                                        alignment: Alignment
                                                            .centerRight,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.15,
                                                        child: DetailText(
                                                            text: "1x"),
                                                      ),
                                                      Expanded(
                                                        child: Container(
                                                          child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                DetailText(
                                                                    text:
                                                                        "Beef Galantine"),
                                                                DetailText(
                                                                    text:
                                                                        "300,000")
                                                              ]),
                                                        ),
                                                      ),
                                                    ]),
                                              ),
                                            ),
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                            ),
                                          ],
                                        ))
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
