import 'package:test/local_package/local_TcpSocketConnection.dart';

class Device {
  int? stationIndex;
  int? deviceID;
  //bool isAssigned = false;
  String name;
  String ip;
  String serial;
  String status;
  double value;
  LocalTcpSocketConnection connection;

  Device(this.deviceID, this.stationIndex, this.name, this.ip, this.serial,
      this.status, this.value, this.connection);
}
