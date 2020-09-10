import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:intl/intl.dart';

import 'dart:math';

import './Add.dart';
import '../data/UserPreferences.dart';
import '../л.dart';


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool updateBudget = false;
  int _total = 0;

  @override
  void initState() {
    super.initState();
    _total = UserPreferences().monthBalance;
    //if(DateTime(DateTime.now().year, DateTime.now().month+1, 0).day == DateTime.now().day) updateBudget = true;
  }



  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      floatingActionButton: NeumorphicTheme(
        theme: NeumorphicThemeData(),
        child: NeumorphicButton(
          key: UniqueKey(),
          onPressed: () async {
            await Navigator.push(context, MaterialPageRoute(builder: (context)=>Add()));
            print("redraw");
            setState(() {

            });
          },
          style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            color: Theme.of(context).backgroundColor,
            boxShape: NeumorphicBoxShape.circle()
          ),
          child: Icon(Icons.add, size: 40, color: Color.fromRGBO(116, 116, 116, 1) ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 54.0),
            Center(
              child: Text("Budget", style: Theme.of(context).textTheme.headline4),
            ),
            SizedBox(height: 70),
            Container(
              width: 253,
              height: 253,
              child: LayoutBuilder(builder: (context, constraint) => Container(
                decoration: BoxDecoration(
                    color: Theme.of(context).backgroundColor,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: -10,
                          blurRadius: 17,
                          offset: Offset(-5,-5),
                          color: Colors.white
                      ),
                      BoxShadow(
                          spreadRadius: -2,
                          blurRadius: 10,
                          offset: Offset(7,7),
                          color: Color.fromRGBO(146, 182, 216, 1)
                      )
                    ]
                ),
                child: Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        width: constraint.maxWidth * 0.6,
                        child: CustomPaint(
                          child: Center(),
                          foregroundPainter: PieChartPainter(

                              width: constraint.maxWidth * 0.5,
                              categories: kCategories

                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: constraint.maxWidth * 0.86,
                        width: constraint.maxWidth * 0.86,
                        decoration: ConcaveDecoration(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(200)),
                            colors: [Colors.white, Colors.black],
                            depth: 5,
                            opacity: 0.5
                        ),
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
                                  offset: Offset(-1,-1),
                                  color: Colors.white
                              ),
                              BoxShadow(
                                  spreadRadius: -2,
                                  blurRadius: 10,
                                  offset: Offset(5,5),
                                  color: Colors.black.withOpacity(0.5)
                              )
                            ]
                        ),
                        child: Center(
                          child: Text("${NumberFormat("##0%").format(UserPreferences().currentBalance/UserPreferences().monthBalance)}", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontStyle: FontStyle.italic, fontSize: 18.0, color: Color.fromRGBO(185, 99, 99, 1) )),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        height: constraint.maxWidth * 0.3,
                        width: constraint.maxWidth * 0.3,
                        decoration: ConcaveDecoration(
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(155)),
                            colors: [Colors.white, Colors.black],
                            opacity: 0.5,
                            depth: 5
                        ),

                      ),
                    )
                    // Center(
                    //   child: Container(
                    //     height: constraint.maxWidth * 0.4,
                    //     decoration: ConcaveDecoration(shape: null, depth: null),
                    //   ),
                    // )
                  ],
                ),
              )),
            )


            // Stack(
            //   children: [
            //     Align(
            //       alignment: Alignment.center,
            //       child: Container(
            //         height: 253,
            //         width: 253,
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           boxShadow: [
            //             BoxShadow(
            //                 spreadRadius: -1,
            //                 blurRadius: 17,
            //                 offset: Offset(-5,-5),
            //                 color: Color.fromRGBO(234, 238, 242, 1)
            //             ),
            //             BoxShadow(
            //                 spreadRadius: -2,
            //                 blurRadius: 10,
            //                 offset: Offset(7,7),
            //                 color: Color.fromRGBO(141, 165, 187, 1)
            //             )
            //           ],
            //           color: Color.fromRGBO(218,227,235,1)
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       top: 19.0,
            //       left: 96.0,
            //       child: Container(
            //         height: 216,
            //         width: 216,
            //         decoration: ConcaveDecoration(
            //           shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(216/2)),
            //           colors: [Colors.white, Colors.black],
            //           depth: 5,
            //           opacity: 0.5
            //       )
            //       ),
            //     ),
            //     Positioned(
            //       top: 65.0,
            //       left: 140.0,
            //       child: Container(
            //         height: 122,
            //         width: 122,
            //
            //         decoration: BoxDecoration(
            //           shape: BoxShape.circle,
            //           color: Color.fromRGBO(218,227,235,1),
            //           boxShadow: [
            //             BoxShadow(
            //                 spreadRadius: -1,
            //                 blurRadius: 17,
            //                 offset: Offset(-5,-5),
            //                 color: Color.fromRGBO(234, 238, 242, 1)
            //             ),
            //             BoxShadow(
            //                 spreadRadius: -2,
            //                 blurRadius: 10,
            //                 offset: Offset(7,7),
            //                 color: Color.fromRGBO(141, 165, 187, 1)
            //             )
            //           ]
            //         ),
            //       ),
            //     ),
            //     Positioned(
            //       top: 95.0,
            //       left: 170.0,
            //       child: Container(
            //         height: 64,
            //         width: 64,
            //         decoration: ConcaveDecoration(
            //             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(64/2)),
            //             colors: [Colors.white, Colors.black],
            //             depth: 5,
            //             opacity: 0.5
            //         ),
            //       ),
            //     )
            //   ],
            // )
          ],
        ),
      ),
    );
  }
}

