// To parse this JSON data, do
//
//     final userTransaction = userTransactionFromJson(jsonString);

import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moneymanager_simple/domain/entities/Preference.dart';


PreferenceModel preferenceModelFromJson(String str) => PreferenceModel.fromJson(json.decode(str));

String preferenceModelToJson(PreferenceModel data) => json.encode(data.toJson());

class PreferenceModel extends Preference{
  PreferenceModel({@required bool isFirstBoot, @required String goal, @required double dailyBudget, @required double targetedAmount
  }):super(isFirstBoot: isFirstBoot, goal: goal, dailyBudget: dailyBudget, targetedAmount: targetedAmount);


  factory PreferenceModel.fromJson(Map<String, dynamic> json) => PreferenceModel(
    isFirstBoot: json["key"],
    goal: json["value"],
    dailyBudget: json["dailyBudget"],
    targetedAmount: json["targetedAmount"]
  );

  Map<String, dynamic> toJson() => {
    "isFirstBoot": isFirstBoot,
    "goal": goal,
    "dailyBudget": dailyBudget,
    "targetedAmount": targetedAmount
  };

}
