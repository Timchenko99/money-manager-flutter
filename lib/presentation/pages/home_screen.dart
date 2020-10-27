import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager_simple/presentation/cubit/TransactionCubit.dart';
import 'dart:math';

import './add_screen.dart';
import '../../core/styles.dart';
import '../../data/models/TransactionModel.dart';
import '../../л.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = "/home";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
          decoration: BoxDecoration(gradient: Styles.backgroundGradient),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.settings,
                      color: Theme.of(context).primaryColor,
                      size: 36.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () =>
                    //TODO: use .then() to update home screen
                        Navigator.of(context).pushNamed(AddScreen.routeName),
                    icon: Icon(
                      Icons.add_circle_outline,
                      color: Theme.of(context).primaryColor,
                      size: 36,
                    ),
                    alignment: Alignment.center,
                  ),
                ],
              ),
              Text(
                "Budget",
                style: GoogleFonts.rubik(
                  fontWeight: FontWeight.bold,
                  fontSize: 36.0,
                ),
              ),
              PieChart(),
              TransactionHistory(),
              // BottomButton(),
            ],
          ),
        ),
      ),
    );
  }
}

class BottomButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      onPressed: () {},
      color: Theme.of(context).primaryColor,
      child: Icon(
        Icons.add,
        size: 42,
        color: Colors.white,
      ),
    );
  }
}

class TransactionHistory extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Transactions",
              style: GoogleFonts.roboto(
                fontWeight: FontWeight.bold,
                fontSize: 20.0,
              ),
            ),
            FlatButton(
              onPressed: () {},
              child: Text(
                "See All",
                style: GoogleFonts.roboto(
                  fontWeight: FontWeight.w500,
                  fontSize: 18.0,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            )
          ],
        ),
        TransactionList()
      ],
    );
  }
}

class ScrollWithoutGlowBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}

class TransactionList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.bloc<TransactionCubit>().getAllTransactions();

    return Container(
      // color: Colors.grey,
      height: MediaQuery.of(context).size.height * 0.3,
      child: ScrollConfiguration(
        behavior: ScrollWithoutGlowBehavior(),
        child: BlocBuilder<TransactionCubit, TransactionState>(
          builder: (context, state) {

            if(state is TransactionLoadingState){
              return Container();
            }
            else if(state is TransactionLoadedState){
              final transactions = state.transactions;
            return ListView.separated(
                itemCount: transactions.length,
                separatorBuilder: (ctx, index) => DottedLine(dashLength: 1.0),
                itemBuilder: (ctx, index) {
                  return ListTile(
                    leading: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          transactions[index].icon,
                          size: 32.0,
                        )
                      ],
                    ),
                    title: Text(
                      transactions[index].title,
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w600,
                        fontSize: 16.0,
                      ),
                    ),
                    subtitle: Text(
                      transactions[index].date.toIso8601String(),
                      style: GoogleFonts.roboto(
                        fontWeight: FontWeight.w400,
                        fontSize: 12.0,
                      ),
                    ),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          transactions[index].amount.floor().toString(),
                          style: GoogleFonts.roboto(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                          ),
                        )
                      ],
                    ),
                  );
                });
            }else{
              return Container();
            }


          },
        )
      ),
    );
  }
}

class MainRing extends StatelessWidget {
  final Widget child;

  MainRing({this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: child,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFFFFFFFF), Color(0xFFDAE3EB)],
        ),
        color: Colors.white /*Theme.of(context).backgroundColor*/,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            spreadRadius: -10,
            blurRadius: 17,
            offset: Offset(-5, -5),
            color: Colors.white,
          ),
          BoxShadow(
            spreadRadius: -2,
            blurRadius: 10,
            offset: Offset(7, 7),
            color: Color.fromRGBO(146, 182, 216, 1),
          )
        ],
      ),
    );
  }
}

class InnerRing extends StatelessWidget {
  final double height;

  InnerRing({this.height});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFFFFFFFF), Color(0xFFDAE3EB)],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              blurRadius: 1,
              offset: Offset(-1, -1),
              color: Colors.white,
            ),
            BoxShadow(
              spreadRadius: -2,
              blurRadius: 10,
              offset: Offset(5, 5),
              color: Colors.black.withOpacity(0.5),
            ),
          ],
        ),
        child: Center(
          child: Text(
            "${NumberFormat("##0%").format(1 /*transactions.fold(0, (previousValue, element) => previousValue + element.amount) 1 / UserPreferences().dailyBudget*/)}",
            style: GoogleFonts.rubik(
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              fontSize: 18.0,
            ),
          ),
        ),
        // child: Text("${NumberFormat("##0%").format(transactions.fold(0, (previousValue, element) => previousValue + element.amount)/UserPreferences().monthBalance)}", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18.0, color: Color.fromRGBO(185, 99, 99, 1) )),
      ),
    );
  }
}

class InnerRingDecoration extends StatelessWidget {
  final double height;
  final double width;

  InnerRingDecoration({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: ConcaveDecoration(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(155)),
          colors: [Colors.white, Colors.black],
          opacity: 0.5,
          depth: 5,
        ),
      ),
    );
  }
}

class PieProgress extends StatelessWidget {
  final double width;
  final double strokeWidth;

  PieProgress({this.width, this.strokeWidth});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: width,
        child: CustomPaint(
          child: Center(),
          foregroundPainter: PieChartPainter(
              width: strokeWidth,
              color: Theme.of(context).primaryColor,
              transactions: [TransactionModel()]),
        ),
      ),
    );
  }
}

class PieProgressDecoration extends StatelessWidget {
  final double height;
  final double width;

  PieProgressDecoration({this.height, this.width});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: width,
        decoration: ConcaveDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200)),
            colors: [Colors.white, Colors.black],
            depth: 5,
            opacity: 0.5),
      ),
    );
  }
}

class PieChart extends StatelessWidget {
  // final List<UserTransaction> transactions;

  // PieChart(this.transactions);

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Container(
      width: mediaQuery.size.width * 0.6 /*253*/,
      height: mediaQuery.size.height * 0.4 /*253*/,
      child: LayoutBuilder(
          builder: (context, constraint) => MainRing(
                child: Stack(
                  children: [
                    PieProgress(
                      width: constraint.maxWidth * 0.6,
                      strokeWidth: constraint.maxWidth * 0.5,
                    ),
                    PieProgressDecoration(
                      height: constraint.maxWidth * 0.86,
                      width: constraint.maxWidth * 0.86,
                    ),
                    InnerRing(
                      height: constraint.maxWidth * 0.4,
                    ),
                    InnerRingDecoration(
                      height: constraint.maxWidth * 0.25,
                      width: constraint.maxWidth * 0.25,
                    ),
                  ],
                ),
              )),
    );
  }
}

class PieChartPainter extends CustomPainter {
  PieChartPainter(
      {@required this.width,
      @required this.transactions,
      @required this.color});

  final double width;
  final List<TransactionModel> transactions;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    Rect rect = new Rect.fromCircle(
      center: center,
      radius: radius,
    );

    final Gradient gradient = new RadialGradient(
      colors: [Color(0xFF8769FF), Color(0xFF2C1390)],
      center: Alignment.topCenter,
      radius: 1.2,
    );

    var paint = Paint()
      ..shader = gradient.createShader(rect)
      ..style = PaintingStyle.stroke
      ..strokeWidth = width / 2;

    // double total = 0;
    // categories.forEach((expenses)=> total += expenses.amount);

    double startRadian = -pi / 2;
    paint.color = color;
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startRadian,
        ((1 / /*UserPreferences().dailyBudget*/ 2) * 2 * pi), false, paint);

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
