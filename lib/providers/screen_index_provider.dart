import 'package:flutter/material.dart';
import 'package:test/views/pages/devices_list_page.dart';
import 'package:test/views/stations_view.dart';

class ScreenIndexProvider with ChangeNotifier {
  int screenIndex = 0;
  int get fetch {
    return screenIndex;
  }

  List<Widget> pages = [
    const StationsMainView(),
    //StationDetailPage(),
    const DevicesListPage(),
    //SettingsPage(),
  ];
  void updateScreenIndex(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}
