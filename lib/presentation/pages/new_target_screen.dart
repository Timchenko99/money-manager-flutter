import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager_simple/presentation/widgets/BottomWideButton.dart';

import './home_screen.dart';
import '../../core/styles.dart';

class NewTarget extends StatefulWidget {
  static const routeName = "/new-target";

  @override
  _NewTargetState createState() => _NewTargetState();
}

class _NewTargetState extends State<NewTarget> {
  PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
          decoration: BoxDecoration(
            gradient: Styles.backgroundGradient
          ),
          child: PageView(
            controller: _pageController,
            physics: NeverScrollableScrollPhysics(),
            children: [
              NewTargetName(_pageController),
              NewTargetAmount(_pageController),
              NewTargetDailyBudget(_pageController)
            ],
          ),
        ),
      ),
    );
  }
}

class NewTargetName extends StatelessWidget {

  final PageController _pageController;

  NewTargetName(this._pageController);


  void _navigateToNext(){
    //TODO: save data to prefs
    _pageController.animateToPage(1, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text("New Target", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 36.0),),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("What are you saving for?", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 24.0),),
            TextField(
              onSubmitted: (_)=>_navigateToNext(),

            )
          ],
        ),
        FlatButton(
          onPressed: _navigateToNext,
          child: Text("Confirm", style: GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 24.0, color: Color(0xFF8769FF)),),
        )
      ],
    );
  }
}

class NewTargetAmount extends StatelessWidget {
  final PageController _pageController;


  NewTargetAmount(this._pageController);


  @override
  Widget build(BuildContext context) {

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => _pageController.animateToPage(0, duration: Duration(milliseconds: 250), curve: Curves.easeInOut),
                icon: Icon(Icons.arrow_back, size: 36.0, color: Theme.of(context).primaryColor)
            ),
            Center(child: Text("New Target", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 36.0),)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("What is your targeted amount?", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 20.0),),
            //TODO: pass slider value?
            TargetAndAmount(),
          ],
        ),
        FlatButton(
          //TODO: save data to prefs and show home screen
          onPressed: () => _pageController.animateToPage(2, duration: Duration(milliseconds: 250), curve: Curves.easeInOut),
          child: Text("Confirm", style: GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 24.0, color: Color(0xFF8769FF)),),
        )
      ],
    );
  }
}

class TargetAndAmount extends StatefulWidget {
  @override
  _TargetAndAmountState createState() => _TargetAndAmountState();
}

class _TargetAndAmountState extends State<TargetAndAmount> {
  double _currentSliderValue = 10000;

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        SizedBox(
          height: mediaQuery.size.height * 0.04,
        ),
        Text("Car Upgrade", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20.0),),
        SizedBox(
          height: mediaQuery.size.height * 0.02,
        ),
        Text("${NumberFormat.simpleCurrency().format(_currentSliderValue)}", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 36.0),),
        Slider(
          activeColor: Theme.of(context).primaryColor,
          value: _currentSliderValue,
          min: 1000,
          max: 100000,
          onChanged: (double value){
            setState(() {
              _currentSliderValue = value;
            });
          },
        )
      ],
    );
  }
}


class NewTargetDailyBudget extends StatelessWidget {

  final PageController _pageController;

  NewTargetDailyBudget(this._pageController);


  void _navigateToNext(BuildContext context){
    //TODO: save data to prefs
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            IconButton(
                onPressed: () => _pageController.animateToPage(1, duration: Duration(milliseconds: 250), curve: Curves.easeInOut),
                icon: Icon(Icons.arrow_back, size: 36.0, color: Theme.of(context).primaryColor)
            ),
            Center(child: Text("New Target", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 36.0),)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("What is your daily budget?", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 24.0),),
            TextField(
              onSubmitted: (_)=>_navigateToNext(context),

            )
          ],
        ),
        BottomWideButton(
          title: "Set My Goal",
          onPressed: ()=>_navigateToNext(context),
        )
      ],
    );
  }
}
