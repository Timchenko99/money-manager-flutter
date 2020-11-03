part of './TransactionsByDateCubit.dart';

@immutable
abstract class TransactionsByDateState {

}

class TotalByDateInitialState extends TransactionsByDateState{}
class TotalByDateLoadingState extends TransactionsByDateState{}
class TotalByDateLoadedState extends TransactionsByDateState{
  final List<Transaction> transactions;

  TotalByDateLoadedState(this.transactions);
}
class TotalByDateErrorState extends TransactionsByDateState{
  final String message;

  TotalByDateErrorState(this.message);
}