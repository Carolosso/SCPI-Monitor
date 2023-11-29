import 'package:flutter/material.dart';

class Station {
  UniqueKey key;
  String name;
  List devices = [];
  //List<Oscillocope> oscilloscopes = [];

  Station({
    required this.devices,
    required this.key,
    required this.name,
  });
}
