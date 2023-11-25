import 'package:flutter/material.dart';

class Styles {
  static bool isDarkTheme = false;
  //TODO DARK THEME
  static Color get primaryColor =>
      isDarkTheme ? Colors.black : const Color.fromRGBO(17, 46, 50, 1);
  static Color get surfaceColor =>
      isDarkTheme ? Colors.white : const Color.fromRGBO(58, 241, 195, 1);

  static Color get backgroundColor => isDarkTheme ? Colors.black : Colors.white;
  static double globalRadius = 20;
  static ThemeData themeData() {
    return ThemeData(
      //scaffoldBackgroundColor: Colors.black,
      //useMaterial3: true,
      colorScheme: isDarkTheme
          ? const ColorScheme.dark()
          : ColorScheme.light(
              primary: primaryColor, background: backgroundColor),
    );
  }
}
