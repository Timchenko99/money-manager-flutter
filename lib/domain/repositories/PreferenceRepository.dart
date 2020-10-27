import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:moneymanager_simple/core/error/failures.dart';
import 'package:moneymanager_simple/domain/entities/Preference.dart';

abstract class PreferenceRepository{
  Future<Either<Failure, Preference>> getPreferences();
  Future<Either<Failure, bool>> writePreferences(Preference preference);
}