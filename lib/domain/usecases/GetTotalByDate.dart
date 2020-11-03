import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/Transaction.dart';
import '../../core/usecases/UseCase.dart';
import '../../core/error/failures.dart';
import '../repositories/TransactionRepository.dart';

class GetTotalByDate implements UseCase<List<Transaction>, NoParams>{
  final TransactionRepository repository;

  GetTotalByDate(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async{
    return await repository.getTotalSpenditudeByDate();
  }

}

