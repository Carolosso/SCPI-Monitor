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
          //con.startConnection();
          refreshDeviceValue(
            i,
            j,
          );
        }
      }
    });
  }

  // <- Timer
  // <-------------DEBUGGING
  void fillLists() {
    /*  int temp = 0;
    int count = Random().nextInt(4) + 1;

    for (int i = 0; i < stationsCount; i++) {
      count = Random().nextInt(4) + 1;
      for (int j = 0; j < count; j++) {
        addDeviceToStation(
            i,
            Device(
                devicesCount + 1,
                i,
                'name$temp',
                '192.168.0.$temp',
                'serial',
                'Online',
                (Random().nextDouble() * 12),
                LocalTcpSocketConnection('10.0.2.2', 5025)));
        temp++;
      }
    } */
  }

  // <-------------DEBUGGING

  void createStation(String name) {
    stations.add(Station(name, [], stationsCount + 1));
    notifyListeners();
  }

  void createDevice(String name, String ip) async {
    String status;
    LocalTcpSocketConnection testConnection =
        LocalTcpSocketConnection(ip, 5025);
    status = (await testConnection.canConnect(5000)) ? "Online" : "Offline";

    Device temp = Device(devicesCount + 1, null, name, ip, 'serial', status,
        0.0, LocalTcpSocketConnection(ip, 5025));

    devices.add(temp);
    devices.add(Device(devicesCount + 1, null, 'Keysight2', ip, 'serial',
        status, 0.0, LocalTcpSocketConnection(ip, 5026)));

    notifyListeners();
  }

  void removeDevice(int index) {
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
      device.stationIndex = index + 1;
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

  void setNewParametersToDevice(int index, String name) {
    devices[index].name = name;
    notifyListeners();
  }

  double getDeviceValue(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).value;
  }

  String getStationName(int index) {
    return stations[index].name;
  }
}
