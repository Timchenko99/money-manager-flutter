import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';
import 'package:moneymanager_simple/data/models/PreferenceModel.dart';
import 'package:moneymanager_simple/domain/entities/Preference.dart';
import 'package:moneymanager_simple/presentation/cubit/PreferenceCubit.dart';

import '../../presentation/widgets/BottomWideButton.dart';
import '../../core/styles.dart';
import './home_screen.dart';

class NewTarget extends StatefulWidget {
  static const routeName = "/new-target";

  @override
  _NewTargetState createState() => _NewTargetState();
}

class _NewTargetState extends State<NewTarget> {
  PageController _pageController;
  TextEditingController _targetController;
  TextEditingController _amountController;
  TextEditingController _budgetController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _targetController = TextEditingController();
    _amountController = TextEditingController();
    _budgetController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
    _targetController.dispose();
    _amountController.dispose();
    _budgetController.dispose();
  }

  void _navigateToNextPage(BuildContext context){
    UserPreferences()
    ..goal = _targetController.text
    ..dailyBudget = double.parse(_budgetController.text)
    ..targetAmount = double.parse(_amountController.text);
    // print("${_targetController.text} ${_amountController.text} ${_budgetController.text}");
    // final preference = PreferenceModel(
    //   isFirstBoot: false,
    //   goal: _targetController.text,
    //   dailyBudget: double.parse(_budgetController.text),
    //   targetedAmount: double.parse(_amountController.text),
    // );
    // context.bloc<PreferenceCubit>().writePreferences(preference);
    Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
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
              NewTargetName(_pageController, _targetController),
              NewTargetAmount(_pageController, _amountController),
              NewTargetDailyBudget(_pageController, _budgetController, _navigateToNextPage)
            ],
          ),
        ),
      ),
    );
  }
}

class NewTargetName extends StatelessWidget {

  final PageController _pageController;
  final TextEditingController _targetController;

  NewTargetName(this._pageController, this._targetController);


  void _navigateToNext(){
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
              controller: _targetController,
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

class NewTargetAmount extends StatefulWidget {
  final PageController _pageController;
  final TextEditingController _amountController;


  NewTargetAmount(this._pageController, this._amountController);

  @override
  _NewTargetAmountState createState() => _NewTargetAmountState();
}

class _NewTargetAmountState extends State<NewTargetAmount> {
  double _currentSliderValue = 1000;

  void _updateSliderValue(double value){
    setState(() {
      _currentSliderValue = value;
    });
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
                onPressed: () => widget._pageController.animateToPage(0, duration: Duration(milliseconds: 250), curve: Curves.easeInOut),
                icon: Icon(Icons.arrow_back, size: 36.0, color: Theme.of(context).primaryColor)
            ),
            Center(child: Text("New Target", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 36.0),)),
          ],
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("What is your targeted amount?", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 20.0),),
            TargetAndAmount(widget._amountController, _currentSliderValue, _updateSliderValue),
          ],
        ),
        FlatButton(
          onPressed: (){
              widget._pageController.animateToPage(2, duration: Duration(milliseconds: 250), curve: Curves.easeInOut);
              widget._amountController.text = _currentSliderValue.toString();
            },
          child: Text("Confirm", style: GoogleFonts.roboto(fontWeight: FontWeight.w300, fontSize: 24.0, color: Color(0xFF8769FF)),),
        )
      ],
    );
  }
}

class TargetAndAmount extends StatefulWidget {
  final TextEditingController _amountController;
  final double _currentSliderValue;
  final Function _sliderUpdated;

  TargetAndAmount(this._amountController, this._currentSliderValue, this._sliderUpdated);

  @override
  _TargetAndAmountState createState() => _TargetAndAmountState();
}

class _TargetAndAmountState extends State<TargetAndAmount> {

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);

    return Column(
      children: [
        /*SizedBox(
          height: mediaQuery.size.height * 0.04,
        ),
        Text("Car Upgrade", style: GoogleFonts.roboto(fontWeight: FontWeight.bold, fontSize: 20.0),),*/
        SizedBox(
          height: mediaQuery.size.height * 0.02,
        ),
        Text("${NumberFormat.simpleCurrency().format(widget._currentSliderValue)}", style: GoogleFonts.rubik(fontWeight: FontWeight.bold, fontSize: 36.0),),
        Slider(
          activeColor: Theme.of(context).primaryColor,
          value: widget._currentSliderValue,
          min: 1000,
          max: 100000,
          onChanged: widget._sliderUpdated
        )
      ],
    );
  }
}


class NewTargetDailyBudget extends StatelessWidget {

  final PageController _pageController;
  final TextEditingController _budgetController;
  final Function _navigateToNextPage;

  NewTargetDailyBudget(this._pageController, this._budgetController,
      this._navigateToNextPage);

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
              controller: _budgetController,
              onSubmitted: (_)=>_navigateToNextPage(context),

            )
          ],
        ),
        BottomWideButton(
          title: "Set My Goal",
          onPressed: ()=>_navigateToNextPage(context),
        )
      ],
    );
  }
}
