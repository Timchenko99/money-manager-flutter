// To parse this JSON data, do
//
//     final userTransaction = userTransactionFromJson(jsonString);

import 'dart:convert';

UserTransaction userTransactionFromJson(String str) => UserTransaction.fromJson(json.decode(str));

String userTransactionToJson(UserTransaction data) => json.encode(data.toJson());

class UserTransaction {
  UserTransaction({
    this.id,
    this.amount,
    this.date,
  });

  int id;
  String amount;
  DateTime date;

  factory UserTransaction.fromJson(Map<String, dynamic> json) => UserTransaction(
    id: json["id"],
    amount: json["amount"],
    date: DateTime.parse(json["date"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "date": date.toString(),
  };
}
