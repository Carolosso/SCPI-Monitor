import 'package:flutter/material.dart';
import 'package:test/models/device_models/generator/generator_channel.dart';
import 'package:test/models/device_models/multimeter/multimeter_channel.dart';
import 'package:test/models/device_models/oscilloscope/oscilloscope_channel.dart';
import 'package:test/models/device_models/power_supply/power_supply_channel.dart';

Future<void> refreshDeviceValues(var device) async {
  switch (device.toString()) {
    case "Multimeter":
      try {
        debugPrint("Wysyłanie do Multimetru: ${device.name}");
        List<List<String>> rawChannelsValues =
            await device.connection.getMultimeterValues(device);
        int i = 0;
        for (MultimeterChannel channel in device.channels) {
          channel.unit = rawChannelsValues[i].elementAt(0).trim();
          channel.value = rawChannelsValues[i].elementAt(1).trim();
          i++;
        }
      } catch (e) {
        debugPrint("ERROR: $e");
      }
      break;
    case "Generator":
      try {
        debugPrint("Wysyłanie do Generatora: ${device.name}");
        List<List<String>> rawChannelsValues =
            await device.connection.getGeneratorValues(device);
        int i = 0;
        for (GeneratorChannel channel in device.channels) {
          channel.function = rawChannelsValues[i].elementAt(0).trim();
          channel.voltageValue = rawChannelsValues[i].elementAt(1).trim();
          channel.voltageOffset = rawChannelsValues[i].elementAt(2).trim();
          channel.frequencyValue = rawChannelsValues[i].elementAt(3).trim();
          i++;
        }
      } catch (e) {
        debugPrint("ERROR: $e");
      }
      break;
    case "Oscilloscope":
      try {
        debugPrint("Wysyłanie do Oscyloskopu: ${device.name}");
        List<List<String>> rawChannelsValues =
            await device.connection.getOscilloscopeValues(device);
        int i = 0;
        for (OscilloscopeChannel channel in device.channels) {
          channel.vpp = rawChannelsValues[i].elementAt(0).trim();
          channel.vrms = rawChannelsValues[i].elementAt(1).trim();
          channel.vaverage = rawChannelsValues[i].elementAt(2).trim();
          channel.frequency = rawChannelsValues[i].elementAt(3).trim();
          i++;
        }
      } catch (e) {
        debugPrint("ERROR: $e");
      }
      break;
    case "Power Supply":
      try {
        debugPrint("Wysyłanie do Zasilacza: ${device.name}");
        List<List<String>> rawChannelsValues =
            await device.connection.getPowerSupplyValues(device);
        int i = 0;
        for (PowerSupplyChannel channel in device.channels) {
          channel.voltageValue = rawChannelsValues[i].elementAt(0).trim();

          //debugPrint(rawChannelsValues[i].elementAt(0).trim());
          channel.currentValue = rawChannelsValues[i].elementAt(1).trim();
          //debugPrint(rawChannelsValues[i].elementAt(1).trim());
          channel.voltageSourceValue = rawChannelsValues[i].elementAt(3).trim();
          //debugPrint(rawChannelsValues[i].elementAt(3).trim());
          channel.currentSourceValue = rawChannelsValues[i].elementAt(2).trim();
          //debugPrint(rawChannelsValues[i].elementAt(2).trim());
          /*   if (!device.isSet) {} */
          i++;
        }
      } catch (e) {
        debugPrint("ERROR R: $e");
      }
      break;
    default:
  }
}
