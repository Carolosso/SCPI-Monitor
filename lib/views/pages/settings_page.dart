import 'package:flutter/material.dart';
import 'package:tcp_socket_connection/tcp_socket_connection.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({super.key});

  final TcpSocketConnection socketConnection =
      TcpSocketConnection("127.0.0.1", 5025);

  String message = "";

  //receiving and sending back a custom message
  void messageReceived(String msg) {
    message = msg;
    List<String> results = msg.split(',');
    socketConnection.sendMessage("Messega received! huraa");
    print(results[0]);
  }

  //starting the connection and listening to the socket asynchronously
  void startConnection() async {
    socketConnection.enableConsolePrint(
        true); //use this to see in the console what's happening
    if (await socketConnection.canConnect(5000, attempts: 1)) {
      //check if it's possible to connect to the endpoint
      await socketConnection.connect(5000, messageReceived, attempts: 1);
      socketConnection.sendMessageEOM('*IDN?', '\n');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ustawienia'),
      ),
      body: Center(
          child: Column(
        children: [
          TextButton(
            onPressed: () {
              startConnection();
              /* print("Nawiazywanie polaczenia");
              openConnectionWith('10.0.2.2', 5025);
              String response = "";
              final socket = await Socket.connect('10.0.2.2', 5025);

              socket.write('*IDN?\\n');
              //zatrzymujemy sie tu póki co
              socket.listen((Uint8List data) {
                response += String.fromCharCodes(data).trim();
                print(response.toString());
              }); */
              /* Socket.connect('10.0.2.2', 5025).then((socket) {
                print('Connected to: '
                    '${socket.remoteAddress.address}:${socket.remotePort}');

                
                socket.destroy();
              }); */
            },
            child: const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Połącz',
                style: TextStyle(fontSize: 32),
              ),
            ),
          ),
          const TextField(),
        ],
      )),
    );
  }
}
