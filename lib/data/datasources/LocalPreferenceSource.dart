
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:moneymanager_simple/core/error/exceptions.dart';
import 'package:moneymanager_simple/core/error/failures.dart';
import 'package:moneymanager_simple/data/models/PreferenceModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';


abstract class LocalPreferenceSource{
  Future<PreferenceModel> getPreferences();
  Future<bool> writePreferences(PreferenceModel preferenceModel);
}

const PREFERENCE_SOURCE_NAME = 'PREFERENCES';

class LocalPreferenceSourceImpl implements LocalPreferenceSource{
  final SharedPreferences sharedPreferences;

  LocalPreferenceSourceImpl({@required this.sharedPreferences});

  @override
  Future<PreferenceModel> getPreferences() {
    final jsonString = sharedPreferences.getString(PREFERENCE_SOURCE_NAME);
    print(jsonString);
    if (jsonString != null) {
     return Future.value(PreferenceModel.fromJson(json.decode(jsonString)));
      // return Future.value(NumberTriviaModel.fromJson(json.decode(jsonString)));
    } else {
      return Future.value(PreferenceModel(isFirstBoot: true, goal: "None", targetedAmount: 0, dailyBudget: 0));
    }
  }

  @override
  Future<bool> writePreferences(PreferenceModel preferenceModel) {
    return sharedPreferences.setString(PREFERENCE_SOURCE_NAME, json.encode(preferenceModel.toJson()));
  }

}

