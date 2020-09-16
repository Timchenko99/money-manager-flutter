// To parse this JSON data, do
//
//     final userTransaction = userTransactionFromJson(jsonString);

import 'dart:convert';

import 'package:flutter/cupertino.dart';

UserTransaction userTransactionFromJson(String str) => UserTransaction.fromJson(json.decode(str));

String userTransactionToJson(UserTransaction data) => json.encode(data.toJson());

class UserTransaction {
  UserTransaction({
    @required this.id,
    @required this.amount,
    @required this.type,
    @required this.day,
    @required this.month,
    @required this.year,
    @required this.weekday,
  });

  String id;
  double amount;
  int type;
  int day;
  int month;
  int year;
  int weekday;

  factory UserTransaction.fromJson(Map<String, dynamic> json) => UserTransaction(
    id: json["id"],
    amount: json["amount"],
    type: json["type"],
    day: json["day"],
    month: json["month"],
    year: json["year"],
    weekday: json["weekday"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "amount": amount,
    "type": type,
    "day": day,
    "month": month,
    "year": year,
    "weekday": weekday,
  };
}
