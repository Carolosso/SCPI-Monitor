import 'package:flutter/material.dart';
import 'package:test/models/device_model.dart';

class Station {
  UniqueKey key;
  String name;
  List<Device> devices = [];

  Station(this.key, this.name, this.devices);

  List<Device> get stationDevices => devices;
}
