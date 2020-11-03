import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/core/error/exceptions.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';
import 'package:moneymanager_simple/data/models/PreferenceModel.dart';
import 'package:moneymanager_simple/domain/entities/Preference.dart';
import 'package:moneymanager_simple/presentation/cubit/PreferenceCubit.dart';
import 'package:moneymanager_simple/presentation/cubit/TransactionCubit.dart';
import 'package:moneymanager_simple/presentation/cubit/TransactionsByDateCubit.dart';

import './presentation/pages/add_screen.dart';
import './presentation/pages/new_target_screen.dart';
import './presentation/pages/start_screen.dart';
import './presentation/pages/home_screen.dart';
import './injection_container.dart' as dependencyInjection;
import 'presentation/bloc/preferences/PreferencesBloc.dart';
import './presentation/bloc/transactions/TransactionBloc.dart';
import 'presentation/pages/overview_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dependencyInjection.init();
  UserPreferences().init();
  runApp(MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(
          create: (_) => dependencyInjection.serviceLocator<TransactionBloc>(),
        ),
        BlocProvider<PreferenceBloc>(
          create: (_) => dependencyInjection.serviceLocator<PreferenceBloc>(),
        ),
        BlocProvider<TransactionCubit>(
          create: (_) => dependencyInjection.serviceLocator<TransactionCubit>(),
        ),
        BlocProvider<TransactionsByDateCubit>(
          create: (_)=>dependencyInjection.serviceLocator<TransactionsByDateCubit>(),
        )
      ],
      child:MyApp()));
}

class MyApp extends StatelessWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          inputDecorationTheme: InputDecorationTheme(
            labelStyle:
                GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16),
            border: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).primaryColor,
                width: 2,
              ),
            ),
          ),
        ),
        home: HomeScreen(),
        initialRoute: UserPreferences().isFirstBoot ? StartScreen.routeName : HomeScreen.routeName,
        routes: {
          StartScreen.routeName: (ctx) => StartScreen(),
          OverviewScreen.routeName: (ctx) => OverviewScreen(),
          NewTarget.routeName: (ctx) => NewTarget(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AddScreen.routeName: (ctx) => AddScreen(),
          // OverviewScreen.routeName: (ctx) => OverviewScreen(),
        },
    );
  }
}
