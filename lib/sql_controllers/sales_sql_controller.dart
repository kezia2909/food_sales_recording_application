import 'package:food_sales_recording_application/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class SaleSQLController {
  // static final SaleSQLController instance = SaleSQLController._();

  static Future<int> createSale(int customer_id, String customer_name,
      String delivery_address, int delivery_fee, int total) async {
    print("create sale controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    final data = {
      'customer_id': customer_id,
      'customer_name': customer_name,
      'delivery_address': delivery_address,
      'delivery_fee': delivery_fee,
      'total': total
    };

    // final id = await SQLHelper.database.then(
    //   (db) {
    //     print("available table");
    //     db.insert('sales', data);
    //   },
    // ).catchError(err){
    //   print("error : $err");
    // }

    // print("id : $id, ");

    final id = await db.insert(
      'sales',
      data,
    );

    print("id : $id, ");

    return id;
  }

  static Future<List<Map<String, dynamic>>> getSales() async {
    print("get sales controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    print("OTW GET");
    print("${db.query('sales', orderBy: 'id')}");
    return db.query('sales', orderBy: 'id');

    // await SQLHelper.database.then(
    //   (db) {
    //     print("available table");
    //     print(db.query('sales', orderBy: 'id').toString());

    //     return db.query('sales', orderBy: 'id');
    //   },
    // );

    // return [];
  }

  static Future<List<Map<String, dynamic>>> getSalesByDate(String month) async {
    print("get sales controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    print("OTW GET");
    print(
        "${db.query('sales', orderBy: 'id', where: "strftime('%m', createdAt) = '$month'")}");
    return db.query('sales',
        orderBy: 'createdAt DESC',
        where: "strftime('%m', createdAt) = '$month'");
  }
}
