import 'package:moneymanager_simple/data/models/TransactionModel.dart';

abstract class RemoteDataSource {
  Future<TransactionModel> getConcreteTransaction(String id);
  Future<List<TransactionModel>> getAllTransactions();
  Future<int> insertTransaction(TransactionModel transactionModel);
  Future<int> deleteTransaction(TransactionModel transactionModel);
}

// class NumberTriviaRemoteDataSourceImpl implements NumberTriviaRemoteDataSource {
//   final http.Client client;
//
//   NumberTriviaRemoteDataSourceImpl({@required this.client});
//
//   @override
//   Future<UserTransaction> getConcreteTransaction(int number) =>
//       _getTransactionFromUrl('http://numbersapi.com/$number');
//
//   @override
//   Future<List<UserTransaction>> getAllTransactions() =>
//       _getAllTransactionFromUrl('http://numbersapi.com/random');
//
//   Future<UserTransaction> _getTransactionFromUrl(String url) async {
//     final response = await client.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       return UserTransaction.fromJson(json.decode(response.body));
//     } else {
//       throw ServerException();
//     }
//   }
//
//   Future<List<UserTransaction>> _getAllTransactionFromUrl(String url) async {
//     final response = await client.get(
//       url,
//       headers: {
//         'Content-Type': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       return UserTransaction.fromJson(json.decode(response.body));
//     } else {
//       throw ServerException();
//     }
//   }
// }