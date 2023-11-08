import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
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
  List<FlSpot> points;
  SocketConnection connection;

  Device(
      this.key,
      this.name,
      this.ip,
      this.port,
      this.manufacturer,
      this.model,
      this.serial,
      this.status,
      this.measuredUnit,
      this.value,
      this.points,
      this.connection);
}
