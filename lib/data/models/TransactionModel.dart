// To parse this JSON data, do
//
//     final userTransaction = userTransactionFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/Transaction.dart';

TransactionModel transactionModelFromJson(String str) => TransactionModel.fromJson(json.decode(str));

String transactionModelToJson(TransactionModel data) => json.encode(data.toJson());

class TransactionModel extends Transaction{
  TransactionModel({@required String id, @required String title,
   @required DateTime date, @required double amount,
    @required IconData icon
  }):super(id: id, title: title, date: date, amount: amount, icon: icon);


  factory TransactionModel.fromJson(Map<String, dynamic> json) => TransactionModel(
    id: json["id"],
    title: json["title"],
    date: DateTime.fromMillisecondsSinceEpoch(int.parse(json["date"])),
    amount: json["amount"],
    icon: IconData(json["iconCode"], fontFamily: json["iconFamily"], fontPackage: json["iconPackage"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date.millisecondsSinceEpoch.toString(),
    "day": date.day,
    "month": date.month,
    "_year": date.year,
    "amount": amount,
    "iconCode": icon.codePoint,
    "iconFamily": icon.fontFamily,
    "iconPackage": icon.fontPackage

  };

}
