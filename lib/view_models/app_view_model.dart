import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test/models/device_model.dart';
import 'package:test/models/station_model.dart';
import 'package:test/views/pages/devices_list_page.dart';
import 'package:test/views/pages/main_page.dart';

class AppViewModel extends ChangeNotifier {
  bool isDarkTheme = false;
  List<Widget> pages = [
    const MainPage(),
    //StationDetailPage(),
    const DevicesListPage(),
    //SettingsPage(),
  ];
  List<Device> devices = [];
  List<Station> stations = [];
  int get stationsCount => stations.length;

  // <- Timer
  late Timer _timer;
  bool isStopped = true;

  void stopTimer() {
    isStopped = true;
    _timer.cancel();
  }

  void play() {
    isStopped = false;
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      for (int i = 0; i < stationsCount; i++) {
        for (int j = 0; j < stations[i].devices.length; j++) {
          refreshDeviceValue(i, j);
        }
      }
    });
  }

  // <- Timer
  // <-------------DEBUGGING
  void fillLists() {
    int temp = 0;
    int count = Random().nextInt(4) + 1;

    for (int i = 0; i < stationsCount; i++) {
      count = Random().nextInt(4) + 1;
      for (int j = 0; j < count; j++) {
        addDeviceToStation(
            i,
            Device('name$temp', '192.168.0.$temp', 'serial', 'Online',
                (Random().nextDouble() * 12)));
        temp++;
      }
    }
  }

  // <-------------DEBUGGING

  void createStation(String name) {
    stations.add(Station(name, []));
    notifyListeners();
  }

  void createDevice(String name) {
    devices.add(Device(name, 'ip', 'serial', 'status', 12.0));
    notifyListeners();
  }

  void addDeviceToStation(int index, Device device) {
    devices.add(device);
    stations[index].devices.add(device);
    notifyListeners();
  }

  void refreshDeviceValue(int indexStation, int indexDevice) {
    stations[indexStation].devices[indexDevice].value =
        Random().nextDouble() + 12;
    notifyListeners();
  }

  int getStationsDevicesCount(int index) {
    return stations[index].devices.length;
  }

  String getDeviceName(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).name;
  }

  double getDeviceValue(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).value;
  }

  String getStationName(int index) {
    return stations[index].name;
  }
}
