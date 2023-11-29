import 'package:flutter/material.dart';
import 'package:test/models/device_model/generator/generator_channel.dart';
import 'package:test/utils/socket_connection.dart';

class Generator {
  String type = "Generator";
  UniqueKey key;
  bool displayON;
  String name;
  String ip;
  int port;
  String manufacturer;
  String model;
  String serial;
  String status;

  /*  bool stationDetailsChartViewSelected;
  bool stationsChartViewSelected;
  Chart chart; */
  SocketConnection connection;
  List<GeneratorChannel> channels = [GeneratorChannel(1), GeneratorChannel(2)];

  Generator(
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
    // TODO: implement toString
    return "Generator";
  }
}
