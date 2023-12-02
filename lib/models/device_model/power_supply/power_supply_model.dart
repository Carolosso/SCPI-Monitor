import 'package:flutter/material.dart';
import 'package:test/models/device_model/power_supply/power_supply_channel.dart';
import 'package:test/utils/socket_connection.dart';

class PowerSupply {
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

  List<PowerSupplyChannel> channels = [
    PowerSupplyChannel(1, false, "0", "0", "0", "0"),
    PowerSupplyChannel(2, false, "0", "0", "0", "0"),
    PowerSupplyChannel(3, false, "0", "0", "0", "0")
  ];
  String type = "Zasilacz";

  PowerSupply(
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
    return "Power Supply";
  }
}
