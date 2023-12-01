import 'package:test/models/command_model.dart';

class PowerSupplyChannel {
  final int number;
  late List<Command> setCommands;
  late List<Command> readCommands;
  PowerSupplyChannel(this.number) {
    setCommands = [
      Command(type: "SET", query: "source:voltage? ,(@$number)"),
      Command(type: "SET", query: "source:current? ,(@$number)"),
    ];
    readCommands = [
      Command(type: "READ", query: "measure:voltage? ch$number"),
      Command(type: "READ", query: "measure:current? ch$number"),
    ];
  }
}
