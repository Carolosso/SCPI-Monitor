import 'package:test/models/device_model/generator/generator_channel.dart';

class Generator {
  String type = "Generator";

  List<GeneratorChannel> channels = [GeneratorChannel(1), GeneratorChannel(2)];
  @override
  String toString() {
    // TODO: implement toString
    return "Generator";
  }
}
