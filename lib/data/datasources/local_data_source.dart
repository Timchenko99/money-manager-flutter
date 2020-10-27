
import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../../data/models/TransactionModel.dart';

abstract class LocalDataSource{
  Future<TransactionModel> getConcreteTransaction(String id);
  Future<List<TransactionModel>> getAllTransactions();
  Future<int> insertTransaction(TransactionModel transactionModel);
  Future<int> deleteTransaction(String id);

}

class TransactionLocalDataSourceImpl implements LocalDataSource{
  static const TABLE_NAME = "transactions";

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
              "title Text,"
              "amount REAL,"
              "date TEXT,"
              "iconCode INT,"
              "iconFamily TEXT,"
              "iconPackage TEXT,"
              ")");
        });
  }


    @override
  Future<TransactionModel> getConcreteTransaction(String id) async{
    return (await database).query(TABLE_NAME, where: '"id" = ?', whereArgs: [id]).then((value) => TransactionModel.fromJson(value[0]));
  }

  @override
  Future<List<TransactionModel>> getAllTransactions() async{
    return (await database).query(TABLE_NAME).then((value) => value.map((e) => TransactionModel.fromJson(e)).toList());
  }

  @override
  Future<int> deleteTransaction(String id)async {
    return (await database).delete(TABLE_NAME, where: '"id" = ?', whereArgs: [id]);
  }

  @override
  Future<int> insertTransaction(TransactionModel transactionModel) async{
    return (await database).insert(TABLE_NAME, transactionModel.toJson());
  }
}