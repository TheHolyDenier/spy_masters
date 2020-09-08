import 'package:flutter/material.dart';

class Palette {
  static final primaryWatch = _createMaterialColor(Color(0xFF59C3C3));
  static final accentColor = Color(0xFFc37359);
  static final blueTeam = Color(0xFF0F5C78);
  static final redTeam = Color(0xFF8F0D0D);
  static final killer = Color(0xFF353327);
  static final neutral = Color(0xFFC7B784);
  static final background = Color(0xFFCA5237);
  static final white = Color(0xFFE1DFD7);


  static MaterialColor _createMaterialColor(Color color) {
    List strengths = <double>[.05];
    Map swatch = <int, Color>{};
    final int r = color.red, g = color.green, b = color.blue;

    for (int i = 1; i < 10; i++) {
      strengths.add(0.1 * i);
    }
    strengths.forEach((strength) {
      final double ds = 0.5 - strength;
      swatch[(strength * 1000).round()] = Color.fromRGBO(
        r + ((ds < 0 ? r : (255 - r)) * ds).round(),
        g + ((ds < 0 ? g : (255 - g)) * ds).round(),
        b + ((ds < 0 ? b : (255 - b)) * ds).round(),
        1,
      );
    });
    return MaterialColor(color.value, swatch);
  }
}
