import 'package:dartz/dartz.dart';
import 'package:moneymanager_simple/core/error/failures.dart';
import 'package:moneymanager_simple/domain/entities/Transaction.dart';
import 'dart:core';

abstract class TransactionRepository{
  Future<Either<Failure, List<Transaction>>> getAllTransactions();
  Future<Either<Failure, Transaction>> getConcreteTransaction(String id);
  Future<Either<Failure, int>> insertTransaction(Transaction transaction);
  Future<Either<Failure, int>> deleteTransaction(String id);
  Future<Either<Failure,List<Transaction>>> getTotalSpenditudeByDate();
}