import 'package:test/models/device_model/oscilloscope/oscilloscope_channel.dart';

class Multimeter {
  String type = "Oscyloskop";
  List<OscilloscopeChannel> channels = [
    OscilloscopeChannel(1),
    OscilloscopeChannel(2),
    OscilloscopeChannel(3),
    OscilloscopeChannel(4)
  ];

  @override
  String toString() {
    // TODO: implement toString
    return "Oscyloskop";
  }
}
