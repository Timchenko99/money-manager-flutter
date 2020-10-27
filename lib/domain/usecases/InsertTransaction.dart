import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../domain/entities/Transaction.dart';
import '../../core/usecases/UseCase.dart';
import '../../core/error/failures.dart';
import '../repositories/TransactionRepository.dart';

class InsertTransaction implements UseCase<int, InsertTransactionParams>{
  final TransactionRepository repository;

  InsertTransaction(this.repository);

  @override
  Future<Either<Failure, int>> call(InsertTransactionParams params) async{
    return await repository.insertTransaction(params.transaction);
  }

}

class InsertTransactionParams extends Equatable{
  final Transaction transaction;

  InsertTransactionParams(this.transaction);

  @override
  List<Object> get props => [transaction];

}