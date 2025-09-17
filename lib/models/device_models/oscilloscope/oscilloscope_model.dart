import 'package:flutter/material.dart';
import 'package:test/models/device_models/oscilloscope/oscilloscope_channel.dart';
import 'package:test/utils/socket_connection.dart';

class Oscilloscope {
  UniqueKey key;
  bool displayON;
  String name;
  String ip;
  int port;
  String manufacturer;
  String model;
  String serial;
  String status;
  SocketConnection connection;

  String type = "Oscyloskop";
  List<OscilloscopeChannel> channels = [
    OscilloscopeChannel(1, "0", "0", "0", "0"),
    OscilloscopeChannel(2, "0", "0", "0", "0"),
    OscilloscopeChannel(3, "0", "0", "0", "0"),
    OscilloscopeChannel(4, "0", "0", "0", "0")
  ];

  Oscilloscope(
      {required this.key,
      required this.displayON,
      required this.name,
      required this.ip,
      required this.port,
      required this.manufacturer,
      required this.model,
      required this.serial,
      required this.status,
      required this.connection});

  @override
  String toString() {
    return "Oscilloscope";
  }
}
