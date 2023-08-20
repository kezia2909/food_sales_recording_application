// import 'package:sqflite/sqflite.dart' as sql;

// class SaleItemsHelper {
//   static Future<void> createTable(sql.Database database) async {
//     print("CREATE TABLE ITEMS");
//     await database.execute("""CREATE TABLE sale_items(
//       id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
//       sales_id INTEGER, 
//       pcs INTEGER,
//       menu TEXT,
//       price INTEGER,
//       total INTEGER,
//       createdAt TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
//       FOREIGN KEY(sales_id) REFERENCES sales
//       )
//     """);
//     print("CREATE TABLE ITEMS DONE");
//   }

//   static Future<sql.Database> db() async {
//     print("OPEN DB ITEM");
//     return sql.openDatabase(
//       'application.db',
//       version: 2,
//       onCreate: (sql.Database database, int version) async {
//         print("start create table items");
//         await createTable(database);
//         print("end create table items");
//       },
//     );
//   }

//   static Future<int> createSaleItem(
//       int sales_id, int pcs, String menu, int price, int total) async {
//     final db = await SaleItemsHelper.db();

//     final data = {
//       'sales_id': sales_id,
//       'pcs': pcs,
//       'menu': menu,
//       'price': price,
//       'total': total
//     };

//     final id = await db.insert('sale_items', data,
//         conflictAlgorithm: sql.ConflictAlgorithm.replace);

//     print("id : $id, ");

//     return id;
//   }

//   static Future<List<Map<String, dynamic>>> getSaleItems() async {
//     print("START GET ITEMS");
//     final db = await SaleItemsHelper.db();
//     print(db.toString());
//     print("OTW GET");
//     print("${db.query('sale_items', orderBy: 'id')}");
//     return db.query('sale_items', orderBy: 'id');
//   }
// }
