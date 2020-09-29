import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';
import 'package:moneymanager_simple/screens/Overview.dart';

class Start extends StatelessWidget {
  final TextEditingController _goalController = TextEditingController();
  final TextEditingController _targetedController = TextEditingController();
  final TextEditingController _dailyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    

    return Scaffold(
      backgroundColor: theme.backgroundColor,
      body: SafeArea(
        child:
          ListView(
            padding: EdgeInsets.symmetric(horizontal: 24),
            children: [
              SizedBox(height: 80),
              Center(child: Text("Finance App", style: theme.textTheme.headline4)),

              SizedBox(height: 80),
              TextField(

                controller: _goalController,
                decoration: InputDecoration(labelText: "Goal"),
              ),
              SizedBox(height: 12),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"(\.|,|-)"))
                ],
                keyboardType: TextInputType.number,
                controller: _dailyController,
                decoration: InputDecoration(labelText: "Daily Expenses"),
              ),
              SizedBox(height: 12),
              TextField(
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r"(\.|,|-)"))
                ],
                keyboardType: TextInputType.number,
                controller: _targetedController,
                decoration: InputDecoration(labelText: "Targeted Amount"),
              ),
              SizedBox(height: 25),
              ButtonBar(
                children: [
                  FlatButton(
                    child: Text("CLEAR"),
                    onPressed: () {
                      _goalController.clear();
                      _dailyController.clear();
                      _targetedController.clear();
                    },
                  ),
                  NeumorphicTheme(
                    child: NeumorphicButton(
                      child: Text("START", style: theme.textTheme.button,),
                      onPressed: () {
                        UserPreferences().targetAmount = int.parse(_targetedController.text);
                        UserPreferences().goal = _goalController.text;
                        UserPreferences().dailyBudget = int.parse(_dailyController.text);

                        UserPreferences().isFirstBoot = false;

                        Navigator.push(context, MaterialPageRoute(builder: (ctx)=>Overview()));
                      },
                    ),
                  )
                ],
              )
            ]
          ),
      ),
    );
  }
}
