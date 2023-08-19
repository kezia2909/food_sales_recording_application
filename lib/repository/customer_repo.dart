import 'package:food_sales_recording_application/api_client.dart';
import 'package:food_sales_recording_application/models/customer_model.dart';
import 'package:get/get.dart';

class CustomerRepo extends GetxService {
  final ApiClient apiClient;
  CustomerRepo({required this.apiClient});

  Future<Response> getCustomerList() async {
    print("GET DATA CUSTOMER REPO");
    return await apiClient.getData("/api/v1/customers");
  }

  Future<Response> addCustomer(CustomerModel newCustomer) async {
    // print("Customer repo - send data : ${newCustomer.name}");
    // print("Customer repo - send data to json : ${newCustomer.toJson().toString()}");
    return await apiClient.postData("/api/v1/customers", newCustomer.toJson());
  }
}
