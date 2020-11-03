import 'dart:core';
import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';

import '../datasources/local_data_source.dart';
import '../../core/error/failures.dart';
import '../../core/error/exceptions.dart';
import '../../domain/entities/Transaction.dart';
import '../../domain/repositories/TransactionRepository.dart';


class TransactionRepositoryImpl implements TransactionRepository{
  final LocalDataSource localDataSource;
  // final RemoteDataSource remoteDataSource;


  TransactionRepositoryImpl({@required this.localDataSource/*, @required this.remoteDataSource*/});

  @override
  Future<Either<Failure, List<Transaction>>> getAllTransactions(){
    return _getAllTransactions(localDataSource.getAllTransactions());
  }
  @override
  Future<Either<Failure, Transaction>> getConcreteTransaction(String id){
    return _getTransaction(localDataSource.getConcreteTransaction(id));
  }
  @override
  Future<Either<Failure, int>> insertTransaction(Transaction transaction){
    return _insertTransaction(localDataSource.insertTransaction(transaction));
  }
  @override
  Future<Either<Failure, int>> deleteTransaction(String id){
    return _deleteTransaction(localDataSource.deleteTransaction(id));
  }

  @override
  Future<Either<Failure, List<Transaction>>> getTotalSpenditudeByDate(){
    return _getTotalSpenditudeByDate(localDataSource.getTotalSpenditudeByDate());
  }
  @override
  Future<Either<Failure, List<Transaction>>> _getTotalSpenditudeByDate(Future<List<Transaction>> totalByDate) async{
    try{
      final transaction = await totalByDate;
      return Right(transaction);
    } on LocalDataException {
      return Left(LocalDataFailure());
    }
  }

  Future<Either<Failure, Transaction>> _getTransaction(Future<Transaction> getConcrete) async{
    try{
      final transaction = await getConcrete;
      return Right(transaction);
    } on LocalDataException {
      return Left(LocalDataFailure());
    }
  }

  Future<Either<Failure, List<Transaction>>> _getAllTransactions(Future<List<Transaction>> getAll) async{
    try{
      final transactions = await getAll;
      return Right(transactions);
    } on LocalDataException {
      return Left(LocalDataFailure());
    }
  }

  Future<Either<Failure, int>> _deleteTransaction(Future<int> deleteTransaction) async{
    try{
      final result = await deleteTransaction;
      return Right(result);
    } on LocalDataException {
      return Left(LocalDataFailure());
    }
  }

  Future<Either<Failure, int>> _insertTransaction(Future<int> insertTransaction) async{
    try{
      final result = await insertTransaction;
      return Right(result);
    } on LocalDataException {
      return Left(LocalDataFailure());
    }
  }


  
}