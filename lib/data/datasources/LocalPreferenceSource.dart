
import 'dart:convert';

import 'package:flutter/foundation.dart';
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
    return Future.value(PreferenceModel.fromJson(json.decode(sharedPreferences.get(PREFERENCE_SOURCE_NAME))));
  }

  @override
  Future<bool> writePreferences(PreferenceModel preferenceModel) {
    return sharedPreferences.setString(PREFERENCE_SOURCE_NAME, json.encode(preferenceModel.toJson()));
  }

}