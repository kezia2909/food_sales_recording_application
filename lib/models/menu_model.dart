class MenuModel {
  String? id;
  String? name;
  int? price;

  MenuModel({this.id, this.name, this.price});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }
  // MenuModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   price = json['price'];
  // }
}
