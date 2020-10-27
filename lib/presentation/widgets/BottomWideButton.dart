import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomWideButton extends StatelessWidget {
  final Function onPressed;
  final String title;


  BottomWideButton({@required this.onPressed, @required this.title});

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
          title,
          style: GoogleFonts.roboto(
              fontWeight: FontWeight.w300, fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
