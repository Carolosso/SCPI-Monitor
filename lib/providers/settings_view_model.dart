import 'package:flutter/material.dart';
import 'package:test/utils/validators.dart';

class SettingsViewModel extends ChangeNotifier {
  int timeout = 1000;
  String ipRange = "";
  String? broadcast = "";

  String setNewTimeout(String newTimeout) {
    int newTo = int.parse(newTimeout);
    if (newTo > 300 && newTo < 10000) {
      timeout = newTo;
      // print(timeout.toString());
      notifyListeners();
      return "Ustawiono nową wartość na $newTimeout ms";
    }
    return "Wartość musi byc w przedziale od 500 do 10 000 ms";
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
}
