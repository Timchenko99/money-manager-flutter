
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:moneymanager_simple/domain/entities/Transaction.dart';

@immutable
abstract class TransactionEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class TransactionLoadSuccessEvent extends TransactionEvent{}

class GetTransactionEvent extends TransactionEvent{
  final String id;

  GetTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}

class GetAllTransactionsEvent extends TransactionEvent{
  final List<Transaction> transactions;

  GetAllTransactionsEvent(this.transactions);

  @override
  List<Object> get props => [transactions];
}

class InsertTransactionEvent extends TransactionEvent{
  final Transaction transaction;

  InsertTransactionEvent(this.transaction);

  @override
  List<Object> get props => [transaction];
}

class DeleteTransactionEvent extends TransactionEvent{
  final String id;

  DeleteTransactionEvent(this.id);

  @override
  List<Object> get props => [id];
}