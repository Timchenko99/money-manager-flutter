import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import '../../domain/entities/Transaction.dart';
import '../../core/usecases/UseCase.dart';
import '../../core/error/failures.dart';
import '../repositories/TransactionRepository.dart';

class GetConcreteTransaction implements UseCase<Transaction, ConcreteTransactionParams>{
  final TransactionRepository repository;

  GetConcreteTransaction({@required this.repository});

  @override
  Future<Either<Failure, Transaction>> call(ConcreteTransactionParams params) async{
    return await repository.getConcreteTransaction(params.id);
  }

}

class ConcreteTransactionParams extends Equatable{
  final String id;

  ConcreteTransactionParams(this.id);

  @override
  List<Object> get props => [id];

}