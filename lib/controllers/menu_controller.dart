import 'package:food_sales_recording_application/models/menu_model.dart';
import 'package:food_sales_recording_application/models/response_model.dart';
import 'package:food_sales_recording_application/repository/menu_repo.dart';
import 'package:get/get.dart';
import 'package:food_sales_recording_application/controllers/menu_controller.dart'
    as foodMenuController;

class MenuController extends GetxController {
  final MenuRepo menuRepo;
  MenuController({required this.menuRepo});

  List<dynamic> _menuList = [];
  List<dynamic> get menuList => _menuList;

  Future<void> getMenuList() async {
    Response response = await menuRepo.getMenuList();
    if (response.statusCode == 200) {
      _menuList = [];
      _menuList.addAll(response.body);

      print(response.body.toString());

      // List<MenuModel> _menus = <MenuModel>[];
      // (response.body as List).forEach(
      //   (element) => _menus.add(MenuModel.fromJson(element)),
      // );
      // _menuList.addAll(_menus);
      update();
      print("get menu");
      print(_menuList);
    } else {
      print("error");
    }
  }

  Future<ResponseModel> addMenu(MenuModel newMenu) async {
    print("send : ${newMenu.name}");
    Response response = await menuRepo.addMenu(newMenu);
    late ResponseModel responseModel;

    if (response.statusCode == 201) {
      responseModel = ResponseModel(
          true, "${response.body["id"]} = ${response.body["name"]}");
    } else {
      responseModel =
          ResponseModel(false, "${response.statusCode} - ${response.body}");
    }

    await Get.find<foodMenuController.MenuController>().getMenuList();

    update();

    return responseModel;
  }
}
