import 'package:flutter/material.dart';
import 'package:test/models/chart_model.dart';
import 'package:test/utils/socket_connection.dart';

class Device {
  UniqueKey key;
  String name;
  String ip;
  int port;
  String manufacturer;
  String model;
  String serial;
  String status;
  String measuredUnit;
  double value;
  bool chartSelected;
  Chart chart;
  SocketConnection connection;

  Device(
      {required this.key,
      required this.name,
      required this.ip,
      required this.port,
      required this.manufacturer,
      required this.model,
      required this.serial,
      required this.status,
      required this.measuredUnit,
      required this.value,
      required this.chartSelected,
      required this.chart,
      required this.connection});
}
