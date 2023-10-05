import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/local_package/local_TcpSocketConnection.dart';
import 'package:test/models/device_model.dart';
import 'package:test/models/station_model.dart';

class AppViewModel extends ChangeNotifier {
  bool isDarkTheme = false;

  List<Device> devices = [];
  List<Station> stations = [];

  int get stationsCount => stations.length;
  int get devicesCount => devices.length;
  // <- Timer
  late Timer timer;

  bool isStopped = true;

  void switchStartStop() {
    isStopped = !isStopped;
    notifyListeners();
  }

  void stop() {
    timer.cancel();
  }

  void play() async {
    timer = Timer.periodic(const Duration(milliseconds: 500), (timer) {
      for (int i = 0; i < stationsCount; i++) {
        for (int j = 0; j < stations[i].devices.length; j++) {
          refreshDeviceValue(i, j);
        }
      }
    });
  }

  void createStation(String name) {
    stations.add(Station(name, [], stationsCount + 1));
    notifyListeners();
  }

  void createDevice(String name, String ip) async {
    String status = '';
    LocalTcpSocketConnection testConnection =
        LocalTcpSocketConnection(ip, 5025);
    status = (await testConnection.canConnect(5000)) ? "Online" : "Offline";

    Device temp = Device(devicesCount + 1, name, ip, 'serial', status, 0.0,
        LocalTcpSocketConnection(ip, 5025));
    devices.add(temp);
    notifyListeners();
  }

  void removeDeviceFromList(int index) {
    devices.removeAt(index);
    notifyListeners();
  }

  void removeDeviceFromStation(int stationIndex, int deviceIndex) {
    stations[stationIndex]
        .devices
        .elementAt(deviceIndex)
        .connection
        .disconnect();
    stations[stationIndex].devices.removeAt(deviceIndex);
    notifyListeners();
  }

  void addDeviceToStation(int index, Device device) {
    if (!stations[index].devices.contains(device)) {
      device.connection.startConnection();

      stations[index].devices.add(device);
      //device.stationIndex = index + 1;
      notifyListeners();
    } else {}
  }

  void refreshDeviceValue(int indexStation, int indexDevice) {
    stations[indexStation].devices[indexDevice].connection.readValue();
    stations[indexStation].devices[indexDevice].value =
        stations[indexStation].devices[indexDevice].connection.getValue;

    notifyListeners();
  }

  int getStationsDevicesCount(int index) {
    return stations[index].devices.length;
  }

  String getDeviceName(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).name;
  }

  void setNewParametersToDevice(int index, String name, String ip) {
    devices[index].name = name;
    devices[index].ip = ip;
    notifyListeners();
  }

  double getDeviceValue(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).value;
  }

  String getStationName(int index) {
    return stations[index].name;
  }

  void setStationName(int indexStation, String newName) {
    stations[indexStation].name = newName;
    notifyListeners();
  }

  void removeStation(int indexStation) {
    stations[indexStation].devices.clear();
    stations.removeAt(indexStation);
    notifyListeners();
  }
}
