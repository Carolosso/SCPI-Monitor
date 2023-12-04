import 'package:test/models/command_model.dart';

class MultimeterChannel {
  final int number;
  String value;
  String unit;
  List<Command> commands = [
    //Command(type: "READ", query: "FUNCTION?"),
    Command(type: "READ", query: "*IDN?"),
    Command(type: "READ", query: "READ?")
  ];
  MultimeterChannel(this.number, this.value, this.unit);
}
