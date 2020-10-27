import 'package:dartz/dartz.dart';

import '../../domain/entities/Transaction.dart';
import '../../core/usecases/UseCase.dart';
import '../../core/error/failures.dart';
import '../repositories/TransactionRepository.dart';

class GetAllTransactions implements UseCase<List<Transaction>, NoParams>{
  final TransactionRepository repository;

  GetAllTransactions(this.repository);

  @override
  Future<Either<Failure, List<Transaction>>> call(NoParams params) async{
    return await repository.getAllTransactions();
  }

}
