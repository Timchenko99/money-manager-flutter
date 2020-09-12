import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';
import './screens/Home.dart';
import './screens/Overview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await UserPreferences().init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.pink,
        backgroundColor: Color.fromRGBO(218, 227, 235, 1),
        accentColor: Color.fromRGBO(228, 168, 168, 1),
        textTheme: TextTheme(
          headline1: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          headline2: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          headline3: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          headline4: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 36.0, color: Color.fromRGBO(116, 116, 116, 1) ),
          headline5: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 36.0, color: Color.fromRGBO(90, 90, 90, 1) ),
          headline6: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          subtitle1: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          subtitle2: GoogleFonts.roboto(fontSize: 18.0, color: Color.fromRGBO(116, 116, 116, 1)),
          bodyText1: GoogleFonts.roboto(fontSize: 16.0, fontWeight: FontWeight.bold, color: Color.fromRGBO(116, 116, 116, 1)),
          bodyText2: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          button: GoogleFonts.roboto(fontWeight: FontWeight.bold,color: Color.fromRGBO(77 , 91, 105, 1)),
          caption: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
          overline: GoogleFonts.roboto(color: Color.fromRGBO(116, 116, 116, 1)),
        ),
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Overview(),
    );
  }
}

