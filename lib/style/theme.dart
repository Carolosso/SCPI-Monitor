import 'package:flutter/material.dart';

class Styles {
  static bool isDarkTheme = false;
  //TODO DARK THEME
  static Color get primaryColor =>
      isDarkTheme ? Colors.black : const Color.fromRGBO(17, 46, 50, 1);
  static Color get surfaceColor =>
      isDarkTheme ? Colors.white : const Color.fromRGBO(58, 241, 195, 1);

  static Color get backgroundColor => isDarkTheme ? Colors.black : Colors.white;

  static Color get channel1BorderColor =>
      const Color.fromRGBO(252, 248, 137, 1);
  static Color get channel1BackgroundColor =>
      const Color.fromRGBO(26, 24, 11, 1);

  static Color get channel2BorderColor => const Color.fromRGBO(48, 187, 46, 1);
  static Color get channel2BackgroundColor =>
      const Color.fromRGBO(4, 49, 18, 1);
  static Color get channel3BorderColor => const Color.fromRGBO(88, 192, 249, 1);
  static Color get channel3BackgroundColor =>
      const Color.fromRGBO(7, 27, 97, 1);

  static Color get channel4BorderColor => const Color.fromRGBO(181, 52, 46, 1);
  static Color get channel4BackgroundColor =>
      const Color.fromRGBO(57, 16, 15, 1);
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
