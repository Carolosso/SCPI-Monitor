import 'package:test/models/device_model/multimeter/multimeter_channel.dart';

class Multimeter {
  String type = "Multimetr";

  List<MultimeterChannel> channels = [MultimeterChannel(1)];

  @override
  String toString() {
    // TODO: implement toString
    return "Multimetr";
  }
}
