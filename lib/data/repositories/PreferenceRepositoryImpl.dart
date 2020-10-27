import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:moneymanager_simple/core/error/exceptions.dart';
import 'package:moneymanager_simple/core/error/failures.dart';
import 'package:moneymanager_simple/data/datasources/LocalPreferenceSource.dart';
import 'package:moneymanager_simple/domain/entities/Preference.dart';
import 'package:moneymanager_simple/domain/repositories/PreferenceRepository.dart';



class PreferenceRepositoryImpl implements PreferenceRepository{
  final LocalPreferenceSource localPreferenceSource;

  PreferenceRepositoryImpl({@required this.localPreferenceSource});

  @override
  Future<Either<Failure, Preference>> getPreferences() async{
    try{
      final result = await localPreferenceSource.getPreferences();
      return Right(result);
    } on LocalDataException{
      return Left(LocalDataFailure());
    }
  }
  @override
  Future<Either<Failure, bool>> writePreferences(Preference preference) async{
    try{
      final result = await localPreferenceSource.writePreferences(preference);
      return Right(result);
    } on LocalDataException{
      return Left(LocalDataFailure());
    }
  }

}