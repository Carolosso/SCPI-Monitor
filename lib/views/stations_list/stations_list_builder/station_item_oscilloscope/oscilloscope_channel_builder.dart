import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

Expanded oscilloscopeChannelBuilder(int i) {
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
              const Text("Fun: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  )),
              const Text("12.323 mV",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )),
              const Text("Volt: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  )),
              const Text("12.323 mV",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )),
              const Text("Offs: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  )),
              const Text("12.323 mV",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                  )),
              const Text("Freq: ",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 8,
                  )),
              const Text("12.323 mV",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 12,
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
