import 'package:flutter/material.dart';

class SettingsViewModel extends ChangeNotifier {
  int timeout = 1000;

  String ipRange = "192.168.0.1 do 192.168.0.10";

  String setNewTimeout(String newTimeout) {
    int _newTimeout = int.parse(newTimeout);
    if (_newTimeout > 300 && _newTimeout < 10000) {
      timeout = _newTimeout;
      // print(timeout.toString());
      notifyListeners();
      return "Ustawiono nową wartość na $newTimeout ms";
    }
    return "Wartość musi byc w przedziale od 500 do 10 000 ms";
  }

  String setNewIpRange(String newRange) {
    ipRange = newRange;
    notifyListeners();
    return "Ustawiono nową wartość na $newRange";
  }
}
