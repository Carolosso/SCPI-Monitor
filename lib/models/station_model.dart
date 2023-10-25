import 'package:flutter/material.dart';
import 'package:test/models/device_model.dart';

class Station {
  UniqueKey key;
  String name;
  int stationID;
  List<Device> devices = [];

  Station(this.key, this.name, this.devices, this.stationID);

  List<Device> get stationDevices => devices;
}
