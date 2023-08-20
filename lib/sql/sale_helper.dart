import 'package:sqflite/sqflite.dart' as sql;

class SaleHelper {
  static Future<void> createTable(sql.Database database) async {
    await database.execute("""CREATE TABLE sales(
      id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
      customer_id INTEGER,
      customer_name TEXT,
      delivery_address TEXT,
      delivery_fee INTEGER,
      total INTEGER,
      createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    """);
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'application.db',
      version: 1,
      onCreate: (sql.Database database, int version) async {
        print("create table");
        await createTable(database);
      },
    );
  }

  static Future<int> createSale(int customer_id, String customer_name,
      String delivery_address, int delivery_fee, int total) async {
    final db = await SaleHelper.db();

    final data = {
      'customer_id': customer_id,
      'customer_name': customer_name,
      'delivery_address': delivery_address,
      'delivery_fee': delivery_fee,
      'total': total
    };

    final id = await db.insert('sales', data,
        conflictAlgorithm: sql.ConflictAlgorithm.replace);

    print("id : $id, ");

    return id;
  }

  static Future<List<Map<String, dynamic>>> getSales() async {
    print("START GET");
    final db = await SaleHelper.db();
    print(db.toString());
    print("OTW GET");
    print("${db.query('sales', orderBy: 'id')}");
    return db.query('sales', orderBy: 'id');
  }
}
