import 'package:test/models/command_model.dart';

class MultimeterChannel {
  final int number;
  late List<Command> commands;
  MultimeterChannel(this.number) {
    commands = [
      Command(type: "READ", query: "FUNCTION?"),
      Command(type: "READ", query: "READ?")
    ];
  }
}
