import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLHelper {
  // static final SQLHelper instance = SQLHelper._();
  static Database? _database;
  // Database get database => _database!;

  // List<dynamic> _customerList = [];
  // List<dynamic> get customerList => _customerList;

  SQLHelper();

  static Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }
    _database = await initDatabase();
    return _database!;
  }

  static Future<Database> initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'application.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  static Future<void> _createDatabase(Database db, int version) async {
    print("create table sales");
    await db.execute('''
      CREATE TABLE sales(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        customer_id INTEGER,
        customer_name TEXT,
        delivery_address TEXT,
        delivery_fee INTEGER,
        total INTEGER,
        is_paid_off BOOLEAN,
        delivery_date DATETIME,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    print("done create table sales");

    print("done create table sale_items");
    await db.execute('''
      CREATE TABLE sale_items(
        id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
        sales_id INTEGER, 
        pcs INTEGER,
        name TEXT,
        price INTEGER,
        total INTEGER,
        createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP
      )
    ''');
    print("done create table sale_items");
  }
}
