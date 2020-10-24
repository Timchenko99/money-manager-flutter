import 'package:flutter/foundation.dart';

import '../model/UserTransaction.dart';
import '../data/DBHelper.dart';

class DBProvider with ChangeNotifier{

  final DBHelper _db = DBHelper();

  Future<List<UserTransaction>> get weekTransactions{
    return _db.getWeekTransactions();
  }

  Future<List<UserTransaction>> get transactions{
    return _db.getAllTransactions();
  }


}
