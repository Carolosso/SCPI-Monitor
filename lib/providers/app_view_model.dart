import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:network_info_plus/network_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:test/models/command_model.dart';
import 'package:test/models/device_models/device_model.dart';
import 'package:test/models/device_models/generator/generator_channel.dart';
import 'package:test/models/device_models/generator/generator_model.dart';
import 'package:test/models/device_models/multimeter/multimeter_model.dart';
import 'package:test/models/device_models/oscilloscope/oscilloscope_channel.dart';
import 'package:test/models/device_models/oscilloscope/oscilloscope_model.dart';
import 'package:test/models/device_models/power_supply/power_supply_channel.dart';
import 'package:test/models/device_models/power_supply/power_supply_model.dart';
import 'package:test/utils/devices_models.dart';
import 'package:test/utils/format_unit.dart';
import 'package:test/utils/increment_ip.dart';
import 'package:test/utils/refresh_device_values.dart';
import 'package:test/utils/socket_connection.dart';
import 'package:test/models/station_model.dart';
import 'package:test/providers/settings_view_model.dart';
import 'package:test/utils/navigation_service.dart';
import 'package:test/utils/validators.dart';

//TODO Unhandled Exception: SocketException: Connection reset by peer (OS Error: Connection reset by peer, errno = 104), address = 10.0.2.2, port = 52046
//TODO TABLET FRIENDLY UI
class AppViewModel extends ChangeNotifier {
  AppViewModel() {
    //on provider creation call this
    init();
  }
  List<Device> devices = [
    Device(
        key: UniqueKey(),
        name: "Generator name",
        type: "Generator",
        ip: "127.0.0.2",
        port: 2313,
        manufacturer: "manufacturer",
        model: "model",
        serial: "serial",
        status: "dostępny",
        channelCount: 2,
        connection: SocketConnection("128.12.12.2", 525)),
    Device(
        key: UniqueKey(),
        name: "Oscyloskop name2222",
        type: "Oscyloskop",
        ip: "127.0.0.222",
        port: 2313,
        manufacturer: "manufacturer",
        model: "model",
        serial: "serial22",
        status: "dostępny",
        channelCount: 4,
        connection: SocketConnection("128.12.12.22", 525)),
    Device(
        key: UniqueKey(),
        name: "Zasilacz name2222",
        type: "Zasilacz",
        ip: "127.0.0.2223",
        port: 2313,
        manufacturer: "manufacturer",
        model: "model",
        serial: "serial223333",
        status: "dostępny",
        channelCount: 3,
        connection: SocketConnection("128.12.12.22", 525))
  ];
  List<Station> stations = [
    Station(devices: [], key: UniqueKey(), name: "Stanowisko 1")
  ];
  int get stationsCount => stations.length;
  int get devicesCount => devices.length;

  bool connectedToWIFI = false;

  bool isStopped = true;
  //
  String textInfo = "";

  String getTextInfo() => textInfo;

  late bool findDevicesInNetworkBreak;

  void switchFindDevicesInNetworkBreak() {
    findDevicesInNetworkBreak = !findDevicesInNetworkBreak;
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
    // debugPrint(context.toString());
    SettingsViewModel settingsViewModel =
        Provider.of<SettingsViewModel>(context!, listen: false);
    return settingsViewModel;
  }

  /// Starting measurements for every Device in every Station with time delay while not stopped.
  void play() async {
    SettingsViewModel settingsViewModel = getSettingsViewModel();
    /*    if (isStopped) {
      for (Station station in stations) {
        for (var device in station.devices) {
          debugPrint("Zaczynanie pomiarow dla ${device.name}");
          device.connection.sendMessageEOM("SYSTem:REMote", '\n');
        }
      }
    } */
    while (!isStopped) {
      for (Station station in stations) {
        for (var device in station.devices) {
          if (isStopped) break;
          // device.connection.sendMessageEOM("SYSTem:LOCK:REQuest?", '\n');
          debugPrint("Próba pobrania informacji urzadzenia ${device.name}");
          await refreshDeviceValues(device);
          debugPrint("Pobrano dla ${device.name}");
          notifyListeners();
        }
      }
      //delay
      await Future.delayed(Duration(milliseconds: settingsViewModel.timeout));
    }
    if (isStopped) {
      for (Station station in stations) {
        for (var device in station.devices) {
          debugPrint("Konczenie pomiarow dla ${device.name}");
          device.connection.sendMessageEOM("SYSTem:LOCal", '\n');
        }
      }
    }
  }

