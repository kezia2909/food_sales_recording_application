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
  List<Map<String, dynamic>> _dataItemExpanse = [];
  List<Map<String, dynamic>> _dataItem = [];

  void _refreshData() async {
    // final data = await SaleHelper.getSales();
    // final dataItem = await SaleItemsHelper.getSaleItems();

    final data = await SaleSQLController.getSales();
    final dataItem = await SaleItemSQLController.getSaleItems(null);
    setState(() {
      _data = data;
      _dataItem = dataItem;
    });

    print("DATA SQL HOME: " + _data.length.toString());
    print(_data.toString());
    print("DATA ITEM SQL HOME: " + _dataItem.length.toString());
    print(_dataItem.toString());
  }

  Future<void> _getDataItemExpanse(int sales_id) async {
    final dataItemExpanse = await SaleItemSQLController.getSaleItems(sales_id);

    setState(() {
      _dataItemExpanse = dataItemExpanse;
    });
  }

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
                  itemCount: _data.length,
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
                                onExpansionChanged: (value) async {
                                  setState(() {
                                    isExpandedList[index] = value;
                                    _getDataItemExpanse(_data[index]['id']);
                                  });
                                },
                                trailing: TrailingItemHistory(
                                  isExpanded: isExpandedList[index],
                                ),
                                title: TitleItemHistory(
                                  icon: Icons.warning_amber_rounded,
                                  title: _data[index]['customer_name'],
                                  subTitle: 'UNPAID',
                                  total: _data[index]['total'],
                                ),
                                children: [
                                  FutureBuilder<List<TransactionItemModel>>(
                                    future:
                                        _getItemTransaction(_data[index]['id']),
                                    builder: (context, snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return CircularProgressIndicator(); // Show loading indicator while fetching data
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else if (!snapshot.hasData ||
                                          snapshot.data!.isEmpty) {
                                        return Text('No items available.');
                                      } else {
                                        return Column(
                                            children: snapshot.data!.map(
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
