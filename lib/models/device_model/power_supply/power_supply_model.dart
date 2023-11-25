import 'package:test/models/device_model/power_supply/power_supply_channel.dart';

class PowerSupply {
  String type = "Oscyloskop";
  List<PowerSupplyChannel> channels = [
    PowerSupplyChannel(1),
    PowerSupplyChannel(2),
    PowerSupplyChannel(3)
  ];

  @override
  String toString() {
    // TODO: implement toString
    return "Oscyloskop";
  }
}