  /// Measurement for every Device in every Station once.
  void playOnce() async {
    for (Station station in stations) {
      for (var device in station.devices) {
        debugPrint("Próba pobrania informacji urzadzenia ${device.name}");
        await refreshDeviceValues(device);

        notifyListeners();
        device.connection.sendMessageEOM("SYSTem:LOCal", '\n');
        debugPrint("Pobrano raz dla ${device.name}");
      }
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
    stations.add(Station(key: UniqueKey(), name: name, devices: []));
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
    String type = "Unknown";
    Socket socket;
    int channelCount = 0;
    try {
      if (!isValidHost(ip)) {
        return "Zły format IP!";
      } else if (!comparedByIP(ip)) {
        return "Urządzenie znajduje się już na liście.";
      }
      //debugPrint("CREATE DEVICE CONNECT PORT:$port");
      //initialize socket
      socket =
          await Socket.connect(ip, port, timeout: const Duration(seconds: 3));
      // listen to the received data event stream
      socket.listen((List<int> event) async {
        debugPrint(utf8.decode(event));
        List<String> message = utf8.decode(event).split(',');
        if (message.length > 3) {
          manufacturer = message.elementAt(0).trim();
          model = message.elementAt(1).trim();
          type = detectDeviceType(model).toString();
          // debugPrint("$type");
          name = "$type $model";
          serial = message.elementAt(2).trim();
        } else if (message.length == 1) {
          channelCount = int.parse(message[0]);
        }
        status = "dostępny";
        //we got response so
        //complete completer
        completer.complete(event);
        completer = Completer();
      });
      /* // ------------------ TEST -------------------------------
      SettingsViewModel vm = getSettingsViewModel();
      if (vm.testOptionsAvailable) {
        socket.add(
            utf8.encode('CONF?\n')); //---> "VOLT +1.000000E+01,+3.000000E-05"
        debugPrint("Zaczynamy timer!");
        final timeoutTimer = Timer(const Duration(seconds: 3), () {
          debugPrint("Koniec czasu");
          textInfo = "Timeout";
          notifyListeners();
          completer.complete();
        });
        //await for response/completer
        await completer.future;
        timeoutTimer.cancel();
      }
      completer = Completer();
      //--------------------- TEST -------------------------------- */
      socket.add(utf8.encode('*IDN?\n'));
      socket.add(utf8.encode('SYST:COUN?\n')); // channels count
      socket.add(utf8.encode('SYSTem:LOCal\n')); // channels count
      //"SYST:COMMunicate:RLSTate REM" Remote and Local do the same thing and are included for compatibility with other products. Both allow front panel control.
      //"SYSTem:LOCal".
      //SYSTem:COMMunicate:TCPip:CONTrol? zwraca port urzadzenia

      // send *IDN? ----> <Manufacturer>, <Model>, <Serial Number>, <Firmware Level>, <Options>.
      //await for response/completer
      final timeoutTimer = Timer(const Duration(seconds: 3), () {
        debugPrint("Koniec czasu");
        textInfo = "Timeout";
        notifyListeners();
        completer.complete();
      });
      //await for response/completer
      await completer.future;
      timeoutTimer.cancel(); // .. and close the socket
      socket.close();
    } catch (ex) {
      return "Nie udalo się nawiązać połączenia z urządzeniem!";
    }

    Device device = Device(
        key: UniqueKey(),
        name: name,
        type: type,
        ip: ip,
        port: port,
        manufacturer: manufacturer,
        model: model,
        serial: serial,
        status: status,
        channelCount: channelCount,
        connection: socketConnection);
    debugPrint("CREATE DEVICE PORT: $port");
    // finally add device to main devices list if not already
    if (comparedBySerial(device)) {
      devices.add(device);
    }
    notifyListeners();
    return "Nawiązano połączenie z urządzeniem!";
  }

  /// Removing Device at specified index from main devices list.
  /// * @index
  String removeDeviceFromList(int index) {
    String name = devices.elementAt(index).name;
    devices.elementAt(index).connection.disconnect();
    devices.removeAt(index);
    notifyListeners();
    return "Usunięto urządzenie: $name";
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
    stations[indexStation].devices.removeAt(indexDevice);
    notifyListeners();
  }

  /// Getting information from WIFI network interface: gateway and broadcast addresses.
  /// And setting connectedToWIFI variable.
  Future<void> getNetworkInfo() async {
    //TODO nie dziala za dobrze to pobieranie, po rozlaczeniu nadal jest polaczenie
    String? gateway = " ";
    String? broadcast = " ";
    SettingsViewModel settingsViewModel = getSettingsViewModel();

    try {
      if (await checkConnectivityToWifi()) {
        //SettingsViewModel settingsViewModel = SettingsViewModel();
        gateway = await NetworkInfo().getWifiGatewayIP();
        // String? mask = await NetworkInfo().getWifiSubmask();
        broadcast = await NetworkInfo().getWifiBroadcast();
        if (broadcast != null && gateway != null) {
          settingsViewModel.broadcast = broadcast;
          settingsViewModel.setNewIpRange(gateway);
          notifyListeners();
        }
      }
      debugPrint(settingsViewModel.broadcast);
      debugPrint(gateway);
    } catch (e) {
      debugPrint("Błąd pobrania informacji o sieci Wi-Fi $e");
    }
  }

  /// Checking if device is connected to Wifi Network
  Future<bool> checkConnectivityToWifi() async {
    final connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.wifi) {
      connectedToWIFI = true;
      return true;
    } else {
      return false;
    }
  }

