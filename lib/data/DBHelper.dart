import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import '../model/UserTransaction.dart';

class DBHelper{
  static final DBHelper _instance = DBHelper._ctor();

  DBHelper._ctor();


  factory DBHelper(){
    return _instance;
  }

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
    return await openDatabase(path, version: 2, onOpen: (db) {},
        onDowngrade: onDatabaseDowngradeDelete,
        // onUpgrade: (db, oldVersion, newVersion) async{
        //   if(oldVersion == 1){
        //     db.batch().execute('''
        //       DROP TABLE IF EXISTS transactions
        //     ''');
        //     db.batch().execute('''
        //       CREATE TABLE transactions(
        //         id INTEGER PRIMARY KEY,
        //         amount REAL,
        //         type INTEGER,
        //         day INTEGER,
        //         month INTEGER,
        //         year INTEGER,
        //         weekday INTEGER
        //
        //       )
        //     ''');
        //   }
        //   await db.batch().commit();
        // },
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE transactions ("
          "id TEXT PRIMARY KEY,"
          "amount REAL,"
          "type INTEGER,"
          "day INTEGER,"
          "month INTEGER,"
          "year INTEGER,"
          "weekday INTEGER"
          ")");
    });

  }

  Future<void> insert(String table, Map<String, Object> data) async {
    await _database.insert(table, data, conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<Map<String, dynamic>>> getData(String table) async {
    return await _database.query(table);
  }

  Future<List<UserTransaction>> getWeekTransactions() async{
    final db = await database;

    var res = await db.rawQuery('''
      SELECT id, SUM(amount)amount, type, day, month, year, weekday
      FROM transactions
      GROUP BY day, month, year
      ORDER BY day DESC, month DESC, year DESC
      LIMIT 7;
    
    ''');

    List<UserTransaction> list =
    res.isNotEmpty ? res.map((c) => UserTransaction.fromJson(c)).toList() : [];

    return list;
  }

  Future<List<UserTransaction>> getSumByDay() async{
    final db = await database;

    var res = await db.rawQuery('''
      SELECT id, SUM(amount)amount, type, day, month, year, weekday
      FROM transactions
      GROUP BY day, month, year
      ORDER BY day DESC, month DESC, year DESC;
    
    ''');

    List<UserTransaction> list =
    res.isNotEmpty ? res.map((c) => UserTransaction.fromJson(c)).toList() : [];

    return list;
  }

  Future<int> newTransaction(UserTransaction newTransaction) async{
    final db = await database;

    int result = await db.rawInsert('''
      INSERT INTO transactions(
        amount,
        type,
        day,
        month,
        year,
        weekday
      ) VALUES(?,?,?,?,?,?)
    ''', [newTransaction.amount, newTransaction.type, newTransaction.day, newTransaction.month, newTransaction.year, newTransaction.weekday]);


    return result;
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
    int res = await db.update("transactions", newTransaction.toJson(),
        where: "id = ?", whereArgs: [newTransaction.id]);
    return res;
  }

  void delete(int id) async {
    final db = await database;
    db.delete("transactions", where: "id = ?", whereArgs: [id]);
  }

  void deleteAll() async {
    final db = await database;
    db.rawDelete("DELETE FROM transactions");
  }
}
