import 'package:test/local_package/local_tcp_socket_connection.dart';

class Device {
  String name;
  String ip;
  int port;
  String manufacturer;
  String model;
  String serial;
  String status;
  String measuredUnit;
  double value;
  LocalTcpSocketConnection connection;

  Device(this.name, this.ip, this.port, this.manufacturer, this.model,
      this.serial, this.status, this.measuredUnit, this.value, this.connection);
}
