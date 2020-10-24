import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomWideButton extends StatelessWidget {
  final Function onPressed;


  BottomWideButton({this.onPressed});

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
      minWidth: double.infinity,
      height: 44,
      child: RaisedButton(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        color: Theme.of(context).primaryColor,
        onPressed: onPressed,
        child: Text(
          "Start",
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
