import 'package:test/local_package/local_tcp_socket_connection.dart';

class Device {
  //int? stationIndex;
  int? deviceID;
  //bool isAssigned = false;
  String name;
  String ip;
  String serial;
  String status;
  String measuredUnit;
  double value;
  LocalTcpSocketConnection connection;

  Device(this.deviceID, this.name, this.ip, this.serial, this.status,
      this.measuredUnit, this.value, this.connection);
}
