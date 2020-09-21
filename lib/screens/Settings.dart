import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager_simple/data/UserPreferences.dart';
import 'package:provider/provider.dart';


class Settings extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return  ChangeNotifierProvider.value(
      value: UserPreferences(),
      child: Scaffold(
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
                  FormSection(),

                ],
              )
            )
          ),
        ),
    );
  }

}

class NeumorphicTF extends StatelessWidget {
  final TextEditingController _textController;
  final String _hintText;

  NeumorphicTF(this._textController, this._hintText);

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          color: Color.fromRGBO(208, 218, 227, 1),
          depth: -3,
          intensity: 1
      ),
      child: Container(
        width: 360,
        child: TextFormField(
          controller: _textController,
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
              hintText: _hintText,
              hintStyle: GoogleFonts.roboto(
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.italic,
                  fontSize: 18.0,
                  color: Color.fromRGBO(0, 0, 0, 0.20))),
          style: GoogleFonts.roboto(
              fontSize: 18.0, color: Color.fromRGBO(0, 0, 0, 0.7)),
        ),
      ),
    );
  }
}


class FormSection extends StatefulWidget {
  @override
  _FormSectionState createState() => _FormSectionState();
}

class _FormSectionState extends State<FormSection> {
  final _formKey = GlobalKey<FormState>();

  final _dailyBudgetTextController = TextEditingController();

  final _goalTextController = TextEditingController();

  final _targetAmountTextController = TextEditingController();


  @override
  void initState() {
    super.initState();
    _goalTextController.text = UserPreferences().goal ?? "";
    _targetAmountTextController.text = UserPreferences().targetAmount.toString() ?? "";
    _dailyBudgetTextController.text = UserPreferences().dailyBudget.toString() ?? "";
  }

  @override
  Widget build(BuildContext context) {
    return  Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Daily Budget", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),),
          SizedBox(height: 10),
          NeumorphicTF(_dailyBudgetTextController, "Daily Budget"),
          SizedBox(height: 27),
          Text("Goal", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),),
          SizedBox(height: 10),

          NeumorphicTF(_goalTextController, "Goal"),
          SizedBox(height: 27),
          Text("Target Amount", style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),),
          SizedBox(height: 10),

         NeumorphicTF(_targetAmountTextController, "Target Amount"),
          SizedBox(height: 35),
          Center(
              child: SubmitButton(_formKey, _dailyBudgetTextController, _goalTextController, _targetAmountTextController)
          )
        ],
      ),
    );
  }
}


class SubmitButton extends StatelessWidget {
  final GlobalKey<FormState> _formKey;
  final TextEditingController _dailyBudgetTextController;
  final TextEditingController _goalTextController;
  final TextEditingController _targetAmountTextController;


  SubmitButton(this._formKey, this._dailyBudgetTextController,
      this._goalTextController, this._targetAmountTextController);

  @override
  Widget build(BuildContext context) {
    return Consumer<UserPreferences>(

      builder:(ctx, prefs, child) => NeumorphicTheme(
          theme: NeumorphicThemeData(),
          child: NeumorphicButton(

            onPressed: () {
              FocusScope.of(context).requestFocus(FocusNode());
              if (_formKey.currentState.validate()) {

                prefs.dailyBudget = int.parse(_dailyBudgetTextController.text.replaceAll(" ", "").trim());
                prefs.goal = _goalTextController.text.toString();
                prefs.targetAmount = int.parse(_targetAmountTextController.text.replaceAll(" ", "").trim());


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
    );
  }
}


