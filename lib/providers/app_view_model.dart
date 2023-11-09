import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:fl_chart/fl_chart.dart';
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
  AppViewModel() {
    //on provider creation call this
    init();
  }
  List<Device> devices = [];
  List<Station> stations = [];
  int get stationsCount => stations.length;
  int get devicesCount => devices.length;
  //CHART
  int limitCount = 20;
  double xValue = 0;
  double step = 0.1;
  //
  bool isStopped = true;
  //
  bool connectedToWIFI = false;
  String textInfo = "";

  String getTextInfo() => textInfo;

  late bool findDevicesInNetworkBreak;

  void switchFindDevicesInNetworkBreak() {
    findDevicesInNetworkBreak = !findDevicesInNetworkBreak;
    //notifyListeners();
  }

  void switchStartStop() {
    isStopped = !isStopped;
    notifyListeners();
  }

  /// Getting access to SettingViewModel.
  ///
  /// Returing SettingViewModel.
  SettingsViewModel getSettingsViewModel() {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    debugPrint(context.toString());
    SettingsViewModel settingsViewModel =
        Provider.of<SettingsViewModel>(context!, listen: false);
    return settingsViewModel;
  }

  /// Starting measurements for every Device in every Station with time delay while not stopped.
  void play() async {
    SettingsViewModel settingsViewModel = getSettingsViewModel();
    while (!isStopped) {
      for (Station station in stations) {
        for (Device device in station.devices) {
          if (isStopped) {
            break;
          }
          debugPrint("Próba pobrania informacji urzadzenia ${device.name}");
          refreshDeviceValue(device);
        }
      }
      //delay
      await Future.delayed(Duration(milliseconds: settingsViewModel.timeout));
    }
  }

  /// Creating new Station with specified name then adding to Stations.
  /// * @name
  String createStation(String name) {
    for (Station station in stations) {
      if (station.name == name) {
        return "Nazwa jest już w użyciu.";
      }
    }
    stations.add(Station(UniqueKey(), name, []));
    notifyListeners();
    return "Utworzono stanowisko o nazwie: $name";
  }

  /// Creating new Device at specified IP address and port by checking if IP is valid > opening connection with this device > listening for response > sending "*IDN?" command. If information is reveived saving it and closing connection.
  /// * @ip
  /// * @port
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
      } else if (!comparedByIP(ip)) {
        return "Urządzenie znajduje się już na liście.";
      }
      // debugPrint("CREATE DEVICE CONNECT PORT:$port");
      //initialize socket
      socket =
          await Socket.connect(ip, port, timeout: const Duration(seconds: 3));
      // listen to the received data event stream
      socket.listen((List<int> event) async {
        //debugPrint(utf8.decode(event));
        List<String> message = utf8.decode(event).split(',');
        if (message.length > 1) {
          name = message.elementAt(1).trim();
          manufacturer = message.first;
          model = message.elementAt(1).trim();
          serial = message.elementAt(2).trim();
        }
        status = "available";
        //we got response so
        //complete completer
        completer.complete(event);
      });
      // send *IDN? ----> <Manufacturer>, <Model>, <Serial Number>, <Firmware Level>, <Options>.
      socket.add(utf8.encode('*IDN?\n'));
      //await for response/completer
      await completer.future;
      // .. and close the socket
      socket.close();

      Device device = Device(UniqueKey(), name, ip, port, manufacturer, model,
          serial, status, '-', 0.0, false, [], xValue, socketConnection);
      debugPrint("CREATE DEVICE PORT: $port");
      // finally add device to main devices list if not already
      if (comparedBySerial(device)) {
        devices.add(device);
      }
      notifyListeners();
    } catch (ex) {
      // if can't connect then add it too
      Device device = Device(UniqueKey(), name, ip, port, manufacturer, model,
          serial, status, '-', 0.0, false, [], xValue, socketConnection);
      if (comparedBySerial(device)) {
        devices.add(device);
      }
      notifyListeners();
      return "Nie udalo się nawiązać połączenia z urządzeniem!";
    }
    return "Nawiązano połączenie z urządzeniem!";
  }

  /// Removing Device at specified index from main devices list.
  /// * @index
  void removeDeviceFromList(int index) {
    devices.elementAt(index).connection.disconnect();
    devices.removeAt(index);
    notifyListeners();
  }

  /// Removing Device at specified index from Specified Station.
  /// * @indexStation
  /// * @indexDevice
  void removeDeviceFromStation(int indexStation, int indexDevice) {
    //debugPrint("REMOVE DEVICE FROM STATION PORT: ${stations[indexStation].devices.elementAt(indexDevice).port}");
    stations[indexStation]
        .devices
        .elementAt(indexDevice)
        .connection
        .disconnect();
    // have to clear this points cuz its stays in memory??? despite removing object from list
    //stations[indexStation].devices.elementAt(indexDevice).points.clear();
    stations[indexStation].devices.removeAt(indexDevice);
    xValue = 0; //resetting X
    notifyListeners();
  }

  /// Getting information from WIFI network interface: gateway and broadcast addresses.
  /// And setting connectedToWIFI variable.
  Future<void> getNetworkInfo() async {
    debugPrint("APP VIEW MODEL");
    String? gateway = " ";
    String? broadcast = " ";
    connectedToWIFI = false;
    try {
      SettingsViewModel settingsViewModel = getSettingsViewModel();
      //SettingsViewModel settingsViewModel = SettingsViewModel();
      gateway = await NetworkInfo().getWifiGatewayIP();
      // String? mask = await NetworkInfo().getWifiSubmask();
      broadcast = await NetworkInfo().getWifiBroadcast();
      if (broadcast != null &&
          broadcast.length > 1 &&
          gateway != null &&
          gateway.length > 1) {
        settingsViewModel.broadcast = broadcast;
        settingsViewModel.setNewIpRange(gateway);
        connectedToWIFI = true;
        notifyListeners();
      }
      debugPrint(settingsViewModel.broadcast);
      debugPrint(gateway);
    } catch (e) {
      debugPrint("Blad pobrania informacji o sieci WIFI $e");
    }
  }

  /// Getting information from WIFI network interface: gateway and broadcast addresses.
  /// And setting connectedToWIFI variable.
  Future<void> getNetworkInfoInit() async {
    debugPrint("JEST0");
    String? gateway = " ";
    String? broadcast = " ";
    connectedToWIFI = false;
    debugPrint("JEST00");
    try {
      debugPrint("JEST11");
      SettingsViewModel settingsViewModel = getSettingsViewModel();
      //SettingsViewModel settingsViewModel = SettingsViewModel();
      debugPrint("JEST1");
      gateway = await NetworkInfo().getWifiGatewayIP();
      // String? mask = await NetworkInfo().getWifiSubmask();
      broadcast = await NetworkInfo().getWifiBroadcast();
      if (broadcast != null &&
          broadcast.length > 1 &&
          gateway != null &&
          gateway.length > 1) {
        debugPrint("JEST2");
        settingsViewModel.broadcast = broadcast;
        settingsViewModel.setNewIpRange(gateway);
        connectedToWIFI = true;
        notifyListeners();
      }
      debugPrint(settingsViewModel.broadcast);
      debugPrint(gateway);
    } catch (e) {
      debugPrint("Blad pobrania informacji o sieci WIFI $e");
    }
  }

  /// Refreshes devices in main devices list by checking if can connect with device if so then creates new device.
  Future<void> refreshFunction() async {
    for (Device device in devices) {
      String ip = device.ip;
      int port = device.port;
      debugPrint("REFRESH FNC PORT: $port");
      if (device.status == "Offline" &&
          await device.connection.canConnect(5000)) {
        device.status = "available";
        devices.remove(device);
        createDevice(ip, port);
      }
      notifyListeners();
    }
  }

  /// Checks if device with its serial is already added in any station
  /// * @indexStation - Index of station we are on
  /// * @device - Device that we want to check
  bool comparedBySerialInStations(Device device) {
    for (Station station in stations) {
      for (Device sdevice in station.devices) {
        if (device.serial == sdevice.serial) {
          return false;
        }
      }
    }
    return true;
  }

  /// Checks if device with its serial is already in main devices list
  /// * @device - Device that we want to check
  bool comparedBySerial(Device device) {
    for (Device sdevice in devices) {
      if (device.serial == sdevice.serial) {
        return false;
      }
    }
    return true;
  }

  /// Checks if device with its IP is already in main devices list
  /// * @ip - ip that we want to check
  bool comparedByIP(String ip) {
    for (Device sdevice in devices) {
      if (ip == sdevice.ip) {
        return false;
      }
    }
    return true;
  }

  /// Adds device to designated Station, creates new object(device) from this device, checks if is not already in station and if status is ok, if not opens connection and adds device to station
  Future<void> addDeviceToStation(int indexStation, Device device) async {
    // TODO kopiowanie obiektu - ogarnąć to -
    SocketConnection socketConnection =
        SocketConnection(device.ip, device.port);
    Device newDevice = Device(
        device.key,
        device.name,
        device.ip,
        device.port,
        device.manufacturer,
        device.model,
        device.serial,
        device.status,
        device.measuredUnit,
        device.value,
        device.chartSelected,
        //clearing points and adding one to prevent from crashing
        [const FlSpot(0, 0)],
        device.xValue,
        socketConnection);
    //debugPrint("ADD DEVICE TO STATION PORT: ${newDevice.port}");
    if (comparedBySerialInStations(newDevice) &&
        newDevice.status == "available") {
      await newDevice.connection.startConnection();
      stations[indexStation].devices.add(newDevice);
      notifyListeners();
    }
  }

  /// Refreshes devices value
  void refreshDeviceValue(Device device) {
    //debugPrint("PUNKTY PO RESECIE ${device.points.toString()}");

    //debugPrint("Wysyłanie wiadomosci do ${device.name}");
    try {
      double value = device.connection.getValue();
      //debugPrint(value.toString());
      device.value = value;
      //move chart
      if (device.points.length > limitCount) {
        device.points.removeAt(0);
        notifyListeners();
      }
      //add point to chart
      device.points.add(FlSpot(device.xValue, value));
      // debugPrint(device.points.toString());
      device.xValue += step;
      notifyListeners();
    } catch (e) {
      //debugPrint("ERROR: $e");
    }
  }

  /// Returning devices count in specified Station.
  int getStationsDevicesCount(int index) {
    return stations[index].devices.length;
  }

  /// Returing specified device's name in specified Station.
  String getDeviceName(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).name;
  }

  /// Returing specified device's unit in specified Station.
  String getDeviceMeasuredUnit(int indexStation, int indexDevice) {
    return stations[indexStation].devices.elementAt(indexDevice).measuredUnit;
  }

  /// Checking if there are any devices in any Station. Returns true if there are, false if aren't.
  bool devicesInStations() {
    for (Station station in stations) {
      if (station.devices.isNotEmpty) {
        return true;
      }
    }
    return false;
  }

  /// Setting new parameters to specified Device in specified Station.
  /// * @indexDevice
  /// * @indexStation
  /// * @name
  /// * @unit
  void setNewParametersToDeviceInStation(
      int indexDevice, int indexStation, String name, String unit) {
    stations[indexStation].devices[indexDevice].name = name;
    stations[indexStation].devices[indexDevice].measuredUnit = unit;
    notifyListeners();
  }

  /// Setting new parameters to specified Device in specified Station.
  /// * @indexDevice
  /// * @indexStation
  /// * @chartSelected
  void setCheckBoxParameterToDeviceInStation(
      int indexDevice, int indexStation, bool chartSelected) {
    stations[indexStation].devices[indexDevice].chartSelected = chartSelected;
    notifyListeners();
  }

  /// Setting new parameters to specified Device in main devices list.
  /// * @index
  /// * @name
  /// * @ip
  void setNewParametersToDeviceInList(int index, String name, String ip) {
    devices[index].name = name;
    devices[index].ip = ip;
    devices[index].connection = SocketConnection(ip, 5025);
    notifyListeners();
  }

  /// Formatting value to SI base units. Returing formatted value.
  /// * @rawValue
  String formatUnit(String rawValue) {
    String newValue = "";
    //debugPrint(rawValue);
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

  /// Returing specified Device's value in specified Station as formatted String.
  /// * @indexStation
  /// * @indexDevice
  String getDeviceValue(int indexStation, int indexDevice) {
    String value = stations[indexStation]
        .devices
        .elementAt(indexDevice)
        .value
        .toStringAsExponential(3);
    return formatUnit(value);
  }

  /// Returing specified Station's name.
  /// * @index - index of Station in Stations
  String getStationName(int index) {
    return stations[index].name;
  }

  /// Setting new name for the specified Station.
  /// * @indexStation
  /// * @newName
  String setStationName(int indexStation, String newName) {
    for (Station station in stations) {
      if (station.name == newName) {
        return "Nazwa jest już w użyciu.";
      }
    }
    stations[indexStation].name = newName;
    notifyListeners();
    return "Zmieniono nazwę stanowiska.";
  }

  /// Remove specified Station; disconnecting and removing every Device in Station.
  /// * @indexStation
  void removeStation(int indexStation) {
    for (Device device in stations[indexStation].devices) {
      device.connection.disconnect();
    }
    stations[indexStation].devices.clear();
    stations.removeAt(indexStation);
    notifyListeners();
  }

  /// Increments IP and returs incremented.
  /// * @input
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

  /// Looking for devices in local network by trying to connect to them. Starting from network IP address, incrementing and checking till reaching broadcast IP address of this network. If can connect to device at specified port then adding this device to main devices list.
  Future<String> findDevicesInNetwork() async {
    findDevicesInNetworkBreak = false;
    int newCount = 0;
    SettingsViewModel settingsViewModel = getSettingsViewModel();
    String? networkIP = settingsViewModel.ipRange;
    String deviceIP = networkIP; //incrementIP(networkIP!)
    String? broadcast = settingsViewModel.broadcast;
    if (connectedToWIFI) {
      while (deviceIP != broadcast) {
        if (!findDevicesInNetworkBreak) {
          try {
            textInfo = "Próba połączenia z adresem: $deviceIP";
            notifyListeners();
            if (comparedByIP(deviceIP)) {
              SocketConnection socketConnection =
                  SocketConnection(deviceIP, 5025);
              if (await socketConnection.canConnect(1000)) {
                textInfo = "Znaleziono urządzenie na $deviceIP!";
                notifyListeners();
                await Future.delayed(const Duration(seconds: 1));
                debugPrint("Znaleziono urządzenie na $deviceIP!");
                await createDevice(deviceIP, 5025);
                newCount++;
                notifyListeners();
              } else {
                textInfo = "Nie znaleziono urządzenia o adresie $deviceIP";
                notifyListeners();
                await Future.delayed(const Duration(seconds: 1));
              }
            } else {
              textInfo =
                  "Urządzenie o adresie $deviceIP znajduje się już na liście.";
              notifyListeners();
              await Future.delayed(const Duration(seconds: 1));
            }

            deviceIP = incrementIP(deviceIP);
          } catch (e) {
            debugPrint(e.toString());
          }
        } else {
          break;
        }
      }
    } else {
      return "Brak połączenia z siecią WIFI! Połącz się z siecią i pobierz jej adres w zakładce Ustawienia.";
    }
    return 'Zakończono skanowanie. Dodano $newCount nowe urządzenia.';
  }

  /// Function for Reorderable list to swap stations positions in list.
  void onStationReorder(int oldIndex, int newIndex) {
    // for moving elements down the list
    if (oldIndex < newIndex) {
      newIndex--;
    }
    Station station = stations.removeAt(oldIndex);
    stations.insert(newIndex, station);
    notifyListeners();
  }

  /// Function for Reorderable list to swap devices positions in Station.
  void onDeviceInStationReorder(int oldIndex, int newIndex, int indexStation) {
    // for moving elements down the list
    if (oldIndex < newIndex) {
      newIndex--;
    }
    Device device = stations[indexStation].devices.removeAt(oldIndex);
    stations[indexStation].devices.insert(newIndex, device);
    notifyListeners();
  }

  /// Find index of specified Station in stations by comparing stations key.
  int findStationIndex(Station station) {
    return stations.indexWhere((st) => st.key == station.key);
    /* for (Station st in stations) {
      //debugPrint("${station.key} == ${st.key}");
      if (station.key == st.key) return stations.indexOf(st);
    } 
    return 0;
    */
  }

  void init() async {
    await getNetworkInfo();
  }
}
