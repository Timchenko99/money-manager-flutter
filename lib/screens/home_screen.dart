import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import 'dart:math';

import './add_screen.dart';

import '../data/DBHelper.dart';
import '../model/UserTransaction.dart';
import '../data/UserPreferences.dart';

import '../л.dart';

class HomeScreen extends StatefulWidget {


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  Widget build(BuildContext context) {
    // final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: NeumorphicTheme(
        theme: NeumorphicThemeData(),
        child: NeumorphicButton(
          key: UniqueKey(),
          onPressed: () async {
            await Navigator.push(
                context, MaterialPageRoute(builder: (context) => AddScreen()));
            //print("redraw");
            setState(() {});
          },
          style: NeumorphicStyle(
              shape: NeumorphicShape.flat,
              color: Theme.of(context).backgroundColor,
              boxShape: NeumorphicBoxShape.circle()),
          child: Icon(Icons.add,
              size: 40, color: Color.fromRGBO(116, 116, 116, 1)),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 54.0),
            Center(
              child:
                  Text("Budget", style: Theme.of(context).textTheme.headline4),
            ),
            SizedBox(height: 70),
            FutureBuilder(
              future: DBHelper().getAllTransactions(),
              builder: (context, snapshot){
                if(snapshot.connectionState == ConnectionState.done)
                  return NeumorphicPieChart(snapshot.data);
                else return Container();
              },
            )
          ],
        ),
      ),
    );
  }
}

class NeumorphicPieChart extends StatelessWidget {
  final List<UserTransaction> transactions;

  NeumorphicPieChart(this.transactions);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 253,
      height: 253,
      child: LayoutBuilder(
          builder: (context, constraint) => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: -10,
                          blurRadius: 17,
                          offset: Offset(-5, -5),
                          color: Colors.white),
                      BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(7, 7),
                          color: Color.fromRGBO(146, 182, 216, 1))
                    ]),
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: constraint.maxWidth * 0.6,
                        child: CustomPaint(
                          child: Center(),
                          foregroundPainter: PieChartPainter(
                            width: constraint.maxWidth * 0.5,
                            transactions: transactions
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: constraint.maxWidth * 0.86,
                        width: constraint.maxWidth * 0.86,
                        decoration: ConcaveDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(200)),
                            colors: [Colors.white, Colors.black],
                            depth: 5,
                            opacity: 0.5),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: constraint.maxWidth * 0.4,
                        decoration: BoxDecoration(
                            color: Theme.of(context).backgroundColor,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                  blurRadius: 1,
                                  offset: Offset(-1, -1),
                                  color: Colors.white),
                              BoxShadow(
                                  spreadRadius: -2,
                                  blurRadius: 10,
                                  offset: Offset(5, 5),
                                  color: Colors.black.withOpacity(0.5))
                            ]),
                        child: Center(
                          child: Text(
                              "${NumberFormat("##0%").format(/*transactions.fold(0, (previousValue, element) => previousValue + element.amount)*/ 1 / UserPreferences().dailyBudget)}",
                              style: GoogleFonts.rubik(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(185, 99, 99, 1))),
                        ),
                        // child: Text("${NumberFormat("##0%").format(transactions.fold(0, (previousValue, element) => previousValue + element.amount)/UserPreferences().monthBalance)}", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18.0, color: Color.fromRGBO(185, 99, 99, 1) )),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: constraint.maxWidth * 0.3,
                        width: constraint.maxWidth * 0.3,
                        decoration: ConcaveDecoration(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(155)),
                            colors: [Colors.white, Colors.black],
                            opacity: 0.5,
                            depth: 5),
                      ),
                    )
                  ],
                ),
          )
      ),
    );
  }
}

class PieChartPainter extends CustomPainter {
  PieChartPainter({@required this.width, @required this.transactions});

  final double width;
  final List<UserTransaction> transactions;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    // double total = 0;
    // categories.forEach((expenses)=> total += expenses.amount);

    double startRadian = -pi / 2;
    paint.color = Color.fromRGBO(228, 168, 168, 1);
    canvas.drawArc(
        Rect.fromCircle(center: center, radius: radius),
        startRadian,
        ( (1  / UserPreferences().dailyBudget) * 2 * pi ),
        false,
        paint);

    // for (var index = 0; index < categories.length; index++){
    //   final currentCategory = categories.elementAt(index);
    //   final sweepingRadian = currentCategory.amount / total * 2 * pi;
    //
    //   paint.color = kNeumorphicColors.elementAt(index % categories.length);
    //   canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startRadian, sweepingRadian, false, paint);
    //   startRadian += sweepingRadian;
    // }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class ExpenseWidget extends StatelessWidget {
  const ExpenseWidget({Key key, this.title, this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Row(
        children: [
          Container(
            width: 7,
            height: 7,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: this.color),
          ),
          SizedBox(
            width: 20,
          ),
          Text(this.title.capitalize()),
        ],
      ),
    );
  }
}

extension StringExtension on String {
  String capitalize() => "${this[0].toUpperCase()}${this.substring(1)}";
}
