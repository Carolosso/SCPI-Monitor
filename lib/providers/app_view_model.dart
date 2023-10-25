// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:test/utils/socket_connection.dart';
import 'package:test/models/device_model.dart';
import 'package:test/models/station_model.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/utils/navigation_service.dart';
import 'package:test/utils/validators.dart';

//TODO Unhandled Exception: SocketException: Connection reset by peer (OS Error: Connection reset by peer, errno = 104), address = 10.0.2.2, port = 52046
class AppViewModel extends ChangeNotifier {
  bool isDarkTheme = false;

  List<Device> devices = [];
  List<Station> stations = [];
  int get stationsCount => stations.length;
  int get devicesCount => devices.length;
  // <- Timer
  //late Timer timer;
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
    //isStopped = !isStopped;
    //timer.cancel();
  }

  void play() async {
    SettingsViewModel settingsViewModel = getSettingsViewModel();
    //Completer completer = Completer();
    while (!isStopped) {
      for (Station station in stations) {
        for (Device device in station.devices) {
          if (isStopped) {
            // completer.complete();
            break;
          }
          print("Próba pobrania informacji urzadzenia ${device.name}");
          refreshDeviceValue(device);
        }
      }
      // await completer.future;
      await Future.delayed(Duration(milliseconds: settingsViewModel.timeout));
    }
  }

  void createStation(String name) {
    stations.add(Station(UniqueKey(), name, [], stationsCount + 1));
    notifyListeners();
  }

  Future<String> createDevice(String ip, int port) async {
    SocketConnection socketConnection = SocketConnection(ip, port);

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
      print("CREATE DEVICE CONNECT PORT:$port");
      socket =
          await Socket.connect(ip, port, timeout: const Duration(seconds: 3));
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
      //socket.flush();
      socket.close();

      // finally add device to listDevice device =
      Device device = Device(name, ip, port, manufacturer, model, serial,
          status, '-', 0.0, socketConnection);
      print("CREATE DEVICE PORT: $port");
      if (!devices.contains(device)) {
        devices.add(device);
      }

      notifyListeners();
    } catch (ex) {
      Device device = Device(name, ip, port, manufacturer, model, serial,
          status, '-', 0.0, socketConnection);
      if (!devices.contains(device)) {
        devices.add(device);
      }
      notifyListeners();
      return "Nie udalo się nawiązać połączenia z urządzeniem!\n$ex";
    }
    return "Nawiązano połączenie z urządzeniem!";
  }

  void removeDeviceFromList(int index) {
    devices.elementAt(index).connection.disconnect();
    devices.removeAt(index);
    notifyListeners();
  }

  void removeDeviceFromStation(int stationIndex, int deviceIndex) {
    print(
        "REMOVE DEVICE FROM STATION PORT: ${stations[stationIndex].devices.elementAt(deviceIndex).port}");
    stations[stationIndex]
        .devices
        .elementAt(deviceIndex)
        .connection
        .disconnect();
    stations[stationIndex].devices.removeAt(deviceIndex);
    notifyListeners();
  }

  Future<void> getNetworkInfo() async {
    String? gateway;
    String? broadcast;
    try {
      SettingsViewModel settingsViewModel = getSettingsViewModel();
      gateway = await NetworkInfo().getWifiGatewayIP();
      // String? mask = await NetworkInfo().getWifiSubmask();
      broadcast = await NetworkInfo().getWifiBroadcast();
      if (broadcast != null && gateway != null) {
        settingsViewModel.broadcast = broadcast;
        settingsViewModel.setNewIpRange(gateway);
      }
      print(settingsViewModel.broadcast);
      print(gateway);
    } catch (e) {
      print("Blad pobrania info o sieci WIFI $e");
    }
  }

  Future<void> refreshFunction() async {
    for (Device device in devices) {
      String ip = device.ip;
      int port = device.port;
      print("REFRESH FNC PORT: $port");
      if (device.status == "Offline" &&
          await device.connection.canConnect(5000)) {
        device.status = "Online";
        devices.remove(device);
        createDevice(ip, port);
      }
      notifyListeners();
    }
  }

  bool comparedBySerialInStation(int indexStation, Device device) {
    for (Device sdevice in stations[indexStation].devices) {
      if (device.serial == sdevice.serial) {
        return false;
      }
    }
    return true;
  }

  Future<void> addDeviceToStation(int indexStation, Device device) async {
    // TODO kopiowanie obiektu - ogarnąć to -
    SocketConnection socketConnection =
        SocketConnection(device.ip, device.port);
    Device newDevice = Device(
        device.name,
        device.ip,
        device.port,
        device.manufacturer,
        device.model,
        device.serial,
        device.status,
        device.measuredUnit,
        device.value,
        socketConnection);
    print("ADD DEVICE TO STATION PORT: ${newDevice.port}");
    if (comparedBySerialInStation(indexStation, newDevice)) {
      if (!newDevice.connection.isConnected()) {
        await newDevice.connection.startConnection();
        //newDevice.connection.sendMessage("READ?\n");
        //newDevice.value = newDevice.connection.getValue();
        stations[indexStation].devices.add(newDevice);
        notifyListeners();
      } else {
        stations[indexStation].devices.add(newDevice);
        notifyListeners();
      }
    }
  }

  void refreshDeviceValue(Device device) {
    // LocalTcpSocketConnection connection = device.connection;
    print("Wysyłanie wiadomosci do ${device.name}");
    try {
      double value = device.connection.getValue();
      print(value);
      device.value = value;
      notifyListeners();
    } catch (e) {
      print("ERROR: $e");
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
    devices[index].connection = SocketConnection(ip, 5025);
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

  String incrementIP(String input) {
    List<String> inputIPString = input.split(".");
    List<int> inputIP = inputIPString.map((e) => int.parse(e)).toList();
    var ip = (inputIP[0] << 24) |
        (inputIP[1] << 16) |
        (inputIP[2] << 8) |
        (inputIP[3] << 0);
    ip++;
    return "${ip >> 24 & 0xff}.${ip >> 16 & 0xff}.${ip >> 8 & 0xff}.${ip >> 0 & 0xff}"; //0xff = 255
  }

  Future<void> findDevicesInNetwork() async {
    SettingsViewModel settingsViewModel = getSettingsViewModel();
    String? networkIP = settingsViewModel.ipRange;
    String deviceIP = networkIP; //incrementIP(networkIP!)
    String? broadcast = settingsViewModel.broadcast;
    while (deviceIP != broadcast) {
      try {
        print("Próba połączenia na adresie: $deviceIP");
        SocketConnection socketConnection = SocketConnection(deviceIP, 5025);
        if (await socketConnection.canConnect(1000)) {
          print("Znaleziono urządzenia na $deviceIP");
          await createDevice(deviceIP, 5025);
        }
        deviceIP = incrementIP(deviceIP);
      } catch (e) {
        print(e);
      }
    }
  }

  void onStationReorder(int oldIndex, int newIndex) {
    if (oldIndex < newIndex) {
      newIndex--;
    }
    Station station = stations.removeAt(oldIndex);
    stations.insert(newIndex, station);
    notifyListeners();
  }
}
