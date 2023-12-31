import 'package:flutter/material.dart';
import 'package:test/models/device_models/multimeter/multimeter_channel.dart';
import 'package:test/utils/socket_connection.dart';

class Multimeter {
  UniqueKey key;
  bool displayON;
  String name;
  String ip;
  int port;
  String manufacturer;
  String model;
  String serial;
  String status;
  String measuredUnit;
  String value;
  SocketConnection connection;

  String type = "Multimetr";
  List<MultimeterChannel> channels = [MultimeterChannel(1, "-", "-")];

  Multimeter(
      {required this.key,
      required this.displayON,
      required this.name,
      required this.ip,
      required this.port,
      required this.manufacturer,
      required this.model,
      required this.serial,
      required this.status,
      required this.measuredUnit,
      required this.value,
      required this.connection});

  @override
  String toString() {
    return "Multimeter";
  }
}
