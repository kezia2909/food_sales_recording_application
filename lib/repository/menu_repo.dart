import 'package:food_sales_recording_application/api_client.dart';
import 'package:get/get.dart';

class MenuRepo extends GetxService {
  final ApiClient apiClient;
  MenuRepo({required this.apiClient});

  Future<Response> getMenuList() async {
    return await apiClient.getData("/api/v1/menus");
  }
}
