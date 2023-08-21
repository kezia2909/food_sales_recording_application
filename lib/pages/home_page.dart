import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/models/transaction_item_model.dart';
import 'package:food_sales_recording_application/sql_controllers/sale_helper.dart';
import 'package:food_sales_recording_application/sql_controllers/sale_items_helper.dart';
import 'package:food_sales_recording_application/sql_controllers/sale_items_sql_controller.dart';
import 'package:food_sales_recording_application/sql_controllers/sales_sql_controller.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/children_detail_item_history.dart';
import 'package:food_sales_recording_application/widgets/date_row.dart';
import 'package:food_sales_recording_application/widgets/icon_box.dart';
import 'package:food_sales_recording_application/widgets/title_item_history.dart';
import 'package:food_sales_recording_application/widgets/title_text.dart';
import 'package:get/get.dart';
import 'package:iconify_flutter/icons/zondicons.dart';
import 'package:intl/intl.dart';

import '../widgets/detail_text.dart';
import '../widgets/trailing_item_history.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<List<bool>> isExpandedList = [];
  List<Map<String, dynamic>> _dataUnpaid = [];
  List<Map<String, dynamic>> _dataItemExpanse = [];
  List<Map<String, dynamic>> _dataItem = [];
  int _totalThisMonth = 0;
  int _targetThisMonth = 0;
  double _percentageThisMonth = 0;
  int _moreThisMonth = 0;
  final formatCurrency = NumberFormat.decimalPattern();

  bool isPaidOff = false;

  Map<String, List<Map<String, dynamic>>> groupedDataSales = {};

  void _refreshData() async {
    final totalThisMonth = await SaleSQLController.getTotalSalesThisMonth();
    print("TOTAL : $totalThisMonth");


    final dataUnpaid = await SaleSQLController.getSales(unpaidOnly: true);
    int targetThisMonth = 5000;

    double percentageThisMonth = 0.0;
    percentageThisMonth = (totalThisMonth as int).toDouble() / targetThisMonth;
    int moreThisMonth = targetThisMonth - totalThisMonth;
    print("TOTAL : $percentageThisMonth");
    setState(() {
      _dataUnpaid = dataUnpaid;
      _totalThisMonth = totalThisMonth as int;
      _targetThisMonth = targetThisMonth;
      _percentageThisMonth = percentageThisMonth;
      _moreThisMonth = moreThisMonth;
    });

    if (_dataUnpaid.length != 0) {
      settingData();
    }

    print("CHECK BOOL : $isExpandedList");

    // print("DATA SQL HOME: " + _data.length.toString());
    // print(_data.toString());
    // print("DATA ITEM SQL HOME: " + _dataItem.length.toString());
    // print(_dataItem.toString());
  }

  void settingData() {
    isExpandedList.clear();
    groupedDataSales.clear();
    String tempCustomer = "";
    bool firstTime = true;

    for (var sale in _dataUnpaid) {
      String customerName = sale['customer_name'];

      if (!groupedDataSales.containsKey(customerName)) {
        print("START - masuk");
        groupedDataSales[customerName] = [];
        if (firstTime == false) {
          print("START - not first time");
          print(
              "START - $tempCustomer : ${groupedDataSales[tempCustomer]!.length}");

          var tempExpandedList = List<bool>.generate(
              groupedDataSales[tempCustomer]!.length, (int index) => false);
          isExpandedList.add(tempExpandedList);
        }
        firstTime = false;
        tempCustomer = customerName;
      }
      groupedDataSales[customerName]!.add(sale);
    }
    print("START - last");
    print("$tempCustomer : ${groupedDataSales[tempCustomer]!.length}");

    var tempExpandedList = List<bool>.generate(
        groupedDataSales[tempCustomer]!.length, (int index) => false);
    isExpandedList.add(tempExpandedList);
    print("GROUP");
    print(groupedDataSales.toString());
  }

  // Future<void> _getDataItemExpanse(int sales_id) async {
  //   final dataItemExpanse = await SaleItemSQLController.getSaleItems(sales_id);

  //   setState(() {
  //     _dataItemExpanse = dataItemExpanse;
  //   });
  // }

  Future<List<TransactionItemModel>> _getItemTransaction(int id) async {
    final List<Map<String, dynamic>> items =
        await SaleItemSQLController.getSaleItems(id);
    print("GET ITEM EXPANSE");
    print(items.toString());
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
    _refreshData();
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

  String formatDateString(String dateString) {
    DateTime dateTime = DateTime.parse(dateString);
    DateFormat formatter = DateFormat('EEEE, d MMMM y');
    String formattedDate = formatter.format(dateTime);
    return formattedDate;
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
        color: Appcolors.whiteColor,
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
                              text: formatCurrency
                                  .format(_targetThisMonth)
                                  .toString(),
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
                                  _percentageThisMonth,
                                  _percentageThisMonth,
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
                                text:
                                    "${formatCurrency.format(_moreThisMonth).toString()} more",
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
            Expanded(
              child: _dataUnpaid.length == 0
                  ? Container(child: Text("no data"))
                  : ListView.builder(
                      itemCount: groupedDataSales.length,
                      itemBuilder: (BuildContext context, int indexGroup) {
                        print("CHECK - length : ${groupedDataSales.length}");
                        print(
                            "CHECK - data : ${groupedDataSales.entries.toList()[indexGroup]}");
                        print(
                            "CHECK - items : ${groupedDataSales.entries.toList()[indexGroup].value[0]['customer_name']}");

                        int totalSum = groupedDataSales.entries
                            .toList()[indexGroup]
                            .value
                            .fold(
                                0, (sum, entry) => sum + entry['total'] as int);
                        return Column(children: [
                          DateRow(
                            date: groupedDataSales.entries
                                .toList()[indexGroup]
                                .key,
                            total: totalSum,
                          ),
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            padding: EdgeInsets.zero,
                            itemCount: groupedDataSales.entries
                                .toList()[indexGroup]
                                .value
                                .length,
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
                                          onExpansionChanged: (value) async {
                                            setState(() {
                                              print(
                                                  "CHECK INDEX : [$indexGroup][$indexItem]");
                                              isExpandedList[indexGroup]
                                                      [indexItem] =
                                                  !isExpandedList[indexGroup]
                                                      [indexItem];
                                            });
                                          },
                                          trailing: TrailingItemHistory(
                                            isExpanded:
                                                isExpandedList[indexGroup]
                                                    [indexItem],
                                          ),
                                          title: TitleItemHistory(
                                            icon: Icons.warning_amber_rounded,
                                            title: formatDateString(
                                                groupedDataSales
                                                        .entries
                                                        .toList()[indexGroup]
                                                        .value[indexItem]
                                                    ['createdAt']),
                                            subTitle: 'UNPAID',
                                            total: groupedDataSales.entries
                                                .toList()[indexGroup]
                                                .value[indexItem]['total'],
                                          ),
                                          children: [
                                            FutureBuilder<
                                                List<TransactionItemModel>>(
                                              future: _getItemTransaction(
                                                  groupedDataSales.entries
                                                      .toList()[indexGroup]
                                                      .value[indexItem]['id']),
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState ==
                                                    ConnectionState.waiting) {
                                                  return CircularProgressIndicator(); // Show loading indicator while fetching data
                                                } else if (snapshot.hasError) {
                                                  return Text(
                                                      'Error: ${snapshot.error}');
                                                } else if (!snapshot.hasData ||
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
                                                                alignment: Alignment
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
                                                                  child: Column(
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
                                                                              text: NumberFormat.decimalPattern().format(groupedDataSales.entries.toList()[indexGroup].value[indexItem]['delivery_fee']),
                                                                              isBold: true,
                                                                            )
                                                                          ]),
                                                                      DetailText(
                                                                        text: groupedDataSales
                                                                            .entries
                                                                            .toList()[indexGroup]
                                                                            .value[indexItem]['delivery_address'],
                                                                        size:
                                                                            12,
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            5,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          GestureDetector(
                                                                              onTap: () {
                                                                                showConfirmationDialog(groupedDataSales.entries.toList()[indexGroup].value[indexItem]['id']);
                                                                                // setState(() {
                                                                                //   isPaidOff = !isPaidOff;
                                                                                // });
                                                                              },
                                                                              child: Icon(Icons.check_box_outline_blank)),
                                                                          SizedBox(
                                                                            width:
                                                                                5,
                                                                          ),
                                                                          Text(
                                                                              "Paid Off"),
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
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.1,
                                                    ),
                                                  ],
                                                )),
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
                        ]);
                      }),
            )
          ],
        ),
      ),
    );
  }
}
