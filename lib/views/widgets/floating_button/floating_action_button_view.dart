import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/providers/app_view_model.dart';

class FloatingActionButtonView extends StatelessWidget {
  const FloatingActionButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return FloatingActionButton(
            backgroundColor: Styles.surfaceColor,
            onPressed: () async {
              if (viewModel.isStopped &&
                  viewModel.devicesInStations() &&
                  (await viewModel.checkConnectivityToWifi())) {
                viewModel.switchStartStop();
                viewModel.play();
              } else if (!viewModel.isStopped) {
                viewModel.switchStartStop();
              }
            },
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
                  ));
      },
    );
  }
}
