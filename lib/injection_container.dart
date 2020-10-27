
import 'package:get_it/get_it.dart';
import 'package:moneymanager_simple/presentation/cubit/TransactionCubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './data/datasources/LocalPreferenceSource.dart';
import './data/datasources/local_data_source.dart';
import './data/repositories/PreferenceRepositoryImpl.dart';
import './data/repositories/TransactionRepositoryImpl.dart';
import './domain/repositories/PreferenceRepository.dart';
import './domain/repositories/TransactionRepository.dart';
import './presentation/bloc/preferences/PreferencesBloc.dart';
import './presentation/bloc/transactions/TransactionBloc.dart';

import './domain/usecases/GetAllTransactions.dart';
import './domain/usecases/GetPreferences.dart';
import './domain/usecases/InsertTransaction.dart';
import './domain/usecases/WritePreferences.dart';

import './domain/usecases/GetConcreteTransaction.dart';
import './domain/usecases/DeleteTransaction.dart';

final serviceLocator = GetIt.instance;

Future<void> init() async{

  //Bloc
  serviceLocator.registerFactory(() => TransactionBloc(
    getAllTransactions: serviceLocator(),
    getConcreteTransaction: serviceLocator(),
    insertTransaction: serviceLocator(),
    deleteTransaction: serviceLocator()
  ));

  serviceLocator.registerFactory(() => PreferenceBloc(
    getPreferences: serviceLocator(),
    writePreferences: serviceLocator()
  ));
  //Cubit
  serviceLocator.registerFactory(() => TransactionCubit(
    getAllTransactionsCase: serviceLocator(),
    getConcreteTransactionCase: serviceLocator(),
    insertTransactionCase: serviceLocator(),
    deleteTransactionCase: serviceLocator()
  ));
  //Use cases
  serviceLocator.registerLazySingleton(() => GetConcreteTransaction(
      repository: serviceLocator()
  ));
  serviceLocator.registerLazySingleton(() => GetAllTransactions(serviceLocator()));
  serviceLocator.registerLazySingleton(() => InsertTransaction(serviceLocator()));
  serviceLocator.registerLazySingleton(() => DeleteTransaction(serviceLocator()));

  serviceLocator.registerLazySingleton(() => GetPreferences(serviceLocator()));
  serviceLocator.registerLazySingleton(() => WritePreferences(serviceLocator()));


  // serviceLocator.registerFactory(() => PreferencesProvider(serviceLocator()));

  //Repository
  serviceLocator.registerLazySingleton<TransactionRepository>(() => TransactionRepositoryImpl(
    localDataSource: serviceLocator()
  ));

  serviceLocator.registerLazySingleton<PreferenceRepository>(() => PreferenceRepositoryImpl(
    localPreferenceSource: serviceLocator()
  ));

  //Data sources
  serviceLocator.registerLazySingleton<LocalDataSource>(() => TransactionLocalDataSourceImpl());

  serviceLocator.registerLazySingleton<LocalPreferenceSource>(() => LocalPreferenceSourceImpl(
    sharedPreferences: serviceLocator()
  ));
  //Core

  //External
  final sharedPreferences = await SharedPreferences.getInstance();

  serviceLocator.registerLazySingleton<SharedPreferences>(() => sharedPreferences);

}
