import 'package:test/models/device_model.dart';

class Station {
  String name;

  List<Device> devices = List.empty(growable: true);

  Station(this.name, this.devices);

  List<Device> get stationDevices => devices;

  //String get stationName => _name;

  //set name(String value) => _name = value;

}
