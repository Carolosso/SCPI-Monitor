import 'package:flutter/material.dart';
import 'package:test/views/pages/devices_list_page.dart';
import 'package:test/views/pages/settings_page.dart';
//import 'package:test/views/pages/station_detail_page.dart';
import 'package:test/views/stations_view.dart';

class ScreenIndexProvider with ChangeNotifier {
  int screenIndex = 0;

  List<Widget> pages = [
    const StationsMainView(),
    //const StationDetailPage(),
    const DevicesListPage(),
    const SettingsPage(),
  ];

  void updateScreenIndex(int newIndex) {
    screenIndex = newIndex;
    notifyListeners();
  }
}
