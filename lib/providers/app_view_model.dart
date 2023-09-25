import 'dart:async';
import 'dart:math';

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
    timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      for (int i = 0; i < stationsCount; i++) {
        for (int j = 0; j < stations[i].devices.length; j++) {
          //con.startConnection();
          refreshDeviceValue(i, j, Random().nextDouble() * 12);
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
    String status = "";
    devices.add(Device(devicesCount + 1, null, name, ip, 'serial', status, 21.2,
        LocalTcpSocketConnection(ip, 5025)));

    //status = (await connection.canConnect(5000)) ? "Online" : "Offline";
    //connection.startConnection();
    //status = connection.message;
    //status = (connection.isConnected()) ? "Online" : "Offline";
    //print("POBRANA NAZWA:${connection.getName()}");

    notifyListeners();
  }

  void removeDevice(int index) {
    devices.removeAt(index);
    notifyListeners();
  }

  void removeDeviceFromStation(int stationIndex, int deviceIndex) {
    stations[stationIndex].devices.removeAt(deviceIndex);
    notifyListeners();
  }

  void addDeviceToStation(int index, Device device) {
    if (!stations[index].devices.contains(device)) {
      //stations[index].devices;
      stations[index].devices.add(device);
      device.stationIndex = index + 1;
      notifyListeners();
    } else {}
  }

  void refreshDeviceValue(int indexStation, int indexDevice, double value) {
    //value = Random().nextDouble() + 12;
    stations[indexStation].devices[indexDevice].value = value;
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