/*
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Placeholder(),
              ),
              Expanded(
                flex: 2,
                child: Placeholder(),
              )
            ],
          ),
 */

class Switch extends StatelessWidget {

  Switch(this.height);

  final height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.046,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: Container(
            padding: const EdgeInsets.all(7.0),
                // Color.fromRGBO(216, 213, 208, 1);
            decoration: ConcaveDecoration(
              shape: RoundedRectangleBorder(),
              colors: [
                Colors.white,
                Colors.black.withOpacity(0.5),
              ],
              depth: 2,
              opacity: 0.5

            ),
            // BoxDecoration(
            //     borderRadius: BorderRadius.circular(12.0),
            //     color: Color.fromRGBO(193, 214, 233, 1),
            //     boxShadow: [
            //       BoxShadow(
            //           color: Color.fromRGBO(146, 182, 216, 1),
            //           offset: Offset(7,7),
            //           spreadRadius: -3,
            //           blurRadius: 10
            //       ),
            //       const BoxShadow(
            //           color: Colors.white,
            //           offset: Offset(-11,-5),
            //           spreadRadius: -9.0,
            //           blurRadius: 14.0
            //       )
            //     ]
            // ),


          ),
        )

    );
  }

}


class BalanceWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}


class MonthlyExpensesWidget extends StatelessWidget {

  MonthlyExpensesWidget({@required this.height});

  final height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height * 0.43,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: height*0.065),
            Text("Monthly Expenses", style: GoogleFonts.rubik(fontWeight: FontWeight.w400, fontSize: 18)),
            SizedBox(height: height*0.042),
            Expanded(
              child: Row(
                children: [
                  CategoriesRow(),
                  PieChart()
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


class CategoriesRow extends StatelessWidget {
  const CategoriesRow({Key key}):super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(flex: 3, child: Column(
      mainAxisAlignment: MainAxisAlignment.center,

      children: kCategories.map((element) => ExpenseWidget(title: element.name, color: kNeumorphicColors[kCategories.indexOf(element)])).toList(),
    ),);
  }
}

class PieChart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 1,
      child: LayoutBuilder(builder: (context, constraint) => Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(193, 214, 233, 1),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              spreadRadius: -10,
              blurRadius: 17,
              offset: Offset(-5,-5),
              color: Colors.white
            ),
            BoxShadow(
              spreadRadius: -2,
              blurRadius: 10,
              offset: Offset(7,7),
              color: Color.fromRGBO(146, 182, 216, 1)
            )
          ]
        ),
        child: Stack(
          children: [
            Center(
              child: SizedBox(
                width: constraint.maxWidth * 0.6,
                child: CustomPaint(
                  child: Center(),
                  foregroundPainter: PieChartPainter(

                      width: constraint.maxWidth * 0.5,
                      categories: kCategories

                  ),
                ),
              ),
            ),
            Center(
              child: Container(
                height: constraint.maxWidth * 0.4,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(193, 214, 233, 1),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 1,
                      offset: Offset(-1,-1),
                      color: Colors.white
                    ),
                    BoxShadow(
                      spreadRadius: -2,
                      blurRadius: 10,
                      offset: Offset(5,5),
                      color: Colors.black.withOpacity(0.5)
                    )
                  ]
                ),
                child: Center(
                  child: Text("\$1280.20"),
                ),
              ),
            )
          ],
        ),
      ))
    );
  }
}

class PieChartPainter extends CustomPainter{

  PieChartPainter({@required this.categories, @required this.width});

  final List<Category> categories;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);

    var paint = Paint()
    ..style = PaintingStyle.stroke
    ..strokeWidth = width / 2;

    // double total = 0;
    // categories.forEach((expenses)=> total += expenses.amount);

    double startRadian = -pi/2;
    paint.color = Color.fromRGBO(228, 168, 168, 1);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startRadian, ((UserPreferences().currentBalance/UserPreferences().monthBalance)*2*pi), false, paint);

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

class Category{
  Category(this.name, {@required this.amount});

  final String name;
  final double amount;
}

final kCategories = [
  Category('groceries', amount: 500.0),
  Category('online shopping', amount: 150.0),
  Category('food', amount: 90.0),
  Category('bills', amount: 90.0),
  Category('subscriptions', amount: 40.0),
  Category('fees', amount: 20.0),
];

final kNeumorphicColors = [
  Color.fromRGBO(82, 98, 255, 1),
  Color.fromRGBO(46, 198, 255, 1),
  Color.fromRGBO(123, 201, 82, 1),
  Color.fromRGBO(255, 171, 67, 1),
  Color.fromRGBO(252, 91, 57, 1),
  Color.fromRGBO(139, 135, 130, 1),
];

class ExpenseWidget extends StatelessWidget {
  const ExpenseWidget({Key key, this.title, this.color}):super(key: key);

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
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: this.color
            ),
          ),
          SizedBox(width: 20,),
          Text(this.title.capitalize()),

        ],
      ),
    );
  }
}

extension StringExtension on String{
  String capitalize() => "${this[0].toUpperCase()}${this.substring(1)}";

}
