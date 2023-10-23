import 'package:flutter/material.dart';
import 'package:test/local_package/local_tcp_socket_connection.dart';

class Device {
  bool isAssigned;
  String name;
  String ip;
  String manufacturer;
  String model;
  String serial;
  String status;
  String measuredUnit;
  double value;
  LocalTcpSocketConnection connection;

  Device(this.isAssigned, this.name, this.ip, this.manufacturer, this.model,
      this.serial, this.status, this.measuredUnit, this.value, this.connection);
}
