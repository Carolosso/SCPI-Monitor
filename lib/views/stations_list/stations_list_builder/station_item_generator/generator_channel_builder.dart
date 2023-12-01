import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

Expanded generatorChannelBuilder(
    int i, AppViewModel viewModel, int indexStation, int indexDevice) {
  return Expanded(
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
              color: i == 1
                  ? Styles.channel1BackgroundColor
                  : i == 2
                      ? Styles.channel2BackgroundColor
                      : i == 3
                          ? Styles.channel3BackgroundColor
                          : Colors.white,
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                  width: 5,
                  color: i == 1
                      ? Styles.channel1BorderColor
                      : i == 2
                          ? Styles.channel2BorderColor
                          : i == 3
                              ? Styles.channel3BorderColor
                              : Colors.white)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Fun: ",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "${viewModel.stations[indexStation].devices[indexDevice].channels[i - 1].function}",
                    style: const TextStyle(color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Volt: ", style: TextStyle(color: Colors.white)),
                  Text(
                      "${viewModel.stations[indexStation].devices[indexDevice].channels[i - 1].voltageValue}",
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Offs: ", style: TextStyle(color: Colors.white)),
                  Text(
                      "${viewModel.stations[indexStation].devices[indexDevice].channels[i - 1].voltageOffset}",
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Freq: ", style: TextStyle(color: Colors.white)),
                  Text(
                      "${viewModel.stations[indexStation].devices[indexDevice].channels[i - 1].frequencyValue}",
                      style: const TextStyle(color: Colors.white)),
                ],
              ),
            ],
          ),
        ),
        Positioned(
            left: 0,
            top: 0,
            child: Container(
              decoration: BoxDecoration(
                  color: i == 1
                      ? Styles.channel1BorderColor
                      : i == 2
                          ? Styles.channel2BorderColor
                          : i == 3
                              ? Styles.channel3BorderColor
                              : Colors.white,
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(15),
                      bottomRight: Radius.circular(7.5))),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 6, right: 6, top: 3, bottom: 1),
                child: Text("$i"),
              ),
            )),
      ],
    ),
  );
}