  /// Refreshes devices in main devices list by checking if can connect with device if so then creates new device.
  Future<void> refreshFunction() async {
    for (Device device in devices) {
      String ip = device.ip;
      int port = device.port;
      //debugPrint("REFRESH FNC PORT: $port");
      if (device.status == "Offline" &&
          await device.connection.canConnect(5000)) {
        device.status = "dostępny";
        devices.remove(device);
        createDevice(ip, port);
      }
      notifyListeners();
    }
  }

  /// Checks if device with its serial is already added in any station
  /// * @indexStation - Index of station we are on
  /// * @device - Device that we want to check
  bool comparedBySerialInStations(var device) {
    for (Station station in stations) {
      for (var device2 in station.devices) {
        if (device2.serial == device.serial) {
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
    /* SocketConnection newSocketConnection =
        SocketConnection(device.ip, device.port);

    Device newDevice = Device(
        key: device.key,
        name: device.name,
        type: device.type,
        ip: device.ip,
        port: device.port,
        manufacturer: device.manufacturer,
        model: device.model,
        serial: device.serial,
        status: device.status,
        connection: newSocketConnection); */

    //debugPrint("ADD DEVICE TO STATION PORT: ${newDevice.port}");
    if (comparedBySerialInStations(device) && device.status == "dostępny") {
      // await device.connection.startConnection(); //TODO
      switch (device.type) {
        case "Multimetr":
          Multimeter multimeter = Multimeter(
              key: UniqueKey(),
              name: device.name,
              displayON: true,
              ip: device.ip,
              port: device.port,
              manufacturer: device.manufacturer,
              model: device.model,
              serial: device.serial,
              status: device.status,
              measuredUnit: "-",
              value: "0.0",
              connection: device.connection);
          stations[indexStation].devices.add(multimeter);
          await multimeter.connection.startConnection();
          break;
        case "Generator":
          Generator generator = Generator(
              key: UniqueKey(),
              name: device.name,
              displayON: true,
              ip: device.ip,
              port: device.port,
              manufacturer: device.manufacturer,
              model: device.model,
              serial: device.serial,
              status: device.status,
              connection: device.connection);
          stations[indexStation].devices.add(generator);
          await generator.connection.startConnection();

          for (GeneratorChannel generatorChannel in generator.channels) {
            for (Command command in generatorChannel.commands) {
              debugPrint(command.query);
            }
          }

          break;
        case "Oscyloskop":
          Oscilloscope oscilloscope = Oscilloscope(
              key: UniqueKey(),
              name: device.name,
              displayON: true,
              ip: device.ip,
              port: device.port,
              manufacturer: device.manufacturer,
              model: device.model,
              serial: device.serial,
              status: device.status,
              connection: device.connection);
          stations[indexStation].devices.add(oscilloscope);
          await oscilloscope.connection.startConnection();
          for (OscilloscopeChannel generatorChannel in oscilloscope.channels) {
            for (Command command in generatorChannel.commands) {
              debugPrint(command.query);
            }
          }
          break;
        case "Zasilacz":
          PowerSupply powerSupply = PowerSupply(
              key: UniqueKey(),
              name: device.name,
              displayON: true,
              ip: device.ip,
              port: device.port,
              manufacturer: device.manufacturer,
              model: device.model,
              serial: device.serial,
              status: device.status,
              connection: device.connection);
          stations[indexStation].devices.add(powerSupply);
          await powerSupply.connection.startConnection();
          for (PowerSupplyChannel generatorChannel in powerSupply.channels) {
            for (Command command in generatorChannel.commands) {
              debugPrint(command.query);
            }
          }
          break;
        default:
      }
      notifyListeners();
    }
  }

  /// Returning devices count of specified type in specified Station.
  int getStationsDevicesCount(int indexStation, String type) {
    debugPrint(
        "$type: ${stations[indexStation].devices.where((device) => device.type == type).length}");

    return stations[indexStation]
        .devices
        .where((device) => device.type == type)
        .length;
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

  /// Returing specified Device's value in specified Station as formatted String.
  /// * @indexStation
  /// * @indexDevice
  String getMultimeterValue(int indexStation, int indexDevice) {
    String value = double.parse(
            stations[indexStation].devices.elementAt(indexDevice).value.trim())
        .toStringAsExponential(3);
    SettingsViewModel settingsViewModel = getSettingsViewModel();

    return settingsViewModel.unitsConversion ? formatUnit(value) : "$value ";
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
    for (var device in stations[indexStation].devices) {
      device.connection.disconnect();
    }
    stations[indexStation].devices.clear();
    stations.removeAt(indexStation);
    notifyListeners();
  }

  /// Looking for devices in local network by trying to connect to them. Starting from network IP address, incrementing and checking till reaching broadcast IP address of this network. If can connect to device at specified port then adding this device to main devices list.
  Future<String> findDevicesInNetwork() async {
    findDevicesInNetworkBreak = false;
    int newCount = 0;
    SettingsViewModel settingsViewModel = getSettingsViewModel();
    String? networkIP = settingsViewModel.ipRange;
    String deviceIP = networkIP; //incrementIP(networkIP!)
    String? broadcast = settingsViewModel.broadcast;
    if (await checkConnectivityToWifi()) {
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
                debugPrint("Znaleziono urządzenie na $deviceIP!");
                notifyListeners();
                await Future.delayed(const Duration(milliseconds: 500));
                textInfo = "Pobieranie informacji urządzenia $deviceIP...";
                debugPrint("Pobieranie informacji urządzenia $deviceIP...");
                notifyListeners();
                await Future.delayed(const Duration(milliseconds: 500));
                await createDevice(deviceIP, 5025);
                newCount++;
                textInfo = "Dodano urządzenie $deviceIP!";
                debugPrint("Dodano urządzenie $deviceIP!");
                notifyListeners();
                await Future.delayed(const Duration(seconds: 1));
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
      return "Brak połączenia z siecią Wi-Fi! Połącz się z siecią i pobierz jej adres w zakładce Ustawienia.";
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
    var device = stations[indexStation].devices.removeAt(oldIndex);
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

  void changeDisplayOnOff(int indexStation, int indexDevice) {
    stations[indexStation].devices[indexDevice].displayON =
        !stations[indexStation].devices[indexDevice].displayON;
    if (stations[indexStation].devices[indexDevice].displayON) {
      stations[indexStation]
          .devices[indexDevice]
          .connection
          .sendMessageEOM("DISPlay OFF", "\n");
    } else if (!stations[indexStation].devices[indexDevice].displayON) {
      stations[indexStation]
          .devices[indexDevice]
          .connection
          .sendMessageEOM("DISPlay ON", "\n");
    }
    notifyListeners();
  }

  bool checkIfStationContainsDeviceType(int indexStation, String type) {
    for (var device in stations[indexStation].devices) {
      if (device.type == type) return true;
    }
    return false;
  }

  void init() async {
    await getNetworkInfo();
  }
}
