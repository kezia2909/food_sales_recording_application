import 'package:food_sales_recording_application/sql_helper.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class SaleSQLController {
  // static final SaleSQLController instance = SaleSQLController._();

  static Future<int> createSale(
      int customer_id,
      String customer_name,
      String delivery_address,
      int delivery_fee,
      int total,
      bool is_paid_off,
      DateTime delivery_date) async {
    print("create sale controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    final data = {
      'customer_id': customer_id,
      'customer_name': customer_name,
      'delivery_address': delivery_address,
      'delivery_fee': delivery_fee,
      'total': total,
      'is_paid_off': is_paid_off,
      'delivery_date': DateFormat('yyyy-MM-dd HH:mm:ss').format(delivery_date)
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

  static Future<List<Map<String, dynamic>>> getSales(
      {bool unpaidOnly = false}) async {
    print("get sales controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    print("OTW GET");
    print("${db.query('sales', orderBy: 'id')}");

    if (unpaidOnly) {
      return db.query('sales',
          orderBy: 'customer_name ASC', where: 'is_paid_off = 0');
    }
    return db.query('sales', orderBy: 'id');
  }

  static Future<List<Map<String, dynamic>>> getSalesByDate(
      String month, String year) async {
    print("get sales controller");
    final db = await SQLHelper.database;
    print("db : ${db.toString()}");

    print("OTW GET");
    print(
        "${db.query('sales', orderBy: 'id', where: "strftime('%Y-%m', createdAt) = '$year-$month'")}");
    return db.query('sales',
        orderBy: 'createdAt DESC',
        where: "strftime('%Y-%m', createdAt) = '$year-$month'");
  }

  static Future<Object> getTotalSalesThisMonth() async {
    final db = await SQLHelper.database;
    final now = DateTime.now();
    final currentYear = now.year;
    final currentMonth = now.month;

    final result = await db.rawQuery('''
    SELECT SUM(total) AS totalSum
    FROM sales
    WHERE strftime('%Y-%m', createdAt) = ?  
  ''', [
      '${currentYear.toString().padLeft(4, '0')}-${currentMonth.toString().padLeft(2, '0')}'
    ]);

    print("result : ${result.first}");
    return result.first['totalSum'] ?? 0;
  }

  static Future<void> updateIsPaidOff(int id) async {
    final db = await SQLHelper.database;

    await db.update(
      'sales',
      {'is_paid_off': 1},
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
