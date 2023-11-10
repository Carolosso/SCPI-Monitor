import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';
import 'package:test/utils/validators.dart';

class SettingsViewModel extends ChangeNotifier {
  int timeout = 100;
  String ipRange = "";
  String broadcast = "";
  bool isDarkTheme = false;

  bool get darkTheme => isDarkTheme;

  set darkTheme(bool value) {
    isDarkTheme = value;
    notifyListeners();
  }

  String get getBroadcast => broadcast;
  String get getIPRange => ipRange;

  String setNewTimeout(String newTimeout) {
    try {
      int newTO = int.parse(newTimeout);
      int sRange = 0;
      int eRange = 10000;
      if (newTO >= sRange && newTO <= eRange) {
        timeout = newTO;
        // print(timeout.toString());
        notifyListeners();
        return "Ustawiono nową wartość na $newTimeout ms";
      }
      return "Wartość musi byc w przedziale od $sRange do $eRange ms";
    } catch (ex) {
      return "Liczba musi mieć postać całkowitą";
    }
  }

  String setNewIpRange(String newRange) {
    if (newRange.isNotEmpty && isValidHost(newRange)) {
      ipRange = newRange;
      notifyListeners();
      return "Ustawiono nową wartość na $newRange";
    } else {
      return "Błąd";
    }
  }

  void switchTheme() {
    Styles.isDarkTheme = !Styles.isDarkTheme;
    notifyListeners();
  }
}
