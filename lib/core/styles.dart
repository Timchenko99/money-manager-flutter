import 'package:flutter/material.dart';

class Styles{

  static final Shader textLinearGradient = LinearGradient(
    colors: <Color>[Color(0xFF644CC3), Color(0xFF002544)],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  static const Gradient backgroundGradient = const LinearGradient(
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
      colors: [
        Color(0xFFFFFFFF),
        Color(0xFFDAE3EB),
      ],
      stops: [
        0.2,
        1.0
      ]
  );

}