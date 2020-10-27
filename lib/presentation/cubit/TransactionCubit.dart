
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:moneymanager_simple/core/usecases/UseCase.dart';

import 'package:moneymanager_simple/domain/entities/Transaction.dart';
import 'package:moneymanager_simple/domain/usecases/DeleteTransaction.dart';
import 'package:moneymanager_simple/domain/usecases/GetAllTransactions.dart';
import 'package:moneymanager_simple/domain/usecases/GetConcreteTransaction.dart';
import 'package:moneymanager_simple/domain/usecases/InsertTransaction.dart';


part './TransactionState.dart';

class TransactionCubit extends Cubit<TransactionState>{
  final GetConcreteTransaction getConcreteTransactionCase;
  final GetAllTransactions getAllTransactionsCase;
  final InsertTransaction insertTransactionCase;
  final DeleteTransaction deleteTransactionCase;

  TransactionCubit({this.getConcreteTransactionCase, this.getAllTransactionsCase, this.insertTransactionCase, this.deleteTransactionCase}):super(TransactionInitialState());

  getAllTransactions()async{
      emit(TransactionLoadingState());
      final eitherTransactionsOrFailure = await getAllTransactionsCase(NoParams());
      eitherTransactionsOrFailure.fold((failure) => this.emit(TransactionErrorState("OOPS")),
              (transactions) => this.emit(TransactionLoadedState(transactions)));
  }

  insertTransaction(Transaction transaction)async{
    emit(TransactionLoadingState());
    await insertTransactionCase(InsertTransactionParams(transaction));
    this.getAllTransactions();
  }
}
