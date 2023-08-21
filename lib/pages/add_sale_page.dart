import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/controllers/customer_controller.dart';
import 'package:food_sales_recording_application/models/menu_model.dart';
import 'package:food_sales_recording_application/models/transaction_item_model.dart';
import 'package:food_sales_recording_application/sql_controllers/sale_helper.dart';
import 'package:food_sales_recording_application/sql_controllers/sale_items_helper.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/custom_number_text_field.dart';
import 'package:food_sales_recording_application/widgets/custom_text_field.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

import '../models/customer_model.dart';
import '../sql_controllers/sale_items_sql_controller.dart';
import '../sql_controllers/sales_sql_controller.dart';
import 'package:food_sales_recording_application/controllers/menu_controller.dart'
    as foodMenuController;

class AddSalePage extends StatefulWidget {
  const AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  final formatCurrency = NumberFormat.decimalPattern();

  // final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _deliveryFeeController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _pcsController = TextEditingController();
  final SingleValueDropDownController _itemController =
      SingleValueDropDownController();
  List<String> listCustomer = [
    "Kezia",
    "Angeline",
    "customer3",
    "customer4",
    "customer5",
    "customer6",
  ];
  List<String> items = [
    "Beef Galantine",
    "Sate Babi Rempah",
    "Nasi Ayam Bumbu Rujak",
    "item 4",
    "item 5",
    "item 6",
    "item 7",
    "item 8",
    "item 9",
    "item 10",
    "item 11",
    "item 12",
    "item 13",
    "item 14",
    "item 15",
    "item 16",
    "item 17",
    "item 18",
    "item 19",
    "item 20",
    "item 21",
  ];
  FocusNode searchFocusNode = FocusNode();
  FocusNode textFieldFocusNode = FocusNode();
  String? selectedValue;
  String? selectedCustomer;
  List<TransactionItemModel> _items = [];
  int totalSale = 0;
  int totalItems = 0;
  int deliveryFee = 0;

  int sales_id = -1;
  String itemName = "";
  int itemPcs = 0;
  int itemPrice = 0;
  String customerName = "";
  int customer_id = -1;
  bool isPaidOff = false;

  void _refreshData() async {
    totalSale = 0;
    totalItems = 0;
    deliveryFee = 0;
    isPaidOff = false;
    customer_id = -1;
    _addressController.clear();
    _deliveryFeeController.clear();
    _priceController.clear();
    _pcsController.clear();
    _itemController.clearDropDown();
    selectedCustomer = null;
    selectedValue = null;
    _items.clear();
    // final data = await SaleSQLController.getSales();
    // final dataItem = await SaleItemSQLController.getSaleItems(null);
    // setState(() {
    //   _data = data;
    //   _dataItem = dataItem;
    // });

    // print("DATA SQL HOME: " + _data.length.toString());
    // print(_data.toString());
    // print("DATA ITEM SQL HOME: " + _dataItem.length.toString());
    // print(_dataItem.toString());
  }

  Future<void> _addSale() async {
    sales_id = await SaleSQLController.createSale(
        customer_id,
        customerName,
        _addressController.text,
        int.tryParse(_deliveryFeeController.text.replaceAll(',', '')) ?? 0,
        totalSale,
        isPaidOff);
    setState(() {});
    print("items : ${_items.toString()}");

    _items.forEach(
      (element) {
        _addSaleItem(sales_id, element);
      },
    );
    _refreshData();

    print("adding data success");
  }

  Future<void> _addSaleItem(int sales_id, TransactionItemModel item) async {
    await SaleItemSQLController.createSaleItem(
        sales_id, item.pcs, item.name, item.price, item.pcs * item.price);
    _refreshData();

    setState(() {});
  }

  void updateDeliveryFee() {
    String deliveryFeeText = _deliveryFeeController.text.replaceAll(',', '');
    int fee = int.tryParse(deliveryFeeText) ?? 0;

    setState(() {
      deliveryFee = fee;
    });
  }

