import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';

import './screens/Overview.dart';
import './screens/Start.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final int scheduleID = 1;

  await AndroidAlarmManager.initialize();
  await UserPreferences().init();

  runApp(MyApp());

  await AndroidAlarmManager.periodic(Duration(days: 1), scheduleID, scheduler, startAt:DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day+1));
}

void scheduler(){
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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: //_buildTheme(),
        ThemeData(
          primarySwatch: Colors.pink,
          backgroundColor: Color.fromRGBO(218, 227, 235, 1),
          accentColor: Color.fromRGBO(228, 168, 168, 1),
          //primaryColorLight: Color(0xFFEEFFFF),
          //primaryColorDark: Color(0xFF8AACC8),
          textTheme: TextTheme(
            headline1:
                GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
            headline2:
                GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
            headline3:
                GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
            headline4: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
                fontSize: 36.0,
                color: Color.fromRGBO(116, 116, 116, 1)),
            headline5: GoogleFonts.rubik(
                fontWeight: FontWeight.bold,
                fontSize: 36.0,
                color: Color.fromRGBO(90, 90, 90, 1)),
            headline6:

                GoogleFonts.roboto(
                    fontSize: 18.0,
fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(90, 90, 90, 1)),
            subtitle1:
                GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
            subtitle2: GoogleFonts.roboto(
                fontSize: 18.0, color: Color.fromRGBO(116, 116, 116, 1)),
            bodyText1: GoogleFonts.roboto(
                fontSize: 16.0,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(116, 116, 116, 1)),
            bodyText2:
                GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
            button: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(77, 91, 105, 1)),
            caption:
                GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
            overline:
                GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          ),
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: (UserPreferences().isFirstBoot ? Start():Overview())
    );
  }
}
