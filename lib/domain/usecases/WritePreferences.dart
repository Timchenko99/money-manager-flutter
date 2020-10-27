import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:moneymanager_simple/domain/entities/Preference.dart';
import 'package:moneymanager_simple/domain/repositories/PreferenceRepository.dart';

import '../../core/usecases/UseCase.dart';
import '../../core/error/failures.dart';

class WritePreferences implements UseCase<bool, WritePreferencesParams>{
  final PreferenceRepository repository;

  WritePreferences(this.repository);

  @override
  Future<Either<Failure, bool>> call(WritePreferencesParams params) async{
    return await repository.writePreferences(params.preference);
  }

}

class WritePreferencesParams extends Equatable{
  final Preference preference;

  WritePreferencesParams(this.preference);

  @override
  List<Object> get props => [preference];

}