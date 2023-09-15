import 'package:test/models/device_model.dart';

class Station {
  String name;
  int stationID;
  List<Device> devices = List.empty(growable: true);

  Station(this.name, this.devices, this.stationID);

  List<Device> get stationDevices => devices;
}
