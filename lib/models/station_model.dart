import 'package:flutter/material.dart';
import 'package:test/models/device_model/device_model.dart';

class Station {
  UniqueKey key;
  String name;
  List<Device> devices = [];

  Station({required this.key, required this.name, required this.devices});
}
