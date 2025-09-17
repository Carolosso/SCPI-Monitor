import 'package:test/models/command_model.dart';

class PowerSupplyChannel {
  final int number;
  String voltageSourceValue; //double voltageSourceValue;
  String currentSourceValue; //double currentSourceValue;
  String voltageValue; //double voltageValue;
  String currentValue; //double currentValue;
  late List<Command> commands;

  PowerSupplyChannel(this.number, this.voltageSourceValue,
      this.currentSourceValue, this.voltageValue, this.currentValue) {
    commands = [
      Command(type: "READ", query: "measure:voltage? ch$number"),
      Command(type: "READ", query: "measure:current? ch$number"),
      Command(type: "READ", query: "source:voltage? (@$number)"),
      Command(type: "READ", query: "source:current? (@$number)"),
    ];
  }
}
