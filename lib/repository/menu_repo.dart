import 'package:food_sales_recording_application/api_client.dart';
import 'package:food_sales_recording_application/models/menu_model.dart';
import 'package:get/get.dart';

class MenuRepo extends GetxService {
  final ApiClient apiClient;
  MenuRepo({required this.apiClient});

  Future<Response> getMenuList() async {
    return await apiClient.getData("/api/v1/menus");
  }

  Future<Response> addMenu(MenuModel newMenu) async {
    print("menu repo - send data : ${newMenu.name}");
    print("menu repo - send data to json : ${newMenu.toJson().toString()}");
    return await apiClient.postData("/api/v1/menus", newMenu.toJson());
  }

  Future<Response> updateMenu(String id, MenuModel updateMenu) async {
    print("menu repo - send data : ${updateMenu.name}");
    print("menu repo - send data to json : ${updateMenu.toJson().toString()}");
    return await apiClient.updateData("/api/v1/menus/$id", updateMenu.toJson());
  }

  Future<Response> deleteMenu(String id) async {
    return await apiClient.deleteData("/api/v1/menus/$id");
  }
}
