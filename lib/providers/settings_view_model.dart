import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  int timeout = 1000;

  String setNewTimeout(int newTimeout) {
    if (newTimeout > 300 && newTimeout < 10000) {
      timeout = newTimeout;
      // print(timeout.toString());
      notifyListeners();
      return "Ustawiono nową wartość na $newTimeout ms";
    }
    return "Wartość musi byc w przedziale od 500 do 10 000 ms";
  }
}
