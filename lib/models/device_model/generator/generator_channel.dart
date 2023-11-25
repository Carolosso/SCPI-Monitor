import 'package:test/models/command_model.dart';

class GeneratorChannel {
  final int number;
  late List<Command> commands;
  GeneratorChannel(this.number) {
    commands = [
      Command(type: "READ", command: "source$number:function?"),
      Command(type: "READ", command: "source$number:voltage?"),
      Command(type: "READ", command: "source$number:voltage:unit?"),
      Command(type: "READ", command: "source$number:voltage:offset?"),
      Command(type: "READ", command: "source$number:frequency?")
    ];
  }
}