  @override
  void initState() {
    super.initState();
    print("init state add sale page");
    _refreshData();
    _deliveryFeeController.addListener(updateDeliveryFee);

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      body: Container(
        padding: EdgeInsets.only(top: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // CustomTextField(
            //   textEditingController: _nameController,
            //   labelText: 'Customer name',
            //   hintText: 'John Doe',
            // ),
            InputDecorator(
              decoration: InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                border: new OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    const Radius.circular(8),
                  ),
                  borderSide: new BorderSide(
                    color: Colors.black,
                    width: 1.0,
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: GetBuilder<CustomerController>(builder: (customers) {
                  return DropdownButton<String>(
                    value: selectedCustomer,
                    // isDense: true,
                    hint: Text("Customer Name"),
                    isExpanded: true,
                    onChanged: (newValue) {
                      setState(() {
                        Map<String, dynamic> customer =
                            customers.customerList.firstWhere(
                          (element) {
                            if (newValue ==
                                CustomerModel.fromJson(element).id) {
                              return true;
                            }
                            return false;
                          },
                        );
                        selectedCustomer = newValue;
                        customer_id =
                            int.parse(CustomerModel.fromJson(customer).id!);
                        customerName = CustomerModel.fromJson(customer).name;
                        _addressController.text =
                            CustomerModel.fromJson(customer).address;
                      });
                    },
                    items: customers.customerList.map(
                      (element) {
                        return DropdownMenuItem<String>(
                          value: CustomerModel.fromJson(element).id,
                          child: Text(CustomerModel.fromJson(element).name),
                        );
                      },
                    ).toList(),
                    // items: listCustomer.map((String value) {
                    //   return DropdownMenuItem<String>(
                    //     value: value,
                    //     child: Text(value),
                    //   );
                    // }).toList(),
                  );
                }),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            CustomTextField(
              textEditingController: _addressController,
              labelText: 'Customer address',
              hintText: 'street no 100',
            ),
            SizedBox(
              height: 10,
            ),
            CustomNumberTextField(
              textEditingController: _deliveryFeeController,
              labelText: 'Delivery Fee',
              hintText: '0',
            ),
            const SizedBox(
              height: 10,
            ),
            Text("Foods : "),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  flex: 3,
                  child: InputDecorator(
                    decoration: InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8),
                        ),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    child: DropdownButtonHideUnderline(
                      child: GetBuilder<foodMenuController.MenuController>(
                          builder: (menus) {
                        return DropdownButton<String>(
                          value: selectedValue,
                          // isDense: true,
                          isExpanded: true,
                          onChanged: (newValue) {
                            // _priceController.text =
                            //     formatCurrency.format(22000).toString();
                            // setState(() {
                            //   selectedValue = newValue;
                            // });

                            setState(() {
                              Map<String, dynamic> menu =
                                  menus.menuList.firstWhere(
                                (element) {
                                  if (newValue ==
                                      MenuModel.fromJson(element).id) {
                                    return true;
                                  }
                                  return false;
                                },
                              );

                              itemName = MenuModel.fromJson(menu).name;
                              itemPrice = MenuModel.fromJson(menu).price;
                              selectedValue = newValue;
                              _priceController.text = formatCurrency
                                  .format(MenuModel.fromJson(menu).price)
                                  .toString();
                            });
                          },
                          items: menus.menuList.map(
                            (element) {
                              return DropdownMenuItem<String>(
                                value: MenuModel.fromJson(element).id,
                                child: Text(MenuModel.fromJson(element).name),
                              );
                            },
                          ).toList(),
                          // items: items.map((String value) {
                          //   return DropdownMenuItem<String>(
                          //     value: value,
                          //     child: Text(value),
                          //   );
                          // }).toList(),
                        );
                      }),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 2,
                  child: CustomNumberTextField(
                    textEditingController: _priceController,
                    labelText: "price",
                    hintText: "100000",
                    readOnly: true,
                  ),
                ),
                SizedBox(
                  width: 10,
                ),
                Flexible(
                  flex: 1,
                  child: TextField(
                    controller: _pcsController,
                    decoration: new InputDecoration(
                      hintText: "0",
                      labelText: "pcs",
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                      border: new OutlineInputBorder(
                        borderRadius: const BorderRadius.all(
                          const Radius.circular(8),
                        ),
                        borderSide: new BorderSide(
                          color: Colors.black,
                          width: 1.0,
                        ),
                      ),
                    ),
                    keyboardType: TextInputType.numberWithOptions(
                        signed: false, decimal: false),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                if (itemName != "" &&
                    itemPrice != 0 &&
                    _pcsController.value != 0) {
                  itemPcs = int.parse(_pcsController.text);
                  setState(() {
                    _items.add(TransactionItemModel(
                      name: itemName,
                      price: itemPrice,
                      pcs: itemPcs,
                    ));
                    totalItems += (itemPcs * itemPrice);
                    print(_items);
                  });
                }
              },
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Appcolors.darkColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "add item",
                  style: TextStyle(color: Appcolors.lightColor),
                ),
              ),
            ),
            Row(
              children: [
                Expanded(flex: 1, child: Text("pcs")),
                Expanded(flex: 3, child: Text("name")),
                Expanded(flex: 2, child: Text("price")),
                Expanded(flex: 2, child: Text("total")),
              ],
            ),
            Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: _items.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1, child: Text("${_items[index].pcs}")),
                          Expanded(
                              flex: 3, child: Text("${_items[index].name}")),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  "${formatCurrency.format(_items[index].price)}")),
                          Expanded(
                              flex: 2,
                              child: Text(
                                  "${formatCurrency.format(_items[index].price * _items[index].pcs)}")),
                        ],
                      ),
                      (index != _items.length - 1) ? Divider() : Container(),
                    ],
                  );
                },
              ),
            ),
            Divider(),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TOTAL : ${formatCurrency.format(totalItems + deliveryFee)}",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: () {
                            setState(() {
                              isPaidOff = !isPaidOff;
                            });
                          },
                          child: Icon(isPaidOff
                              ? Icons.check_box
                              : Icons.check_box_outline_blank)),
                      SizedBox(
                        width: 5,
                      ),
                      Text("Paid Off"),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            GestureDetector(
              onTap: () {
                totalSale = totalItems + deliveryFee;
                _addSale();
              },
              child: Container(
                width: double.maxFinite,
                padding: EdgeInsets.symmetric(vertical: 5),
                margin: EdgeInsets.symmetric(vertical: 5),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Appcolors.darkColor,
                    borderRadius: BorderRadius.circular(5)),
                child: Text(
                  "SUBMIT",
                  style: TextStyle(color: Appcolors.lightColor),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
