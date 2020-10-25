import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/screens/add_screen.dart';
import 'package:provider/provider.dart';

import './providers/DBProvider.dart';
import './providers/PreferencesProvider.dart';
import './data/UserPreferences.dart';
import './screens/new_target_screen.dart';
import './screens/overview_screen.dart';
import './screens/start_screen.dart';
import './screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final int scheduleID = 1;

  await AndroidAlarmManager.initialize();
  await UserPreferences().init();

  runApp(MyApp());

  await AndroidAlarmManager.periodic(Duration(days: 1), scheduleID, scheduler,
      startAt: DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day + 1));
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

  String getStartScreen(bool isFirstBoot){
    return isFirstBoot ? StartScreen.routeName : HomeScreen.routeName;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => DBProvider(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => PreferencesProvider(),
        )
      ],


      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          inputDecorationTheme: InputDecorationTheme(

            labelStyle: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 16),
              border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  )
              )
          )
        ),
        home: HomeScreen(),
        //TODO: use preferences
        initialRoute: getStartScreen(false),
        routes: {
          StartScreen.routeName: (ctx) => StartScreen(),
          OverviewScreen.routeName: (ctx) => OverviewScreen(),
          NewTarget.routeName: (ctx) => NewTarget(),
          HomeScreen.routeName: (ctx) => HomeScreen(),
          AddScreen.routeName: (ctx) => AddScreen(),
          // OverviewScreen.routeName: (ctx) => OverviewScreen(),

        }
      ),
    );
  }
}
