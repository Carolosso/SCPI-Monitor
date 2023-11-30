import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

Expanded generatorChannelBuilder(int i) {
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
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Fun: ",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    "12.323 mV",
                    style: TextStyle(color: Colors.white),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Volt: ", style: TextStyle(color: Colors.white)),
                  Text("12.323 mV", style: TextStyle(color: Colors.white)),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Offs: ", style: TextStyle(color: Colors.white)),
                  Text("12.323 mV", style: TextStyle(color: Colors.white)),
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Freq: ", style: TextStyle(color: Colors.white)),
                  Text("12.323 mV", style: TextStyle(color: Colors.white)),
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
