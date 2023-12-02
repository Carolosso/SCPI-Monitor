import 'package:test/models/command_model.dart';

class GeneratorChannel {
  final int number;
  String function;
  String voltageValue; //double voltageValue;
  String voltageOffset; //double voltageOffset;
  String frequencyValue; //double frequencyValue;

  late List<Command> commands;
  GeneratorChannel(this.number, this.function, this.voltageValue,
      this.voltageOffset, this.frequencyValue) {
    commands = [
      Command(type: "READ", query: "source$number:function?"),
      Command(type: "READ", query: "source$number:voltage?"),
      // Command(type: "READ", query: "source$number:voltage:unit?"),
      Command(type: "READ", query: "source$number:voltage:offset?"),
      Command(type: "READ", query: "source$number:frequency?")
    ];
  }
}
