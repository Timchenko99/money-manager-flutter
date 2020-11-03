
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';
import 'package:moneymanager_simple/core/usecases/UseCase.dart';

import 'package:moneymanager_simple/domain/entities/Transaction.dart';
import 'package:moneymanager_simple/domain/usecases/DeleteTransaction.dart';
import 'package:moneymanager_simple/domain/usecases/GetAllTransactions.dart';
import 'package:moneymanager_simple/domain/usecases/GetConcreteTransaction.dart';
import 'package:moneymanager_simple/domain/usecases/GetTotalByDate.dart';
import 'package:moneymanager_simple/domain/usecases/InsertTransaction.dart';


part './TransactionsByDateState.dart';

class TransactionsByDateCubit extends Cubit<TransactionsByDateState>{
  final GetTotalByDate getTotalByDate;

  TransactionsByDateCubit({this.getTotalByDate}):super(TotalByDateInitialState());

  getTotalSpenditudeByDate()async{
    emit(TotalByDateLoadingState());
    final eitherTransactionsOrFailure = await getTotalByDate(NoParams());
    eitherTransactionsOrFailure.fold((failure) => this.emit(TotalByDateErrorState("OOPS")),
            (transactions) => this.emit(TotalByDateLoadedState(transactions)));

  }

}
