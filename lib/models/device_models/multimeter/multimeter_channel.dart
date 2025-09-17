import 'package:test/models/command_model.dart';

class MultimeterChannel {
  final int number;
  String value;
  String unit;
  late List<Command> commands;
  MultimeterChannel(this.number, this.value, this.unit) {
    commands = [
      Command(type: "READ", query: "FUNCTION?"),
      //Command(type: "READ", query: "*IDN?"),
      Command(type: "READ", query: "READ?")
    ];
  }
}
