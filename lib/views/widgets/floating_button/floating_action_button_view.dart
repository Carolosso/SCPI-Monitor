import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';

class FloatingActionButtonView extends StatelessWidget {
  const FloatingActionButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    ValueNotifier<bool> isDialOpen = ValueNotifier(false);

    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return SpeedDial(
            label: const Text("Pomiar"),
            icon: Icons.settings_remote,
            openCloseDial: isDialOpen,
            backgroundColor: Styles.surfaceColor,
            children: [
              SpeedDialChild(
                  label: "Pomiar ciągły",
                  child: viewModel.isStopped
                      ? const Icon(
                          Icons.play_arrow,
                          color: Colors.black,
                          size: 30,
                        )
                      : const Icon(
                          Icons.stop,
                          color: Colors.black,
                          size: 30,
                        ),
                  onTap: () async {
                    if (viewModel.isStopped &&
                        viewModel.devicesInStations() &&
                        (await viewModel.checkConnectivityToWifi())) {
                      viewModel.switchStartStop();
                      viewModel.play();
                    } else if (!viewModel.isStopped) {
                      viewModel.switchStartStop();
                    }
                  }),
              SpeedDialChild(
                  label: "Pomiar pojedynczy",
                  child: const Icon(
                    Icons.play_for_work_rounded,
                    color: Colors.black,
                    size: 30,
                  ),
                  onTap: () async {
                    if (viewModel.isStopped &&
                        viewModel.devicesInStations() &&
                        (await viewModel.checkConnectivityToWifi())) {
                      debugPrint("PROBA POJEDYNCZEGO POMIARU");
                      viewModel.playOnce();
                    }
                  })
            ]);
      },
    );
  }
}
