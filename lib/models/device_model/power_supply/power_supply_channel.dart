import 'package:test/models/command_model.dart';

class PowerSupplyChannel {
  final int number;
  late List<Command> setCommands;
  late List<Command> readCommands;
  PowerSupplyChannel(this.number) {
    setCommands = [
      Command(type: "SET", command: "source:voltage? ,(@$number)"),
      Command(type: "SET", command: "source:current? ,(@$number)"),
    ];
    readCommands = [
      Command(type: "READ", command: "measure:voltage? ch$number"),
      Command(type: "READ", command: "measure:current? ch$number"),
    ];
  }
}
