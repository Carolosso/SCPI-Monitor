import 'package:test/models/command_model.dart';

class OscilloscopeChannel {
  final int number;
  late List<Command> commands;
  OscilloscopeChannel(this.number) {
    commands = [
      Command(type: "READ", command: "measure:vpp? channel$number"),
      Command(type: "READ", command: "measure:vrms? cycle,ac,channel$number"),
      Command(type: "READ", command: "measure:vaverage? cycle,channel$number"),
      Command(type: "READ", command: "measure:frequency? channel$number"),
    ];
  }
}
