import 'package:food_sales_recording_application/sql_helper.dart';
import 'package:sqflite/sqflite.dart';

class SaleItemSQLController {
  static Future<int> createSaleItem(
      int sales_id, int pcs, String name, int price, int total) async {
    print("create sale item controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    final data = {
      'sales_id': sales_id,
      'pcs': pcs,
      'name': name,
      'price': price,
      'total': total
    };

    // final id = await SQLHelper.database.then(
    //   (db) {
    //     db.insert('sale_items', data);
    //   },
    // );

    final id = await db.insert(
      'sale_items',
      data,
    );

    print("id : $id, ");

    return id;
  }

  static Future<List<Map<String, dynamic>>> getSaleItems(int? sales_id) async {
    print("get sale items controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    print("OTW GET");
    print("${db.query('sale_items', orderBy: 'id')}");

    if (sales_id != null) {
      return db.query('sale_items',
          orderBy: 'id', where: 'sales_id=?', whereArgs: [sales_id]);
    }
    return db.query('sale_items', orderBy: 'id');

    // await SQLHelper.database.then(
    //   (db) {
    //     print("available table");
    //     print(db.query('sale_items', orderBy: 'id').toString());

    //     return db.query('sale_items', orderBy: 'id');
    //   },
    // );

    // return [];
  }
}
