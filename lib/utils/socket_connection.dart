// ignore_for_file: avoid_print

// BASED ON TCPSOCKETCONNECTION PACKAGE

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/models/command_model.dart';
import 'package:test/models/device_model/generator/generator_channel.dart';
import 'package:test/models/device_model/generator/generator_model.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/utils/navigation_service.dart';

class SocketConnection {
  final String _ipAddress;
  final int _portAddress;
  Socket? _server;
  bool _connected = false;
  bool _logPrintEnabled = false;

  SocketConnection(this._ipAddress, this._portAddress);

  //Completer
  Completer completer = Completer();

  String message = '';

  /// Getting value from received message from device by sending "READ?" command
  Future<List> getMultimeterValues() async {
    // debugPrint("get value():${isConnected()}");
    List<String> generatorRawResponses = [];

    try {
      //send READ?
      sendMessageEOM('READ?', '\n');
      //wait for messageReceiver()
      await completer.future;
      //get and return value
      generatorRawResponses.add(message);
      //send FUNCTION?
      sendMessageEOM('*IDN?', '\n'); //sendMessageEOM('FUNCTION?', '\n'); //TODO
      //wait for messageReceiver()
      await completer.future;
      //get and return value
      generatorRawResponses.add(message.split(",").first.split("").first);
      return generatorRawResponses;
    } catch (exception) {
      return List.empty();
    }
  }

  /// Getting value from received message from device by sending "READ?" command
  Future<List<List>> getGeneratorValues(Generator generator) async {
    List<List<String>> generatorChannelsRawResponses = [];
    int i = 0;
    try {
      for (GeneratorChannel channel in generator.channels) {
        for (Command command in channel.commands) {
          if (command.type == "READ") {
            sendMessageEOM(command.query, '\n');
            await completer.future;
            generatorChannelsRawResponses[i].add(message);
          }
        }
        i++;
      }
      return generatorChannelsRawResponses;
    } catch (exception) {
      return List.empty();
    }
  }

  AppViewModel getAppViewModel() {
    BuildContext? context = NavigationService.navigatorKey.currentContext;
    AppViewModel appViewModel =
        Provider.of<AppViewModel>(context!, listen: false);
    return appViewModel;
  }

  //receiving message
  void messageReceiver(String msg) {
    try {
      if (msg.isNotEmpty) {
        message = msg;
        //on succesfull message received complete completer
        completer.complete();
        //create new completer
        completer = Completer();
      }
    } catch (e) {
      debugPrint(e.toString());
    }

    //readValue();
  }

  //starting the connection and listening to the socket asynchronously
  Future startConnection() async {
    enableConsolePrint(true); //use this to see in the console what's happening
    await connect(5000, messageReceiver, attempts: 1);
    //check if it's possible to connect to the endpoint
  }

  /// Shows events in the console with print method
  /// * @param  enable if set to true, then events will be printed in the console
  enableConsolePrint(bool enable) {
    _logPrintEnabled = enable;
  }

  /// Initializes the connection. Socket starts listening to server for data
  /// 'callback' function will be called whenever data is received. The developer elaborates the message received however he wants
  /// No separator is used to split message into parts
  ///  * @param  timeOut  the amount of time to attempt the connection in milliseconds
  ///  * @param  callback  the function called when received a message. It must take a 'String' as param which is the message received
  ///  * @param  attempts  the number of attempts before stop trying to connect. Default is 1.
  Future<void> connect(int timeOut, Function callback,
      {int attempts = 1}) async {
    _printData("CONNECT: $_portAddress");
    int k = 1;
    while (k <= attempts) {
      try {
        _server = await Socket.connect(_ipAddress, _portAddress,
            timeout: Duration(milliseconds: timeOut));
        _connected = true;
        _printData("Socket successfully connected");
        _server!.listen(
          (List<int> event) {
            String received = (utf8.decode(event));
            _printData("Message received: $received");
            callback(received);
          },
          cancelOnError: true,
          onError: (e) {
            debugPrint("EXCEPTION ERROR ");
          },
          //onDone: () => completer.complete(),
        );
        break;
      } catch (ex) {
        _printData("$k attempt: Socket not connected (Timeout reached)");
        if (k == attempts) {
          return;
        }
      }
      k++;
    }
  }

  /// Stops the connection and close the socket
  void disconnect() {
    if (_server != null) {
      try {
        _server!.close();
        //_server!.destroy();
        _printData("Socket disconnected successfully");
      } catch (exception) {
        print("ERROR$exception");
      }
    }
    _connected = false;
  }

  /// Checks if the socket is connected
  bool isConnected() {
    return _connected;
  }

  /// Sends a message to server. Make sure to have established a connection before calling this method
  /// Message will be sent as 'message'
  ///  * @param  message  message to send to server
  void sendMessage(String message) async {
    try {
      if (_server != null && _connected) {
        _server!.add(utf8.encode(message));
        _printData("Message sent: $message");
      } else {
        _printData(
            "Socket not initialized before sending message! Make sure you have already called the method 'connect()'");
      }
    } catch (e) {
      _printData("ERROR $e");
    }
  }

  /// Sends a message to server. Make sure to have established a connection before calling this method
  /// Message will be sent as 'message'+'eom'
  ///  * @param  message  the message to send to server
  ///  * @param  eom  the end of message to send to server
  void sendMessageEOM(String message, String eom) {
    try {
      if (_server != null && _connected) {
        _server!.add(utf8.encode(message + eom));
        _printData("Message sent: $message$eom");
      } else {
        _printData(
            "sending message: Socket not initialized before sending message! Make sure you have already called the method 'connect()'");
      }
    } catch (e) {
      _printData("ERROR: $e");
    }
  }

  /// Test the connection. It will try to connect to the endpoint and if it does, it will disconnect and return 'true' (otherwise false)
  ///  * @param  timeOut  the amount of time to attempt the connection in milliseconds
  ///  * @param  attempts  the number of attempts before stop trying to connect. Default is 1.
  Future<bool> canConnect(int timeOut, {int attempts = 1}) async {
    int k = 1;
    while (k <= attempts) {
      try {
        _server = await Socket.connect(_ipAddress, _portAddress,
            timeout: Duration(milliseconds: timeOut));

        _printData("$k attempt: Socket online");
        return true;
      } catch (exception) {
        _printData("$k attempt: Socket not connected (Timeout reached)");
        if (k == attempts) {
          disconnect();
          return false;
        }
      }
      k++;
    }
    disconnect();
    return false;
  }

  void _printData(String data) {
    if (_logPrintEnabled) {
      debugPrint(data);
    }
  }
}
