import 'package:flutter/material.dart';
import 'package:test/views/device_list/device_list_view.dart';
import 'package:test/pages/settings_page.dart';
//import 'package:test/views/pages/station_detail_page.dart';
import 'package:test/views/stations_list/stations_list_view.dart';

class ScreenIndexProvider extends ChangeNotifier {
  int screenIndex = 0;

  List<Widget> pages = [
    const StationsListView(),
    DevicesListView(),
    SettingsPage(),
  ];

  void updateScreenIndex(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}
