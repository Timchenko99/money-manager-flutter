import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/core/error/exceptions.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';
import 'package:moneymanager_simple/data/models/PreferenceModel.dart';
import 'package:moneymanager_simple/presentation/cubit/PreferenceCubit.dart';
import 'package:moneymanager_simple/presentation/pages/home_screen.dart';

import './new_target_screen.dart';
import '../../core/styles.dart';
import '../widgets/BottomWideButton.dart';

class StartScreen extends StatelessWidget {
  static const routeName = "/start";

  @override
  Widget build(BuildContext context) {
    UserPreferences().isFirstBoot = false;

    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: Styles.backgroundGradient
          ),
          child: Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Splash(),
              ),
              // Image.asset("assets/images/splash.png", ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
                child: Content(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Content extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        "FINANCE APP",

        style: GoogleFonts.rubik(
            fontWeight: FontWeight.bold, fontSize: 36, color: Colors.white),
      ),
      SizedBox(
        height: mediaQuery.size.height * 0.07,
      ),
      Text('''Welcome !\n\nNice to see You here.
                  \nI always wanted create a finance app so that all the features would be free and without “loot boxes”.
                  \nIf You want to get the code and play with visit this link:
                  \nhttps://github.com/Timchenko99/money-manager-flutter
                  \nAlso it would be kind of You if You starred this repo.
                  \n\nThank You''',
          style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 18, foreground: Paint()..shader = Styles.textLinearGradient)),
      SizedBox(
        height: mediaQuery.size.height * 0.05,
      ),
      BottomWideButton(
        title: "Start",
        onPressed: ()=> Navigator.of(context).pushReplacementNamed(NewTarget.routeName),
      )
    ]);
  }
}

class Splash extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: SplashPainter(),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 350,
      ),
    );
  }
}

class SplashPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    //TODO: add gradient to splash
    // var gradient = RadialGradient(
    //     center: const Alignment(0.5, 0.5),
    //     radius: 0.2,
    //     colors: [Color(0xB38769FF), Color(0xFF2C1390)],
    //     stops: [0.4, 1.0]);

    Paint paint = Paint();
    // ..maskFilter =
    // ..shader = gradient.createShader(rect);
    Path path = Path();

    // Path number 1

    paint.color = Color(0xFF8769FF);
    path.lineTo(size.width * 0.45, -0.4);
    path.cubicTo(size.width * 0.52, -0.43, size.width * 0.58, -0.48,
        size.width * 0.66, -0.48);
    path.cubicTo(size.width * 0.73, -0.48, size.width * 0.79, -0.43,
        size.width * 0.85, -0.41);
    path.cubicTo(
        size.width * 0.92, -0.38, size.width, -0.36, size.width * 1.04, -0.31);
    path.cubicTo(size.width * 1.08, -0.26, size.width * 1.08, -0.19,
        size.width * 1.09, -0.12);
    path.cubicTo(size.width * 1.1, -0.06, size.width * 1.12, 0,
        size.width * 1.11, size.height * 0.06);
    path.cubicTo(size.width * 1.11, size.height * 0.13, size.width * 1.1,
        size.height / 5, size.width * 1.06, size.height * 0.26);
    path.cubicTo(size.width * 1.02, size.height * 0.32, size.width * 0.95,
        size.height * 0.34, size.width * 0.89, size.height * 0.38);
    path.cubicTo(size.width * 0.83, size.height * 0.43, size.width * 0.78,
        size.height / 2, size.width * 0.71, size.height * 0.52);
    path.cubicTo(size.width * 0.63, size.height * 0.53, size.width * 0.57,
        size.height * 0.48, size.width * 0.49, size.height * 0.46);
    path.cubicTo(size.width * 0.43, size.height * 0.44, size.width * 0.36,
        size.height * 0.42, size.width * 0.3, size.height * 0.39);
    path.cubicTo(size.width * 0.24, size.height * 0.36, size.width * 0.16,
        size.height / 3, size.width * 0.13, size.height * 0.27);
    path.cubicTo(size.width * 0.1, size.height / 5, size.width * 0.12,
        size.height * 0.13, size.width * 0.12, size.height * 0.06);
    path.cubicTo(size.width * 0.12, 0, size.width * 0.11, -0.07,
        size.width * 0.13, -0.14);
    path.cubicTo(size.width * 0.15, -0.21, size.width * 0.17, -0.28,
        size.width * 0.23, -0.33);
    path.cubicTo(size.width * 0.29, -0.38, size.width * 0.38, -0.38,
        size.width * 0.45, -0.4);
    path.cubicTo(size.width * 0.45, -0.4, size.width * 0.45, -0.4,
        size.width * 0.45, -0.4);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
