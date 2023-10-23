import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles {
  static bool isDarkTheme = false;

  static Color get primaryColor =>
      isDarkTheme ? Colors.black : const Color.fromRGBO(17, 46, 50, 1);
  static Color get surfaceColor =>
      isDarkTheme ? Colors.white : const Color.fromRGBO(58, 241, 195, 1);

  static Color get backgroundColor =>
      isDarkTheme ? Colors.black : const Color.fromRGBO(255, 255, 255, 0);

  static ThemeData themeData(bool isDarkTheme, BuildContext context) {
    return ThemeData(
      //scaffoldBackgroundColor: Colors.black,
      //useMaterial3: true,
      colorScheme: const ColorScheme.light(),
      textTheme: TextTheme(
          titleLarge: GoogleFonts.inter(
        textStyle: const TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 24,
        ),
      )),
    );
  }
}
