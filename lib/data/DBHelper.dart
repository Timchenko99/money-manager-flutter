// import 'dart:async';
// import 'dart:io';
//
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
//
// import './models/TransactionModel.dart';
//
// class DBHelper{
//   static final DBHelper _instance = DBHelper._ctor();
//
//   DBHelper._ctor();
//
//
//   factory DBHelper(){
//     return _instance;
//   }
//
//   static Database _database;
//   Future<Database> get database async {
//     if (_database != null) return _database;
//
//     // if _database is null we instantiate it
//     _database = await initDB();
//     return _database;
//   }
//
//   Future<Database> initDB() async {
//     Directory documentsDirectory = await getApplicationDocumentsDirectory();
//     String path = join(documentsDirectory.path, "TestDB.db");
//     return await openDatabase(path, version: 2, onOpen: (db) {},
//         onDowngrade: onDatabaseDowngradeDelete,
//         // onUpgrade: (db, oldVersion, newVersion) async{
//         //   if(oldVersion == 1){
//         //     db.batch().execute('''
//         //       DROP TABLE IF EXISTS transactions
//         //     ''');
//         //     db.batch().execute('''
//         //       CREATE TABLE transactions(
//         //         id INTEGER PRIMARY KEY,
//         //         amount REAL,
//         //         type INTEGER,
//         //         day INTEGER,
//         //         month INTEGER,
//         //         year INTEGER,
//         //         weekday INTEGER
//         //
//         //       )
//         //     ''');
//         //   }
//         //   await db.batch().commit();
//         // },
//         onCreate: (Database db, int version) async {
//       await db.execute("CREATE TABLE transactions ("
//           "id TEXT PRIMARY KEY,"
//           "amount REAL,"
//           "type INTEGER,"
//           "day INTEGER,"
//           "month INTEGER,"
//           "year INTEGER,"
//           "weekday INTEGER"
//           ")");
//     });
//
//   }
//
//   Future<void> insert(String table, Map<String, Object> data) async {
//     await _database.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<TransactionModel> getOne() async{
//     await _database.query(table)
//   }
//
//   Future<TransactionModel> getAll() async{
//     final db = await database;
//     var res = await db.query("transactions", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? TransactionModel.fromJson(res.first): Null;
//   }
//
//   Future<TransactionModel> getTransaction(String id) async{
//     final db = await database;
//     var res = await db.query("transactions", where: "id = ?", whereArgs: [id]);
//     return res.isNotEmpty ? TransactionModel.fromJson(res.first): Null;
//   }
//
//   Future<List<TransactionModel>> getAllTransactions() async {
//     final db = await database;
//     var res = await db.query("transactions");
//     List<TransactionModel> list =
//     res.isNotEmpty ? res.map((c) => TransactionModel.fromJson(c)).toList() : [];
//     return list;
//   }
//
//   Future<int> updateTransaction(TransactionModel newTransaction) async {
//     final db = await database;
//     int res = await db.update("transactions", newTransaction.toJson(),
//         where: "id = ?", whereArgs: [newTransaction.id]);
//     return res;
//   }
//
//   Future<int> delete(int id) async {
//     final db = await database;
//     return db.delete("transactions", where: "id = ?", whereArgs: [id]);
//   }
//
//   Future<int> deleteAll() async {
//     final db = await database;
//     return db.rawDelete("DELETE FROM transactions");
//   }
// }
