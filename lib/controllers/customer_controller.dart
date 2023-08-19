import 'package:food_sales_recording_application/models/customer_model.dart';
import 'package:food_sales_recording_application/models/response_model.dart';
import 'package:food_sales_recording_application/repository/customer_repo.dart';
import 'package:get/get.dart';

class CustomerController extends GetxController {
  final CustomerRepo customerRepo;
  CustomerController({required this.customerRepo});

  List<dynamic> _customerList = [];
  List<dynamic> get customerList => _customerList;

  Future<void> getCustomerList() async {
    Response response = await customerRepo.getCustomerList();
    if (response.statusCode == 200) {
      _customerList = [];
      _customerList.addAll(response.body);

      print(response.body.toString());

      update();
      print("get customer");
      print(_customerList);
    } else {
      print("error");
    }
  }

  Future<ResponseModel> addCustomer(CustomerModel newCustomer) async {
    print("send : ${newCustomer.name}");
    Response response = await customerRepo.addCustomer(newCustomer);
    late ResponseModel responseModel;

    if (response.statusCode == 201) {
      responseModel = ResponseModel(
          true, "${response.body["id"]} = ${response.body["name"]}");
    } else {
      responseModel =
          ResponseModel(false, "${response.statusCode} - ${response.body}");
    }

    await Get.find<CustomerController>().getCustomerList();

    update();

    return responseModel;
  }
}
