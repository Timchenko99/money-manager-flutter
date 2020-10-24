import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../data/DBHelper.dart';
import '../data/UserPreferences.dart';
import '../model/UserTransaction.dart';

import './add_screen.dart';
import './settings_screen.dart';

class OverviewScreen extends StatelessWidget {
  static const routeName = "/overview";

  @override
  Widget build(BuildContext context) {
    // print("FATHER");
    final theme = Theme.of(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              OverviewBar(),
              SizedBox(height: 35),
              Text("Last Transactions", style: theme.textTheme.headline6),
              // DailyMonthlyToggle(),
              SizedBox(height: 20),
              BarChart(),
              SizedBox(height: 40),
              BottomBar()
            ],
          ),
        ),
      ),
    );
  }
}

class BottomBarGoal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          "Current Goal",
          style: TextStyle(fontSize: 14),
        ),
        const SizedBox(height: 4),
        Consumer<UserPreferences>(
          builder: (ctx, prefs, child) {
            return Text("${prefs.goal}",
                style: GoogleFonts.roboto(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(90, 90, 90, 1)));
          },
        )
      ],
    );
  }
}

class BottomBarTarget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const Text(
          "Target Amount",
          style: TextStyle(fontSize: 14),
        ),
        SizedBox(height: 4),
        Consumer<UserPreferences>(
          builder: (ctx, prefs, child) {
            return Text(
                NumberFormat.compactCurrency(symbol: '\$')
                    .format(prefs.targetAmount),
                style: GoogleFonts.rubik(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(90, 90, 90, 1)));
          },
        )
      ],
    );
  }
}

class NeumorphicFAB extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      theme: NeumorphicThemeData(),
      child: NeumorphicButton(
        key: UniqueKey(),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddScreen()));
        },
        style: NeumorphicStyle(
            shape: NeumorphicShape.concave,
            intensity: 0.8,
            color: Theme.of(context).accentColor,
            boxShape: NeumorphicBoxShape.circle()),
        child: Icon(
          Icons.add,
          size: 40,
          color: Colors.black.withOpacity(0.6),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 340,
      height: 72,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [BottomBarGoal(), NeumorphicFAB(), BottomBarTarget()],
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  static const Map<int, String> intToWeekday = {
    1: "Mon",
    2: "Tue",
    3: "Wed",
    4: "Thu",
    5: "Fri",
    6: "Sat",
    7: "Sun"
  };

  @override
  Widget build(BuildContext context) {
    final UserPreferences prefs = Provider.of<UserPreferences>(context);
    final weekTransactions =
        Provider.of<DBHelper>(context).getWeekTransactions();

    return FutureBuilder(
      future: weekTransactions,
      builder: (ctx, snapshot) {
        // showDialog(
        //   context: context,
        //   builder: (_) => AlertDialog(
        //     title: Text("Congratulations!"),
        //     content: Text("You have reached your goal! Create new?"),
        //     actions: [
        //       FlatButton(
        //         child: Text("No"),
        //         onPressed: ()=>print("No")
        //       ),
        //       FlatButton(
        //         child: Text("Yes"),
        //         onPressed: ()=>print("Yes"),
        //       )
        //     ],
        //   ),
        //   barrierDismissible: false
        // );
        final data = snapshot.data as List;
        // print(DateTime(2020, 9, -1));

        List<Widget> neumorphicBars = [];

        if (data != null && data.isNotEmpty) {
          if (data.length < 7) {
            for (int i = (7 - data.length);
                neumorphicBars.length < (7 - data.length);
                i--) {
              print(
                  "i: $i, bars.length: ${neumorphicBars.length}, oldestTransaction: ${data.last.day}, oldestTransaction: ${data.last.amount}, oldestRatio:${data.last.amount.abs() / prefs.dailyBudget},lastTransaction: ${data.first.day}, lastTransactionAmount: ${data.first.amount}, lastRatio:${data.first.amount.abs() / prefs.dailyBudget}");
              UserTransaction lastTransaction = data.last;
              DateTime _temp = DateTime(lastTransaction.year,
                  lastTransaction.month, lastTransaction.day - i);
              neumorphicBars.add(NeumorphicBar(
                  width: 70,
                  height: 200,
                  value: 0,
                  text: intToWeekday[_temp.weekday]));
            }
          }

          neumorphicBars.addAll(data.reversed.map<Widget>(
            (v) => NeumorphicBar(
                width: 70,
                height: 200,
                value: v.amount.abs() / prefs.dailyBudget,
                text: "${intToWeekday[v.weekday]}"),
          ));
        } else
          neumorphicBars = _buildDefaultBars();

        return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: neumorphicBars);
      },
    );
  }

  List<Widget> _buildDefaultBars() {
    return const [
      const NeumorphicBar(width: 70, height: 200, value: 0.5, text: "Mon"),
      const NeumorphicBar(width: 70, height: 200, value: 0.1, text: "Tue"),
      const NeumorphicBar(width: 70, height: 200, value: 0.9, text: "Wed"),
      const NeumorphicBar(width: 70, height: 200, value: 0.2, text: "Thu"),
      const NeumorphicBar(width: 70, height: 200, value: 0.4, text: "Fri"),
      const NeumorphicBar(width: 70, height: 200, value: 0.5, text: "Sat"),
      const NeumorphicBar(width: 70, height: 200, value: 0.6, text: "Sun")
    ];
  }
}

class OverviewBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Neumorphic(
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat,
            color: Theme.of(context).backgroundColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          width: 340,
          height: 200,
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text("Total Amount Saved",
                      style: Theme.of(context).textTheme.subtitle2),
                  SizedBox(height: 10),
                  SavedTotal(),
                  SizedBox(height: 25),
                  SavedPercent(),
                ],
              ),
              Positioned(right: 0, top: 60, child: SettingsButton())
            ],
          ),
        ),
      ),
    );
  }
}

class DailyMonthlyToggle extends StatefulWidget {
  @override
  _DailyMonthlyToggleState createState() => _DailyMonthlyToggleState();
}

class _DailyMonthlyToggleState extends State<DailyMonthlyToggle> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return NeumorphicToggle(
      height: 50,
      width: 340,
      selectedIndex: _selectedIndex,
      onChanged: (v) {
        setState(() {
          _selectedIndex = v;
        });
      },
      displayForegroundOnlyIfSelected: true,
      style: NeumorphicToggleStyle(
        backgroundColor: const Color.fromRGBO(208, 218, 227, 1),
      ),
      children: [
        ToggleElement(
            background: Center(
                child: Text("This Week",
                    style: Theme.of(context).textTheme.bodyText1)),
            foreground: Center(
                child: Text("This Week",
                    style: Theme.of(context).textTheme.bodyText1))),
        ToggleElement(
            background: Center(
                child: Text("This Month",
                    style: Theme.of(context).textTheme.bodyText1)),
            foreground: Center(
                child: Text("This Month",
                    style: Theme.of(context).textTheme.bodyText1)))
      ],
      thumb: Neumorphic(
        style: NeumorphicStyle(
            color: Theme.of(context).backgroundColor,
            boxShape: NeumorphicBoxShape.roundRect(
                BorderRadius.all(Radius.circular(15))),
            shape: NeumorphicShape.flat),
      ),
    );
  }
}

class SettingsButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NeumorphicTheme(
      child: NeumorphicButton(
        style: NeumorphicStyle(
            shape: NeumorphicShape.flat, boxShape: NeumorphicBoxShape.circle()
            // boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))
            ),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SettingsScreen()));
        },
        child: const Icon(
          Icons.settings,
          size: 28,
          color: Color.fromRGBO(90, 90, 90, 1),
        ),
      ),
    );
  }
}

class SavedPercent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferences>(context);
    final sumByDay = Provider.of<DBHelper>(context).getSumByDay();

    print("GERALD");
    return FutureBuilder(
      future: sumByDay,
      builder: (ctx, snapshot) {
        final data = snapshot.data;
        num temp = (data?.fold(0,
                    (prev, elem) => prev + (prefs.dailyBudget + elem.amount)) ??
                0) /
            prefs.targetAmount;
        String formattedText = NumberFormat("##0.0%").format(temp);
        return Text("You have reached $formattedText of your goal");
      },
    );
  }
}

class SavedTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final prefs = Provider.of<UserPreferences>(context);
    final sumByDay = Provider.of<DBHelper>(context).getSumByDay();

    print("GERALD");
    return StreamBuilder(
      stream: sumByDay.asStream(),
      builder: (ctx, snapshot) {
        final data = snapshot.data;
        //print(snapshot.data[0].amount);

        num temp = data?.fold(
                0, (prev, elem) => prev + (prefs.dailyBudget + elem.amount)) ??
            0;
        // return Text("\$62 000 000", style: Theme.of(context).textTheme.headline5,);
        return Text(NumberFormat.currency(symbol: "\$").format(temp),
            style: Theme.of(context).textTheme.headline5);
      },
    );
  }
}

class NeumorphicBar extends StatelessWidget {
  const NeumorphicBar({
    Key key,
    @required this.width,
    @required this.height,
    @required this.value,
    @required this.text,
    this.color,
  }) : super(key: key);

  final double width;
  final double height;

  /// Value from 1.0 to 0.0
  final double value;

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final innerContainerWidth = width * 0.2;
    final innerContainerHeight = height * value * 0.96;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 15),
          // color: Colors.pinkAccent,
          height: height * 1.01,
          width: width.toDouble() / 4,
          child: Stack(
            children: <Widget>[
              DugContainer(
                width: width,
                height: height,
              ),
              InnerContainer(
                  width: innerContainerWidth,
                  height: innerContainerHeight,
                  color: color),
            ],
          ),
        ),
        SizedBox(height: 10),
        Text(
          text,
          style: TextStyle(
            color: Colors.blueGrey[300],
          ),
        ),
      ],
    );
  }
}

class InnerContainer extends StatelessWidget {
  const InnerContainer({
    Key key,
    @required this.height,
    @required this.width,
    this.color,
  }) : super(key: key);

  final double height;
  final double width;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0),
        child: Neumorphic(
          style: NeumorphicStyle(
              color: color ?? Theme.of(context).accentColor,
              shape: NeumorphicShape.flat),
          child: Container(
            height: height * 1.02,
            width: width,
          ),
        ),
      ),
    );
  }
}

class DugContainer extends StatelessWidget {
  const DugContainer({
    Key key,
    @required this.height,
    @required this.width,
  }) : super(key: key);
  final double height;
  final double width;
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Neumorphic(
        style: NeumorphicStyle(depth: -5, color: Colors.grey.withOpacity(0.1)),
        child: Container(
          height: height /** 600 / 896*/,
          width: width /** 100 / 414*/,
        ),
      ),
    );
  }
}
