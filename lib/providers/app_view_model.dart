// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/local_package/local_tcp_socket_connection.dart';
import 'package:test/models/device_model.dart';
import 'package:test/models/station_model.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/utils/navigation_service.dart';
import 'package:test/utils/validators.dart';

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

  SettingsViewModel getSettingsViewModel() {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    SettingsViewModel settingsViewModel =
        Provider.of<SettingsViewModel>(context!, listen: false);
    return settingsViewModel;
  }

  void stop() {
    timer.cancel();
  }

  void play() {
    SettingsViewModel settingsViewModel = getSettingsViewModel();
    timer = Timer.periodic(Duration(milliseconds: settingsViewModel.timeout),
        (timer) {
      for (int i = 0; i < stationsCount; i++) {
        for (int j = 0; j < stations[i].devices.length; j++) {
          if (stations[i].devices[j].status == "Online") {}
          refreshDeviceValue(i, j);
        }
      }
    });
  }

  void createStation(String name) {
    stations.add(Station(name, [], stationsCount + 1));
    notifyListeners();
  }

  Future<String> createDevice(String ip, {int port = 5025}) async {
    LocalTcpSocketConnection temp = LocalTcpSocketConnection(ip, port);

    Completer completer = Completer();
    String name = "Unknown";
    String manufacturer = "Unknown";
    String model = "Unknown";
    String status = "Offline";
    String serial = "Unknown";
    Socket socket;

    try {
      if (!isValidHost(ip)) {
        return "Zły format IP!";
      }
      //initialize socket
      socket =
          await Socket.connect(ip, port, timeout: const Duration(seconds: 5));
      // listen to the received data event stream
      socket.listen((List<int> event) async {
        //print(utf8.decode(event));
        List<String> message = utf8.decode(event).split(',');
        if (message.length > 1) {
          name = message.elementAt(1).trim();
          manufacturer = message.first;
          model = message.elementAt(1).trim();
          serial = message.elementAt(2).trim();
        }
        status = "Online";
        completer.complete(event);
        //completer that saves my life
      });
      // send *IDN? ----> <Manufacturer>, <Model>, <Serial Number>, <Firmware Level>, <Options>.
      socket.add(utf8.encode('*IDN?\n'));
      //await for response
      await completer.future;
      // .. and close the socket
      socket.close();
      socket.destroy();
      // finally add device to listDevice device =
      Device device =
          Device(name, ip, manufacturer, model, serial, status, '-', 0.0, temp);
      devices.add(device);
      notifyListeners();
    } catch (ex) {
      Device device =
          Device(name, ip, manufacturer, model, serial, status, '-', 0.0, temp);

      devices.add(device);
      notifyListeners();
      return "Nie udalo się nawiązać połączenia z urządzeniem!\n$ex";
    }
    return "Nawiązano połączenie z urządzeniem!";
  }

  void removeDeviceFromList(int index) {
    devices.removeAt(index);
    notifyListeners();
  }

  Future<void> refreshFunction() async {
    for (Device device in devices) {
      String _ip = device.ip;
      if (device.status == "Online" &&
          await device.connection.canConnect(5000)) {
        //device.status = "Online";
        //notifyListeners();
      } else if (device.status == "Offline" &&
          await device.connection.canConnect(5000)) {
        device.status = "Online";
        devices.remove(device);
        createDevice(_ip);
      } else if (!await device.connection.canConnect(5000)) {
        device.status = "Offline";
      }
      notifyListeners();
    }
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
    print("Dodawanie urzadzenia to stanowiska: $device.connection");
    if (!stations[index].devices.contains(device)) {
      if (device.status == "Online") {
        stations[index].devices.add(device);
        notifyListeners();
      }
    } else {}
  }

  void refreshDeviceValue(int indexStation, int indexDevice) async {
    //print(stations[indexStation].devices[indexDevice].connection.isConnected());
    bool connected =
        stations[indexStation].devices[indexDevice].connection.isConnected();
    if (!connected) {
      await stations[indexStation]
          .devices[indexDevice]
          .connection
          .startConnection();
    } else if (connected) {
      stations[indexStation].devices[indexDevice].value =
          stations[indexStation].devices[indexDevice].connection.getValue();
      notifyListeners();
    }
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

  bool devicesInStations() {
    for (Station station in stations) {
      if (station.devices.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  void setNewParametersToDeviceInStation(
      int indexDevice, int indexStation, String name, String unit) {
    stations[indexStation].devices[indexDevice].name = name;
    stations[indexStation].devices[indexDevice].measuredUnit = unit;
    notifyListeners();
  }

  void setNewParametersToDeviceInList(int index, String name, String ip) {
    devices[index].name = name;
    devices[index].ip = ip;
    devices[index].connection = LocalTcpSocketConnection(ip, 5025);
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
