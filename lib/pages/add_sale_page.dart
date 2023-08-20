import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/models/transaction_item_model.dart';
import 'package:food_sales_recording_application/utils/app_colors.dart';
import 'package:food_sales_recording_application/widgets/custom_number_text_field.dart';
import 'package:food_sales_recording_application/widgets/custom_text_field.dart';
import 'package:intl/intl.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class AddSalePage extends StatefulWidget {
  const AddSalePage({super.key});

  @override
  State<AddSalePage> createState() => _AddSalePageState();
}

class _AddSalePageState extends State<AddSalePage> {
  final formatCurrency = NumberFormat.decimalPattern();

  final TextEditingController _nameController = TextEditingController();
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
                child: DropdownButton<String>(
                  value: selectedCustomer,
                  // isDense: true,
                  hint: Text("Customer Name"),
                  isExpanded: true,
                  onChanged: (newValue) {
                    _addressController.text = "Surabaya 100";

                    setState(() {
                      selectedCustomer = newValue;
                    });
                  },
                  items: listCustomer.map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                ),
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
                      child: DropdownButton<String>(
                        value: selectedValue,
                        // isDense: true,
                        isExpanded: true,
                        onChanged: (newValue) {
                          _priceController.text =
                              formatCurrency.format(22000).toString();
                          setState(() {
                            selectedValue = newValue;
                          });
                        },
                        items: items.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                      ),
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
                if (selectedValue != "" &&
                    _priceController.value != 0 &&
                    _pcsController.value != 0) {
                  setState(() {
                    _items.add(TransactionItemModel(
                      name: selectedValue!,
                      price: 10000,
                      pcs: int.parse(_pcsController.text),
                    ));
                    totalSale += (10000 * int.parse(_pcsController.text));
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
                Expanded(flex: 3, child: Text("menu")),
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
                child: Text(
                  "TOTAL : ${formatCurrency.format(totalSale)}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                )),
          ],
        ),
      ),
    );
  }
}
