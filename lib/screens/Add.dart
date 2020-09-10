import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../data/UserPreferences.dart';
import '../л.dart';

class Add extends StatefulWidget {
  @override
  _AddState createState() => _AddState();
}

class _AddState extends State<Add> {
  final AmountTextController = TextEditingController();
  int _selectedIndex = 0;

  @override
  void dispose() {
    AmountTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).backgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            // Padding(
            //   padding: const EdgeInsets.only(top: 20.0, left: 20.0),
            //   child: Row(
            //     children: [
            //       Container(
            //         width: 56,
            //         height: 31,
            //         decoration: BoxDecoration(
            //             borderRadius: BorderRadius.circular(15),
            //             color: Color.fromRGBO(193, 214, 233, 1),
            //             boxShadow: [
            //               BoxShadow(
            //                   spreadRadius: -2,
            //                   blurRadius: 8,
            //                   offset: Offset(-4, -4),
            //                   color: Colors.white),
            //               BoxShadow(
            //                   spreadRadius: 1,
            //                   blurRadius: 10,
            //                   offset: Offset(4, 4),
            //                   color: Color.fromRGBO(146, 182, 216, 1))
            //             ]),
            //         child: Material(
            //
            //           color: Color.fromRGBO(193, 214, 233, 1),
            //           borderRadius: BorderRadius.circular(15),
            //           child: InkWell(
            //             splashColor: Color.fromRGBO(193,214,233,1),
            //             borderRadius: BorderRadius.circular(15),
            //             onTap: ()=> Navigator.pop(context),
            //             child: Icon(
            //               Icons.keyboard_arrow_left,
            //               size: 30,
            //               color: Colors.black.withOpacity(0.4),
            //             ),
            //           ),
            //         )
            //       ),
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 25.0,
            ),
            Center(
              child: Text(
                _selectedIndex==0 ? "New Expenses":"New Income",
                style: Theme.of(context).textTheme.headline4
              ),
            ),
            SizedBox(
              height: 20,
            ),
            _buildNeumorphicToggle(),
            // Container(
            //   width: 310,
            //   height: 52,
            //   decoration: BoxDecoration(
            //       borderRadius: BorderRadius.circular(15),
            //       color: Color.fromRGBO(193, 214, 233, 1),
            //       boxShadow: [
            //         BoxShadow(
            //             spreadRadius: -2,
            //             blurRadius: 8,
            //             offset: Offset(-4, -4),
            //             color: Colors.white),
            //         BoxShadow(
            //             spreadRadius: 1,
            //             blurRadius: 10,
            //             offset: Offset(4, 4),
            //             color: Color.fromRGBO(146, 182, 216, 1))
            //       ]),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceAround,
            //     children: [
            //       Text(
            //         "Expenses",
            //         style: GoogleFonts.roboto(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 18.0,
            //             color: Color.fromRGBO(156, 163, 170, 1)),
            //       ),
            //       Text(
            //         "Income",
            //         style: GoogleFonts.roboto(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 18.0,
            //             color: Color.fromRGBO(156, 163, 170, 1)),
            //       )
            //     ],
            //   ),
            // ),
            SizedBox(
              height: 50,
            ),
            // Stack(
            //   children: [
            //     Align(
            //       alignment: Alignment.center,
            //       child: Container(
            //         width: 350,
            //         height: 51,
            //         decoration: ConcaveDecoration(
            //             shape: RoundedRectangleBorder(
            //                 borderRadius: BorderRadius.circular(15)),
            //             colors: [Colors.white, Colors.black],
            //             depth: 3,
            //             opacity: 0.7),
            //       ),
            //     ),
            //     Align(
            //       alignment: Alignment.center,
            //       child: Container(
            //         width: 300,
            //         height: 51,
            //         child: TextField(
            //           textAlign: TextAlign.center,
            //           controller: AmountTextController,
            //           keyboardType: TextInputType.number,
            //           decoration: InputDecoration(
            //               border: InputBorder.none,
            //               hintText: "Amount",
            //               hintStyle: GoogleFonts.roboto(
            //                   fontStyle: FontStyle.italic,
            //                   fontSize: 18.0,
            //                   color: Color.fromRGBO(0, 0, 0, 0.25))),
            //           style: GoogleFonts.roboto(
            //               fontSize: 18.0, color: Color.fromRGBO(0, 0, 0, 0.7)),
            //         ),
            //       ),
            //     )
            //   ],
            // ),
            _buildNeumorphicTextField(),
            SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildIncrementButton(5),
                _buildIncrementButton(25),
                _buildIncrementButton(50),
                _buildIncrementButton(100)
              ],
            ),
            SizedBox(
              height: 50,
            ),
            // CircleApplyButton(),
            _buildCircleSubmitButton()
          ],
        ),
      ),
    );
  }

  Widget _buildCircleSubmitButton(){
    return NeumorphicTheme(
        theme: NeumorphicThemeData(),
        child: NeumorphicButton(

          onPressed: (){
            FocusScope.of(context).requestFocus(FocusNode());

            int currentBalance = UserPreferences().currentBalance;
            int result = 0;

            if(_selectedIndex == 0){
              result = currentBalance - int.parse(AmountTextController.text);
            }else{
              result = currentBalance + int.parse(AmountTextController.text);
            }
            print("Result: $result");
            UserPreferences().currentBalance = result;
            Navigator.pop(context);
          },
          
          style: NeumorphicStyle(
              color: Theme.of(context).backgroundColor,
              shape: NeumorphicShape.flat,
              boxShape: NeumorphicBoxShape.circle()
          ),
          child: Container(
              width: 253,
              height: 253,
              child: Icon(Icons.check, size: 80, color: Color.fromRGBO(116, 116, 116, 1))),
        )
    );
  }

  Widget _buildIncrementButton(int amount){
    return NeumorphicTheme(
      theme: NeumorphicThemeData(),
        child: NeumorphicButton(
          style: NeumorphicStyle(
            color: Theme.of(context).backgroundColor,
            shape: NeumorphicShape.flat,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15))
          ),
          onPressed: ()=>_incrementAmountBy(amount),
          child: Center(
            child: Text("$amount\$", style: Theme.of(context).textTheme.button),
          ),
        )
    );
    //  Container(
    //   width: 70,
    //   height: 40,
    //   decoration: BoxDecoration(
    //       borderRadius: BorderRadius.circular(15),
    //       color: Theme.of(context).backgroundColor,
    //       boxShadow: [
    //         BoxShadow(
    //             spreadRadius: -2,
    //             blurRadius: 8,
    //             offset: Offset(-4, -4),
    //             color: Colors.white),
    //         BoxShadow(
    //             spreadRadius: -1,
    //             blurRadius: 13,
    //             offset: Offset(4, 4),
    //             color: Color.fromRGBO(146, 182, 216, 1))
    //       ]),
    //   child: FlatButton(
    //     splashColor: Colors.pinkAccent.withOpacity(0.5),
    //     shape: RoundedRectangleBorder(
    //         borderRadius: BorderRadius.circular(15)),
    //     child: Text("$amount\$", style: Theme.of(context).textTheme.button ),
    //     onPressed: () => _incrementAmountBy(amount),
    //   ),
    // );
  }


  Widget _buildNeumorphicTextField(){
    return Neumorphic(

      style: NeumorphicStyle(
        color: Color.fromRGBO(208, 218, 227, 1),
          depth: -3,
          intensity: 1
      ),
      child: Container(
        width: 360,
        child: TextField(
          inputFormatters: [
            FilteringTextInputFormatter.deny(RegExp(r"(\.|,|-)"))
          ],
          onSubmitted: (v){
            FocusScope.of(context).requestFocus(FocusNode());
          },
          textAlign: TextAlign.center,
          controller: AmountTextController,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Amount",
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

  Widget _buildNeumorphicToggle(){
    return NeumorphicToggle(
      height: 50,
      width: 310,
      selectedIndex: _selectedIndex,
      displayForegroundOnlyIfSelected: true,
      style: NeumorphicToggleStyle(
        backgroundColor: Color.fromRGBO(208, 218, 227, 1),
      ),
      children: [
        ToggleElement(background: Center(child: Text("Expenses", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("Expenses", style: Theme.of(context).textTheme.bodyText1))),
        ToggleElement(background: Center(child: Text("Income", style: Theme.of(context).textTheme.bodyText1 )), foreground: Center(child: Text("Income", style: Theme.of(context).textTheme.bodyText1)))
      ],
      thumb: Neumorphic(
        style: NeumorphicStyle(
            color: Theme.of(context).backgroundColor,
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.all(Radius.circular(15)))
        ),
      ),
      onChanged: (v){
        setState(() {
          _selectedIndex = v;
        });
      },
    );
  }

  void _incrementAmountBy(int increment) {
    if (AmountTextController.text.isEmpty) AmountTextController.text = "0";

    int value = int.parse(AmountTextController.text
 ?? "0"
    );

    AmountTextController.text = (value + increment).toString();
  }
}

class CircleApplyButton extends StatefulWidget {
  @override
  _CircleApplyButtonState createState() => _CircleApplyButtonState();
}

class _CircleApplyButtonState extends State<CircleApplyButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return Listener(
      onPointerDown: (e) => setState((){
        isPressed = true;
      }),
      onPointerUp: (e) => setState(() {
        isPressed = false;
        Navigator.pop(context);
      }),
      child: Container(
        width: 253,
        height: 253,
        decoration: !isPressed
            ? BoxDecoration(

            color: Color.fromRGBO(193, 214, 233, 1),
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
            ])
            : ConcaveDecoration(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(200)),
            colors: [Colors.white, Colors.black],
            depth: 5,
            opacity: 0.7),
        child: Icon(
          Icons.check,
          size: 52,
          color: Colors.black.withOpacity(0.4),
        ),
      ),
    );
  }
}

