import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';

import 'package:moneymanager_simple/core/error/failures.dart';
import 'package:moneymanager_simple/core/usecases/UseCase.dart';
import 'package:moneymanager_simple/domain/entities/Transaction.dart';
import 'package:moneymanager_simple/domain/usecases/DeleteTransaction.dart';
import 'package:moneymanager_simple/domain/usecases/GetAllTransactions.dart';
import 'package:moneymanager_simple/domain/usecases/GetConcreteTransaction.dart';
import 'package:moneymanager_simple/domain/usecases/InsertTransaction.dart';
import './TransactionEvent.dart';
import './TransactionState.dart';


class TransactionBloc extends Bloc<TransactionEvent, TransactionState>{
  final GetConcreteTransaction getConcreteTransaction;
  final GetAllTransactions getAllTransactions;
  final InsertTransaction insertTransaction;
  final DeleteTransaction deleteTransaction;


  TransactionBloc({this.getConcreteTransaction, this.getAllTransactions,
      this.insertTransaction, this.deleteTransaction}):super(TransactionLoadingState());

  @override
  Stream<TransactionState> mapEventToState(TransactionEvent event) async* {
    if(event is TransactionLoadSuccessEvent){
      final transactions = await getAllTransactions(NoParams());
      yield* _mapLoadedToState(transactions);
    }else if(event is GetAllTransactionsEvent){
      final transactions = await getAllTransactions(NoParams());
      yield* _mapLoadedToState(transactions);
    }/*else if(event is GetTransactionEvent){
      final transaction = await getConcreteTransaction(ConcreteTransactionParams(event.id));
      yield* _eitherLoadSuccessStateEventOrErrorState(transaction);
    }else if(event is InsertTransactionEvent){
      final insertResult = await insertTransaction(InsertTransactionParams(event.transaction));
      yield* _eitherInsertStateOrErrorState(insertResult);
    }else if(event is DeleteTransactionEvent){
      final deleteResult = await deleteTransaction(DeleteTransactionParams(event.id));
      yield* _eitherInsertStateOrErrorState(deleteResult);
    }*/
  }

  Stream<TransactionState> _mapLoadedToState(Either<Failure, List<Transaction>> failureOrTransactionList) async*{
    yield failureOrTransactionList.fold(
          (failure) => TransactionLoadFailureState(),
          (transactions) => TransactionLoadSuccessState(transactions: transactions),
    );
  }

  // Stream<TransactionState> _mapInsertToState(Either<Failure, int> failureOrTransactionList) async*{
  //   yield failureOrTransactionList.fold(
  //         (failure) => TransactionLoadFailureState(),
  //         (transactions){
  //
  //         },
  //   );
  // }


}