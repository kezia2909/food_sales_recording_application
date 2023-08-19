class CustomerModel {
  String? id;
  String name;
  String address;

  CustomerModel({this.id, required this.name, required this.address});

  factory CustomerModel.fromJson(Map<String, dynamic> json) {
    return CustomerModel(
      id: json['id'],
      name: json['name'],
      address: json['address'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "name": this.name,
      "address": this.address,
    };
  }
}
