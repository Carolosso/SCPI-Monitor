import 'package:test/models/command_model.dart';

class OscilloscopeChannel {
  final int number;
  late List<Command> commands;
  OscilloscopeChannel(this.number) {
    commands = [
      Command(type: "READ", query: "measure:vpp? channel$number"),
      Command(type: "READ", query: "measure:vrms? cycle,ac,channel$number"),
      Command(type: "READ", query: "measure:vaverage? cycle,channel$number"),
      Command(type: "READ", query: "measure:frequency? channel$number"),
    ];
  }
}
