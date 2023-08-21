import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/date_row.dart';
import 'package:food_sales_recording_application/widgets/title_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../models/transaction_item_model.dart';
import '../sql_controllers/sale_items_sql_controller.dart';
import '../sql_controllers/sales_sql_controller.dart';
import '../widgets/children_detail_item_history.dart';
import '../widgets/detail_text.dart';
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

  int choosedMonth = 0;

  final isExpandedList1 = List<bool>.generate(1, (int index) => false);
  final isExpandedList2 = List<bool>.generate(3, (int index) => false);
  int idExpanded = 0;
  bool checkIdExpanded = false;

  List<Map<String, dynamic>> _dataThisMonth = [];
  List<Map<String, dynamic>> _dataItemExpanse = [];

  Map<String, List<Map<String, dynamic>>> groupedData = {};
  List<List<bool>> isExpandedList = [];
  int counterGroup = 0;

  bool isPaidOff = false;

  void _refreshData(String month) async {
    final dataThisMonth = await SaleSQLController.getSalesByDate(month);
    setState(() {
      counterGroup = -1;
      _dataThisMonth = dataThisMonth;
    });

    print("DATA SQL THIS MONTH HISTORY: " + _dataThisMonth.length.toString());
    print(_dataThisMonth.toString());

    if (_dataThisMonth.length == 0) {
    } else {
      _settingData();
    }
  }

  void _settingData() {
    isExpandedList.clear();
    groupedData.clear();
    String tempDate = "";
    int counter = 0;
    bool firstTime = true;

    for (var dataItem in _dataThisMonth) {
      DateTime createdAt = DateTime.parse(dataItem['createdAt']);
      print("DATE : $createdAt");
      // String formattedDate =
      //     "${createdAt.day} ${createdAt.month}, ${createdAt.year}";

      String formattedDate =
          DateFormat('EEEE, d MMMM y', 'en_US').format(createdAt);

      if (!groupedData.containsKey(formattedDate)) {
        print("try - ");
        print("check : ${groupedData.isNotEmpty}");
        groupedData[formattedDate] = [];
        print("check : ${groupedData.isNotEmpty}");
        if (firstTime == false) {
          print("try - NOT EMPTY");
          print(tempDate);
          print(formattedDate);
          print("data : ${groupedData[tempDate]}");
          print("length : ${groupedData[tempDate]!.length.toString()}");

          var tempExpandedList = List<bool>.generate(
              groupedData[tempDate]!.length, (int index) => false);
          isExpandedList.add(tempExpandedList);
        }
        firstTime = false;
        tempDate = formattedDate;
      }

      groupedData[formattedDate]!.add(dataItem);
    }
    var tempExpandedList = List<bool>.generate(
        groupedData[tempDate]!.length, (int index) => false);
    isExpandedList.add(tempExpandedList);
    print("GROUP");
    print(groupedData.toString());
    print("BOOL : $isExpandedList");
  }

  Future<List<TransactionItemModel>> _getItemTransaction(int id) async {
    final List<Map<String, dynamic>> items =
        await SaleItemSQLController.getSaleItems(id);
    // print("GET ITEM EXPANSE");
    // print(items.toString());
    return items
        .map((e) => TransactionItemModel(
              name: e["name"],
              price: e["price"],
              pcs: e["pcs"],
            ))
        .toList();
  }

  Future<void> updateIsPaidOff(int id) async {
    await SaleSQLController.updateIsPaidOff(id);
    String month = "";
    if (choosedMonth < 10) {
      month = "0$choosedMonth";
    } else {
      month = "$choosedMonth";
    }
    _refreshData(month);
  }

  void showConfirmationDialog(int id) {
    Get.defaultDialog(
      title: 'Confirmation',
      middleText: 'Are you sure the transaction is paid off?',
      actions: [
        ElevatedButton(
          onPressed: () {
            updateIsPaidOff(id);
            Get.back(result: true); // Return true when "Yes" is pressed
          },
          child: Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Get.back(result: false); // Return false when "No" is pressed
          },
          child: Text('No'),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    var now = new DateTime.now();
    var formatter = new DateFormat('MM');
    String month = formatter.format(now);
    choosedMonth = int.parse(month);
    _refreshData(month);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Appcolors.whiteColor,
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          print(listOfMonth[index]);
                          choosedMonth = index + 1;
                          String month = "";
                          if (choosedMonth < 10) {
                            month = "0$choosedMonth";
                          } else {
                            month = "$choosedMonth";
                          }
                          _refreshData(month);
                        });
                      },
                      child: Container(
                          color: (index == choosedMonth - 1)
                              ? Appcolors.greenColor
                              : Appcolors.mediumColor,
                          height: 48,
                          width: MediaQuery.of(context).size.width / 3,
                          alignment: Alignment.center,
                          // color: Colors.red,
                          // padding: EdgeInsets.symmetric(horizontal: 24),
                          child: TitleText(
                            text: listOfMonth[index],
                            isBold: (index == choosedMonth - 1) ? true : false,
                          )),
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: _dataThisMonth.length == 0
                  ? Container()
                  : ListView.builder(
                      itemCount: groupedData.length,
                      itemBuilder: (BuildContext context, int indexGroup) {
                        print("length : ${groupedData.length}");
                        print(
                            "data : ${groupedData.entries.toList()[indexGroup]}");
                        print(
                            "items : ${groupedData.entries.toList()[indexGroup].value[0]['customer_name']}");
                        print(groupedData.entries
                            .toList()[indexGroup]
                            .value[0]['total']
                            .runtimeType);
                        int totalSum = groupedData.entries
                            .toList()[indexGroup]
                            .value
                            .fold(
                                0, (sum, entry) => sum + entry['total'] as int);
                        print("SUM : $totalSum");
                        return Column(
                          children: [
                            DateRow(
                              date:
                                  groupedData.entries.toList()[indexGroup].key,
                              total: totalSum,
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              padding: EdgeInsets.zero,
                              itemCount: groupedData.entries
                                  .toList()[indexGroup]
                                  .value
                                  .length,
                              // itemCount: 2,
                              itemBuilder: (context, indexItem) {
                                return Container(
                                  color: Colors.white,
                                  child: ListTileTheme(
                                    shape: Border.all(color: Colors.green),
                                    contentPadding: EdgeInsets.zero,
                                    horizontalTitleGap: 0,
                                    child: Theme(
                                      data: Theme.of(context).copyWith(
                                          dividerColor: Colors.transparent),
                                      child: Column(
                                        children: [
                                          ExpansionTile(
                                            onExpansionChanged: (value) {
                                              setState(() {
                                                isExpandedList[indexGroup]
                                                        [indexItem] =
                                                    !isExpandedList[indexGroup]
                                                        [indexItem];
                                              });
                                            },
                                            trailing: TrailingItemHistory(
                                                isExpanded:
                                                    isExpandedList[indexGroup]
                                                        [indexItem]),
                                            title: groupedData.entries
                                                            .toList()[indexGroup]
                                                            .value[indexItem]
                                                        ['is_paid_off'] ==
                                                    1
                                                ? TitleItemHistory(
                                                    icon: Icons
                                                        .warning_amber_rounded,
                                                    title: groupedData.entries
                                                            .toList()[indexGroup]
                                                            .value[indexItem]
                                                        ['customer_name'],
                                                    subTitle: 'PAID OFF',
                                                    total:
                                                        groupedData.entries
                                                                .toList()[
                                                                    indexGroup]
                                                                .value[
                                                            indexItem]['total'],
                                                  )
                                                : TitleItemHistory(
                                                    icon: Icons
                                                        .warning_amber_rounded,
                                                    title: groupedData.entries
                                                            .toList()[indexGroup]
                                                            .value[indexItem]
                                                        ['customer_name'],
                                                    subTitle: 'UNPAID',
                                                    total:
                                                        groupedData.entries
                                                                .toList()[
                                                                    indexGroup]
                                                                .value[
                                                            indexItem]['total'],
                                                  ),
                                            children: [
                                              FutureBuilder<
                                                  List<TransactionItemModel>>(
                                                future:
                                                    _getItemTransaction(
                                                        groupedData.entries
                                                                .toList()[
                                                                    indexGroup]
                                                                .value[
                                                            indexItem]['id']),
                                                builder: (context, snapshot) {
                                                  if (snapshot
                                                          .connectionState ==
                                                      ConnectionState.waiting) {
                                                    return CircularProgressIndicator(); // Show loading indicator while fetching data
                                                  } else if (snapshot
                                                      .hasError) {
                                                    return Text(
                                                        'Error: ${snapshot.error}');
                                                  } else if (!snapshot
                                                          .hasData ||
                                                      snapshot.data!.isEmpty) {
                                                    return Text(
                                                        'No items available.');
                                                  } else {
                                                    return Column(
                                                        children:
                                                            snapshot.data!.map(
                                                      (item) {
                                                        return ChildrenDetailItemHistory(
                                                          pcs: item.pcs,
                                                          name: item.name,
                                                          total: item.price,
                                                        );
                                                      },
                                                    ).toList());
                                                  }
                                                },
                                              ),
                                              Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 20),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
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
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          right:
                                                                              4),
                                                                  alignment:
                                                                      Alignment
                                                                          .centerRight,
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.15,
                                                                  child:
                                                                      Container(),
                                                                ),
                                                                Expanded(
                                                                  child:
                                                                      Container(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Row(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.spaceBetween,
                                                                            children: [
                                                                              DetailText(
                                                                                text: "Delivery Fee",
                                                                                isBold: true,
                                                                              ),
                                                                              DetailText(
                                                                                text: NumberFormat.decimalPattern().format(groupedData.entries.toList()[indexGroup].value[indexItem]['delivery_fee']),
                                                                                isBold: true,
                                                                              )
                                                                            ]),
                                                                        DetailText(
                                                                          text: groupedData
                                                                              .entries
                                                                              .toList()[indexGroup]
                                                                              .value[indexItem]['delivery_address'],
                                                                          size:
                                                                              12,
                                                                        ),
                                                                        groupedData.entries.toList()[indexGroup].value[indexItem]['is_paid_off'] ==
                                                                                1
                                                                            ? Container()
                                                                            : SizedBox(
                                                                                height: 5,
                                                                              ),
                                                                        groupedData.entries.toList()[indexGroup].value[indexItem]['is_paid_off'] ==
                                                                                1
                                                                            ? Container()
                                                                            : Row(
                                                                                children: [
                                                                                  GestureDetector(
                                                                                      onTap: () {
                                                                                        showConfirmationDialog(groupedData.entries.toList()[indexGroup].value[indexItem]['id']);
                                                                                      },
                                                                                      child: Icon(isPaidOff ? Icons.check_box : Icons.check_box_outline_blank)),
                                                                                  SizedBox(
                                                                                    width: 5,
                                                                                  ),
                                                                                  Text("Paid Off"),
                                                                                ],
                                                                              ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                              ]),
                                                        ),
                                                      ),
                                                      Container(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                        height: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width *
                                                            0.1,
                                                      ),
                                                    ],
                                                  )),
                                              // for (int i = 0; i < 3; i++)
                                              //   ChildrenDetailItemHistory(
                                              //     pcs: 1,
                                              //     name: "Beef Galantine",
                                              //     total: 120000,
                                              //   )
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
                          ],
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
