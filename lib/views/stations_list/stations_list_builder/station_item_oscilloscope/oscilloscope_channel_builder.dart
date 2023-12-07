import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

Expanded oscilloscopeChannelBuilder(
    int i, AppViewModel viewModel, int indexStation, int indexDevice) {
  return Expanded(
    child: Stack(
      children: [
        Container(
          padding: const EdgeInsets.all(4),
          decoration: BoxDecoration(
              color: i == 1
                  ? Styles.channel1BackgroundColor
                  : i == 2
                      ? Styles.channel2BackgroundColor
                      : i == 3
                          ? Styles.channel3BackgroundColor
                          : i == 4
                              ? Styles.channel4BackgroundColor
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
                              : i == 4
                                  ? Styles.channel4BorderColor
                                  : Colors.white)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                height: 6,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("V",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text("PP: ",
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
              Text(
                  viewModel.stations[indexStation].devices[indexDevice]
                      .channels[i - 1].vpp,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    //fontSize: double.maxFinite,
                  )),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("V",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text("RMS: ",
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
              Text(
                  viewModel.stations[indexStation].devices[indexDevice]
                      .channels[i - 1].vrms,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    //fontSize: double.maxFinite,
                  )),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text("V",
                      style: TextStyle(
                        color: Colors.white,
                      )),
                  Text("AVG: ",
                      style: TextStyle(color: Colors.white, fontSize: 10)),
                ],
              ),
              Text(
                  viewModel.stations[indexStation].devices[indexDevice]
                      .channels[i - 1].vaverage,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    // fontSize: double.maxFinite,
                  )),
              const Text("Freq: ",
                  style: TextStyle(
                    color: Colors.white,
                  )),
              Text(
                  viewModel.stations[indexStation].devices[indexDevice]
                      .channels[i - 1].frequency,
                  maxLines: 1,
                  style: const TextStyle(
                    color: Colors.white,
                    // fontSize: double.maxFinite,
                  )),
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
                              : i == 4
                                  ? Styles.channel4BorderColor
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
