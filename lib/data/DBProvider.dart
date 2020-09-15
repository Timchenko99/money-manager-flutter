import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import './model/transaction.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider dbProvider = DBProvider._();


  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;

    // if _database is null we instantiate it
    _database = await initDB();
    return _database;
  }

  Future<Database> initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "TestDB.db");
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE transactions ("
          "id INTEGER PRIMARY KEY,"
          "amount REAL,"
          "date DATETIME"
          ")");
    });
  }

  Future<int> newTransaction(UserTransaction newTransaction) async{
    final db = await database;

    return await db.rawInsert('''
      INSERT INTO transactions(
        amount,
        date
      ) VALUES(?,?)
    ''', [newTransaction.amount, newTransaction.date]);
  }

  Future<UserTransaction> getTransaction(int id) async{
    final db = await database;
    var res = await db.query("transactions", where: "id = ?", whereArgs: [id]);
    return res.isNotEmpty ? UserTransaction.fromJson(res.first): Null;
  }

  Future<List<UserTransaction>> getAllTransactions() async {
    final db = await database;
    var res = await db.query("transactions");
    List<UserTransaction> list =
    res.isNotEmpty ? res.map((c) => UserTransaction.fromJson(c)).toList() : [];
    return list;
  }

  Future<int> updateTransaction(UserTransaction newTransaction) async {
    final db = await database;
    var res = await db.update("transactions", newTransaction.toJson(),
        where: "id = ?", whereArgs: [newTransaction.id]);
    return res;
  }

  void delete(int id) async {
    final db = await database;
    db.delete("Client", where: "id = ?", whereArgs: [id]);
  }

  void deleteAll() async {
    final db = await database;
    db.rawDelete("Delete * from Client");
  }
}
