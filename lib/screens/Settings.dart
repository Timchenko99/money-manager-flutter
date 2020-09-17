import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final _formKey = GlobalKey<FormState>();

  final _goalTextController = TextEditingController();
  final _targetAmountTextController = TextEditingController();
  final _dailyBudgetTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
    if(UserPreferences().isFirstBoot){

      UserPreferences().isFirstBoot = false;
    }else{

      _goalTextController.text = UserPreferences().goal;
      _targetAmountTextController.text = UserPreferences().targetAmount.toString();
      _dailyBudgetTextController.text = UserPreferences().dailyBudget.toString();
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,

      body: SafeArea(

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              Text("Settings", style: Theme.of(context).textTheme.headline4),
              SizedBox(height: 44),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Daily Budget", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),),
                    SizedBox(height: 10),
                    Neumorphic(
                      style: NeumorphicStyle(
                          color: Color.fromRGBO(208, 218, 227, 1),
                          depth: -3,
                          intensity: 1
                      ),
                      child: Container(
                        width: 360,
                        child: TextFormField(
                          controller: _dailyBudgetTextController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"(\.|,|-)"))
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Daily Budget",
                              hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.20))),
                          style: GoogleFonts.roboto(
                              fontSize: 18.0, color: Color.fromRGBO(0, 0, 0, 0.7)),
                        ),
                      ),
                    ),
                    SizedBox(height: 27),
                    Text("Goal", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),),
                    SizedBox(height: 10),

                    Neumorphic(

                      style: NeumorphicStyle(
                          color: Color.fromRGBO(208, 218, 227, 1),
                          depth: -3,
                          intensity: 1
                      ),
                      child: Container(
                        width: 360,
                        child: TextFormField(
                          controller: _goalTextController,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Goal",
                              hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.20))),
                          style: GoogleFonts.roboto(
                              fontSize: 18.0, color: Color.fromRGBO(0, 0, 0, 0.7)),
                        ),
                      ),
                    ),
                    SizedBox(height: 27),
                    Text("Target Amount", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),),
                    SizedBox(height: 10),

                    Neumorphic(

                      style: NeumorphicStyle(
                          color: Color.fromRGBO(208, 218, 227, 1),
                          depth: -3,
                          intensity: 1
                      ),
                      child: Container(
                        width: 360,
                        child: TextFormField(
                          controller: _targetAmountTextController,
                          inputFormatters: [
                            FilteringTextInputFormatter.deny(RegExp(r"(\.|,|-)"))
                          ],
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter some text';
                            }
                            return null;
                          },
                          textAlign: TextAlign.center,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Target Amount",
                              hintStyle: GoogleFonts.roboto(
                                  fontWeight: FontWeight.bold,
                                  fontStyle: FontStyle.italic,
                                  fontSize: 18.0,
                                  color: Color.fromRGBO(0, 0, 0, 0.20))),
                          style: GoogleFonts.roboto(
                              fontSize: 18.0, color: Color.fromRGBO(0, 0, 0, 0.7)),
                        ),
                      ),
                    ),
                    SizedBox(height: 35),
                Center(
                  child: NeumorphicTheme(
                      theme: NeumorphicThemeData(),
                      child: NeumorphicButton(

                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formKey.currentState.validate()) {

                            UserPreferences().dailyBudget = int.parse(_dailyBudgetTextController.text.replaceAll(" ", "").trim());
                            UserPreferences().goal = _goalTextController.text.toString();
                            UserPreferences().targetAmount = int.parse(_targetAmountTextController.text.replaceAll(" ", "").trim());


                            Navigator.pop(context);
                          }
                        },

                        style: NeumorphicStyle(
                            color: Theme.of(context).accentColor,
                            shape: NeumorphicShape.flat,
                            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.elliptical(50, 50)))
                        ),
                        child: Container(
                            width: 120,
                            height: 70,
                            child: Center(child: Icon(Icons.check, size: 60, color: Color.fromRGBO(116, 116, 116, 1)))),
                      )
                  ),
                )
                  ],
                ),
              )

            ],
          )
        )
      ),
    );
  }

  Widget _buildGoal(){
    return Neumorphic();
  }
}

