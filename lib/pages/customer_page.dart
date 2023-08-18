import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/widgets/detail_text.dart';

import '../utils/app_colors.dart';
import '../widgets/children_detail_item_history.dart';
import '../widgets/currency_input_formatter.dart';
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
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

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
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(children: [
              TextField(
                controller: _nameController,
                decoration: new InputDecoration(
                  hintText: 'John Doe',
                  labelText: "Customer Name",
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
              ),
              SizedBox(
                height: 10,
              ),
              TextField(
                  controller: _addressController,
                  decoration: new InputDecoration(
                    hintText: 'Street No 10',
                    labelText: "Customer Address",
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
                  inputFormatters: [CurrencyInputFormatter()],
                  keyboardType: TextInputType.numberWithOptions(
                      signed: false, decimal: false)),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () => (),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Appcolors.darkColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: TitleText(text: "Add Customer"),
                ),
              ),
            ]),
          ),
          Divider(),
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
