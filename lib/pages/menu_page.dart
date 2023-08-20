import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/widgets/custom_number_text_field.dart';
import 'package:food_sales_recording_application/widgets/custom_snackbar.dart';
import 'package:food_sales_recording_application/widgets/custom_text_field.dart';
import 'package:food_sales_recording_application/widgets/detail_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../models/menu_model.dart';
import '../utils/app_colors.dart';
import '../widgets/currency_input_formatter.dart';
import '../widgets/title_text.dart';
import 'package:food_sales_recording_application/controllers/menu_controller.dart'
    as foodMenuController;

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _editNameController = TextEditingController();
  final TextEditingController _editPriceController = TextEditingController();
  final formatCurrency = NumberFormat.decimalPattern();
  // final CurrencyTextInputFormatter _formatter =
  //     CurrencyTextInputFormatter(enableNegative: false, decimalDigits: 0);

  void _addMenu() {
    String name = _nameController.text.trim();
    print(_nameController.value);
    print(_priceController.text.numericOnly());
    String price = _priceController.text;
    print("price : ${price.toString}");

    if (name.isEmpty) {
      print("name is empty");
      customSnackbar("Please enter food name");
    } else if (price.isEmpty) {
      print("price is empty");
      customSnackbar("Please enter food price");
    } else {
      int price = int.parse(_priceController.text.numericOnly());
      MenuModel newMenu = MenuModel(name: name, price: price);

      print("NEW MENU : ${newMenu.toString()}");

      var addMenuController = Get.find<foodMenuController.MenuController>();
      addMenuController.addMenu(newMenu).then(
        (value) {
          if (value.isSuccess) {
            print("add menu success, id : ${value.message}");
            _nameController.text = "";
            _priceController.text = "";
            FocusScopeNode currentFocus = FocusScope.of(context);
            currentFocus.unfocus();
            customSnackbar("Successfully added food",
                isError: false, title: "Success");
          } else {
            print("failed to add menu : ${value.message}");
          }
        },
      );
    }
  }

  void _showEditDialog() {
    Get.defaultDialog(
      title: "Edit Menu",
      cancel: IconButton(
        icon: Icon(Icons.cancel),
        onPressed: () {
          Get.back();
        },
      ),
      backgroundColor: Appcolors.lightColor,
      content: Column(
        children: [
          TextField(
            controller: _editNameController,
            decoration: InputDecoration(labelText: 'Enter name'),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
            controller: _editPriceController,
            decoration: InputDecoration(labelText: 'Enter price'),
            inputFormatters: [CurrencyInputFormatter()],
            keyboardType:
                TextInputType.numberWithOptions(signed: false, decimal: false),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Container(
              width: double.maxFinite,
              padding: EdgeInsets.symmetric(vertical: 8),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Appcolors.darkColor,
                  borderRadius: BorderRadius.circular(8)),
              child: TitleText(text: "Update"),
            ),
          ),
        ],
      ),
    );
  }

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
              text: "Menu",
              isBold: true,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(children: [
              CustomTextField(
                textEditingController: _nameController,
                labelText: 'Food Name',
                hintText: 'Yummy noodle',
              ),
              SizedBox(
                height: 10,
              ),
              CustomNumberTextField(
                textEditingController: _priceController,
                labelText: 'Food Price',
                hintText: '0',
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: _addMenu,
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.symmetric(vertical: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: Appcolors.darkColor,
                      borderRadius: BorderRadius.circular(8)),
                  child: TitleText(text: "Add Menu"),
                ),
              ),
            ]),
          ),
          Divider(),
          Expanded(
            child: Container(
              color: Colors.white,
              child: GetBuilder<foodMenuController.MenuController>(
                  builder: (menus) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: menus.menuList.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          padding:
                              EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    DetailText(
                                      text: MenuModel.fromJson(
                                              menus.menuList[index])
                                          .name
                                          .toString(),
                                      // text: menus.menuList[index].toString(),
                                      size: 16,
                                    ),
                                    DetailText(
                                      text: formatCurrency
                                          .format(MenuModel.fromJson(
                                                  menus.menuList[index])
                                              .price)
                                          .toString(),
                                      size: 16,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width * 0.1,
                                height: MediaQuery.of(context).size.width * 0.1,
                                child: FittedBox(
                                  child: Icon(
                                    Icons.delete,
                                    color: Appcolors.redColor,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _editNameController.text =
                                      MenuModel.fromJson(menus.menuList[index])
                                          .name
                                          .toString();
                                  _editPriceController.text = formatCurrency
                                      .format(MenuModel.fromJson(
                                              menus.menuList[index])
                                          .price)
                                      .toString();

                                  _showEditDialog();
                                },
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.edit,
                                      color: Appcolors.mediumColor,
                                    ),
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
                );
              }),
            ),
          )
        ],
      )),
    );
  }
}
