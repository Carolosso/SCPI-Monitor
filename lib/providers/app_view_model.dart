import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:test/local_package/local_tcp_socket_connection.dart';
import 'package:test/main.dart';
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
  //TODO AppID problem z inkrementacja po usunieciu

  bool isStopped = true;

  void switchStartStop() {
    isStopped = !isStopped;
    notifyListeners();
  }

  void stop() {
    timer.cancel();
  }

  void play() {
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

  void createDevice(String ip, {int port = 5025}) async {
    LocalTcpSocketConnection temp = LocalTcpSocketConnection(ip, port);
    Completer completer = Completer();
    String name = 'Unknown';
    String status = "Offline";
    String serial = "unknown";
    //initialize socket
    Socket socket = await Socket.connect(ip, port);
    // listen to the received data event stream
    socket.listen((List<int> event) async {
      print(utf8.decode(event));
      List<String> message = utf8.decode(event).split(',');
      name = message.elementAt(1).trim();
      serial = message.elementAt(2).trim();
      status = 'Online';
      completer.complete(event);
      //completer that saves my life
    });
    // send *IDN? ----> <Manufacturer>, <Model>, <Serial Number>, <Firmware Level>, <Options>.
    socket.add(utf8.encode('*IDN?\n'));

    var answer = await completer.future;
    // .. and close the socket
    socket.close();
    print('disconnected');
    devices.add(
        Device(devicesCount + 1, name, ip, serial, status, '-', 0.0, temp));
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
    stations[indexStation].devices[indexDevice].value =
        stations[indexStation].devices[indexDevice].connection.getValue();

    notifyListeners();
  }

  int getStationsDevicesCount(int index) {
    return stations[index].devices.length;
  }

  String getDeviceName(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).name;
  }

  String getDeviceMeasuredUnit(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).measuredUnit;
  }

  void setNewParametersToDevice(
      int index, String name, String ip, String unit) {
    devices[index].name = name;
    devices[index].ip = ip;
    devices[index].measuredUnit = unit;
    notifyListeners();
  }

  String formatUnit(String rawValue) {
    String newValue = "";
    //print(rawValue);
    if (rawValue.contains('e') || rawValue.contains('E')) {
      int lastDigit = int.parse(rawValue.substring(rawValue.length - 1));
      double value = double.parse(rawValue.substring(0, rawValue.length - 3));
      if (rawValue.contains('+')) {
        if (lastDigit > 3 && lastDigit <= 6) {
          value = value / pow(10, 6 - lastDigit);
          newValue = "${value.toStringAsFixed(3)} M";
        } else if (lastDigit == 3) {
          value = value / pow(10, 3 - lastDigit);
          newValue = "${value.toStringAsFixed(3)} k";
        } else if (lastDigit > 6 && lastDigit <= 9) {
          value = value / pow(10, 9 - lastDigit);
          newValue = "${value.toStringAsFixed(3)} G";
        } else {
          value = value * pow(10, lastDigit);
          newValue = "${value.toStringAsFixed(3)} ";
//          newValue = rawValue.substring(0, rawValue.length - 3);
        }
      } else if (rawValue.contains('-')) {
        if (lastDigit > 3 && lastDigit <= 6) {
          value = value * pow(10, 6 - lastDigit);
          newValue = "${value.toStringAsFixed(3)} u";
        } else if (lastDigit > 0 && lastDigit <= 3) {
          value = value * pow(10, 3 - lastDigit);
          newValue = "${value.toStringAsFixed(3)} m";
        } else if (lastDigit > 6 && lastDigit <= 9) {
          value = value * pow(10, 9 - lastDigit);
          newValue = "${value.toStringAsFixed(3)} n";
        } else if (lastDigit > 9 && lastDigit <= 12) {
          value = value * pow(10, 12 - lastDigit);
          newValue = "${value.toStringAsFixed(3)} p";
        }
      }
    } else {
      newValue = rawValue;
    }
    return newValue;
  }

  String getDeviceValue(int indexStation, int indexDevice) {
    String temp = stations[indexStation]
        .devices
        .elementAt(indexDevice)
        .value
        .toStringAsExponential(3);
    return formatUnit(temp);
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
