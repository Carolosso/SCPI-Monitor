import 'package:test/models/command_model.dart';

class MultimeterChannel {
  int number = 1;

  List<Command> commands = [
    Command(type: "READ", command: "FUNCTION?"),
    Command(type: "READ", command: "READ?")
  ];
}
