import 'package:flutter/material.dart';
import 'package:food_sales_recording_application/widgets/custom_snackbar.dart';
import 'package:food_sales_recording_application/widgets/custom_text_field.dart';
import 'package:food_sales_recording_application/widgets/detail_text.dart';
import 'package:get/get.dart';

import '../controllers/customer_controller.dart';
import '../models/customer_model.dart';
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
  final TextEditingController _editNameController = TextEditingController();
  final TextEditingController _editAddressController = TextEditingController();

  void _addCustomer() {
    String name = _nameController.text.trim();
    String address = _addressController.text.trim();

    if (name.isEmpty) {
      print("name is empty");
      customSnackbar("Please enter customer name");
    } else if (address.isEmpty) {
      print("address is empty");
      customSnackbar("Please enter customer address");
    } else {
      CustomerModel newCustomer = CustomerModel(name: name, address: address);

      var addCustomerController = Get.find<CustomerController>();
      addCustomerController.addCustomer(newCustomer).then((value) {
        if (value.isSuccess) {
          _nameController.text = "";
          _addressController.text = "";
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          customSnackbar("Successfully added customer",
              isError: false, title: "Success");
        } else {
          print("failed to add customer : ${value.message}");
        }
      });
    }
  }

  void _updateCustomer(String id) {
    String name = _editNameController.text.trim();
    String address = _editAddressController.text;

    if (name.isEmpty) {
      print("name is emptys");
      // Get.back();
      customSnackbar("Please enter customer name");
      _showEditDialog(id);
    } else if (address.isEmpty) {
      print("address is empty");
      customSnackbar("Please enter customer address");
      _showEditDialog(id);
    } else {
      CustomerModel updateCustomer =
          CustomerModel(name: name, address: address);

      var addCustomerController = Get.find<CustomerController>();
      addCustomerController.updateCustomer(id, updateCustomer).then((value) {
        if (value.isSuccess) {
          _editNameController.text = "";
          _editAddressController.text = "";
          FocusScopeNode currentFocus = FocusScope.of(context);
          currentFocus.unfocus();
          customSnackbar("Successfully update customer",
              isError: false, title: "Success");
        } else {
          customSnackbar("Failed to update customer");
          print("failed to update customer : ${value.message}");
        }
      });
    }
  }

  void _deleteCustomer(String id) {
    var deleteCustomerController = Get.find<CustomerController>();
    deleteCustomerController.deleteCustomer(id).then(
      (value) {
        if (value) {
          // FocusScopeNode currentFocus = FocusScope.of(context);
          // currentFocus.unfocus();
          customSnackbar("Successfully deleted customer",
              isError: false, title: "Success");
        } else {
          customSnackbar("Failed to delete customer");
        }
      },
    );
  }

  void _showEditDialog(String id) {
    Get.defaultDialog(
      title: "Edit Customer",
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
            controller: _editAddressController,
            decoration: InputDecoration(labelText: 'Enter address'),
          ),
          SizedBox(
            height: 15,
          ),
          GestureDetector(
            onTap: () {
              Get.back();
              _updateCustomer(id);
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

  void _showDeleteDialog(String id) {
    Get.defaultDialog(
      title: 'Delete Confirmation',
      middleText: 'Are you sure delete customer?',
      backgroundColor: Appcolors.lightColor,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.greenColor,
              foregroundColor: Appcolors.whiteColor),
          onPressed: () {
            Get.back(); // Return true when "Yes" is pressed
            _deleteCustomer(id);
            setState(() {});
          },
          child: Text('Yes'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
              backgroundColor: Appcolors.redColor,
              foregroundColor: Appcolors.whiteColor),
          onPressed: () {
            Get.back(); // Return false when "No" is pressed
          },
          child: Text('No'),
        ),
      ],
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
              text: "Customer",
              isBold: true,
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 20, vertical: 8),
            child: Column(children: [
              CustomTextField(
                textEditingController: _nameController,
                labelText: 'Customer Name',
                hintText: 'John Doe',
              ),
              SizedBox(
                height: 10,
              ),
              CustomTextField(
                textEditingController: _addressController,
                labelText: 'Customer Address',
                hintText: 'Street No 10',
              ),
              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  _addCustomer();
                },
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
              child: GetBuilder<CustomerController>(builder: (customers) {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: customers.customerList.length,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DetailText(
                                        text: CustomerModel.fromJson(
                                                customers.customerList[index])
                                            .name,
                                        isBold: true,
                                        size: 16,
                                      ),
                                      DetailText(
                                        text: CustomerModel.fromJson(
                                                customers.customerList[index])
                                            .address,
                                        color: Appcolors.mediumColor,
                                      )
                                    ]),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                // onTap: () => _updateCustomer(
                                //     CustomerModel.fromJson(
                                //             customers.customerList[index])
                                //         .id!),
                                onTap: () => _showDeleteDialog(
                                    CustomerModel.fromJson(
                                            customers.customerList[index])
                                        .id!),
                                child: Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.1,
                                  height:
                                      MediaQuery.of(context).size.width * 0.1,
                                  child: FittedBox(
                                    child: Icon(
                                      Icons.delete,
                                      color: Appcolors.redColor,
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              GestureDetector(
                                onTap: () {
                                  _editNameController.text =
                                      CustomerModel.fromJson(
                                              customers.customerList[index])
                                          .name;

                                  _editAddressController.text =
                                      CustomerModel.fromJson(
                                              customers.customerList[index])
                                          .address;

                                  _showEditDialog(CustomerModel.fromJson(
                                          customers.customerList[index])
                                      .id!);
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
