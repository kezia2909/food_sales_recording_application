class MenuModel {
  String? id;
  String name;
  int price;

  MenuModel({this.id, required this.name, required this.price});

  factory MenuModel.fromJson(Map<String, dynamic> json) {
    return MenuModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
    );
  }

  Map<String, dynamic> toJson() {
    // final Map<String, dynamic> data = new Map<String, dynamic>();

    // data['name'] = this.name;
    // data['price'] = this.price;

    // return data;

    return {"name": this.name, "price": this.price};
  }
  // MenuModel.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   name = json['name'];
  //   price = json['price'];
  // }
}
