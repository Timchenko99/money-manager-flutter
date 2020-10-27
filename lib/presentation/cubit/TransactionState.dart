part of './TransactionCubit.dart';

@immutable
abstract class TransactionState {

}

class TransactionInitialState extends TransactionState{}
class TransactionLoadingState extends TransactionState{}
class TransactionLoadedState extends TransactionState{
  final List<Transaction> transactions;

  TransactionLoadedState(this.transactions);
}
class TransactionErrorState extends TransactionState{
  final String message;

  TransactionErrorState(this.message);
}