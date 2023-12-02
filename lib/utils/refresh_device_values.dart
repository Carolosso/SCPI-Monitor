import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test/models/device_model/generator/generator_channel.dart';
import 'package:test/models/device_model/oscilloscope/oscilloscope_channel.dart';
import 'package:test/models/device_model/power_supply/power_supply_channel.dart';

/// Refreshes devices values
Future<void> refreshDeviceValues(var device) async {
  Completer completer = Completer();

  switch (device.toString()) {
    case "Multimeter":
      try {
        debugPrint("Wysyłanie do Multimetru: ${device.name}");
        List<String> rawValues = await device.connection.getMultimeterValues();

        //debugPrint(value.toString());
        device.value = rawValues[0];
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
          channel.voltageValue = rawChannelsValues[i].elementAt(1);
          channel.voltageOffset = rawChannelsValues[i].elementAt(2);
          channel.frequencyValue = rawChannelsValues[i].elementAt(3);
          i++;
        }
      } catch (e) {
        //debugPrint("ERROR: $e");
      }
      break;
    case "Oscilloscope":
      try {
        debugPrint("Wysyłanie do Oscyloskopu: ${device.name}");
        List<List<String>> rawChannelsValues =
            await device.connection.getOscilloscopeValues(device);
        int i = 0;
        for (OscilloscopeChannel channel in device.channels) {
          channel.vpp = rawChannelsValues[i].elementAt(0);
          channel.vrms = rawChannelsValues[i].elementAt(1);
          channel.vaverage = rawChannelsValues[i].elementAt(2);
          channel.frequency = rawChannelsValues[i].elementAt(3);
          i++;
        }
      } catch (e) {
        //debugPrint("ERROR: $e");
      }
      break;
    case "Power Supply":
      try {
        debugPrint("Wysyłanie do Zasilacza: ${device.name}");
        List<List<String>> rawChannelsValues =
            await device.connection.getPowerSupplyValues(device);
        int i = 0;
        for (PowerSupplyChannel channel in device.channels) {
          channel.currentSourceValue = rawChannelsValues[i].elementAt(0);
          channel.voltageSourceValue = rawChannelsValues[i].elementAt(1);
          channel.voltageValue = rawChannelsValues[i].elementAt(2);
          channel.currentValue = rawChannelsValues[i].elementAt(3);

          i++;
        }
      } catch (e) {
        //debugPrint("ERROR: $e");
      }
      break;
    default:
  }
}
