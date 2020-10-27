import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/presentation/cubit/TransactionCubit.dart';

import './presentation/pages/add_screen.dart';
import './presentation/pages/new_target_screen.dart';
import './presentation/pages/start_screen.dart';
import './presentation/pages/home_screen.dart';
import './injection_container.dart' as dependencyInjection;
import 'presentation/bloc/preferences/PreferencesBloc.dart';
import './presentation/bloc/transactions/TransactionBloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // final int scheduleID = 1;

  dependencyInjection.init();
  //await AndroidAlarmManager.initialize();
  //await UserPreferences().init();

  runApp(MyApp());

  //await AndroidAlarmManager.periodic(Duration(days: 1), scheduleID, scheduler,
  // startAt: DateTime(
  //     DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));
}

void scheduler() {
  // final DateTime now = DateTime.now();
  // DBHelper().newTransaction(UserTransaction(id: Uuid().v1(), amount: 0, type: 0, day: now.day, month: now.month, year: now.year, weekday: now.weekday));
  print("Scheduler!");
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String getStartScreen(bool isFirstBoot) {
    return isFirstBoot ? StartScreen.routeName : HomeScreen.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<TransactionBloc>(
          create: (_) => dependencyInjection.serviceLocator<TransactionBloc>(),
        ),
        BlocProvider<PreferenceBloc>(
          create: (_) => dependencyInjection.serviceLocator<PreferenceBloc>(),
        ),
        BlocProvider<TransactionCubit>(
          create: (_) => dependencyInjection.serviceLocator<TransactionCubit>(),
        )
      ],
      child: MaterialApp(
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
                )))),
        home: HomeScreen(),
        //TODO: use preferences
        initialRoute: getStartScreen(false),
        routes: {
          StartScreen.routeName: (ctx) => StartScreen(),
          // OverviewScreen.routeName: (ctx) => OverviewScreen(),
          NewTarget.routeName: (ctx) => NewTarget(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AddScreen.routeName: (ctx) => AddScreen(),
          // OverviewScreen.routeName: (ctx) => OverviewScreen(),
        },
      ),
    );
  }
}
