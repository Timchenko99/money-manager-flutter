import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../core/usecases/UseCase.dart';
import '../../core/error/failures.dart';
import '../repositories/TransactionRepository.dart';

class DeleteTransaction implements UseCase<int, DeleteTransactionParams>{
  final TransactionRepository repository;

  DeleteTransaction(this.repository);

  @override
  Future<Either<Failure, int>> call(DeleteTransactionParams params) async{
    return await repository.deleteTransaction(params.id);
  }

}

class DeleteTransactionParams extends Equatable{
  final String id;

  DeleteTransactionParams(this.id);

  @override
  List<Object> get props => [id];

}