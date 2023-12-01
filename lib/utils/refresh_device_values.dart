import 'package:flutter/material.dart';
import 'package:test/models/device_model/generator/generator_channel.dart';

/// Refreshes devices values
Future<void> refreshDeviceValues(var device) async {
  switch (device.toString()) {
    case "Multimeter":
      try {
        debugPrint("Wysyłanie do Multimetru: ${device.name}");
        List<String> rawValues = await device.connection.getMultimeterValues();

        //debugPrint(value.toString());
        device.value = double.parse(rawValues[0]);
        device.measuredUnit = rawValues[1];
      } catch (e) {
        //debugPrint("ERROR: $e");
      }
      break;
    case "Generator":
      try {
        debugPrint("Wysyłanie do Generatora: ${device.name}");
        List<List<String>> rawChannelsValues =
            await device.connection.getGeneratorValues(device);
        //debugPrint(value.toString());
        int i = 0;
        for (GeneratorChannel channel in device.channels) {
          channel.function = rawChannelsValues[i].elementAt(0);
          channel.voltageValue =
              double.parse(rawChannelsValues[i].elementAt(1));
          channel.voltageOffset =
              double.parse(rawChannelsValues[i].elementAt(2));
          channel.frequencyValue =
              double.parse(rawChannelsValues[i].elementAt(3));
          i++;
        }
      } catch (e) {
        //debugPrint("ERROR: $e");
      }
      break;
    case "Oscilloscope":
      debugPrint("Wysyłanie do Oscyloskopu: ${device.name}");
      try {
        // double value = await device.connection.getValue();
        // device.value = value;

        // notifyListeners();
      } catch (e) {
        //debugPrint("ERROR: $e");
      }
      break;
    case "Power Supply":
      debugPrint("Wysyłanie do Zasilacza: ${device.name}");

      try {
        // double value = await device.connection.getValue();
        //debugPrint(value.toString());
        //device.value = value;

        //notifyListeners();
      } catch (e) {
        //debugPrint("ERROR: $e");
      }
      break;
    default:
  }
}
