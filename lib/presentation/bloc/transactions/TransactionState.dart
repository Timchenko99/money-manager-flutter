import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:moneymanager_simple/domain/entities/Transaction.dart';

@immutable
abstract class TransactionState extends Equatable{
  @override
  List<Object> get props => [];
}

class TransactionLoadingState extends TransactionState{}

class TransactionLoadSuccessState extends TransactionState{
  final List<Transaction> transactions;

  TransactionLoadSuccessState({@required this.transactions});

  @override
  List<Object> get props => [transactions];
}

class TransactionLoadFailureState extends TransactionState{}