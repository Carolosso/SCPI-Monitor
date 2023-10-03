import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class ConnectionModel {
  String ip;
  int port;
  TcpSocketConnection socketConnection;

  ConnectionModel(this.ip, this.port, this.socketConnection);
}
