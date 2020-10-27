import 'package:dartz/dartz.dart';
import 'package:moneymanager_simple/domain/entities/Preference.dart';
import 'package:moneymanager_simple/domain/repositories/PreferenceRepository.dart';

import '../../core/usecases/UseCase.dart';
import '../../core/error/failures.dart';

class GetPreferences implements UseCase<Preference, NoParams>{
  final PreferenceRepository repository;

  GetPreferences(this.repository);

  @override
  Future<Either<Failure, Preference>> call(NoParams params) async{
    return await repository.getPreferences();
  }

}