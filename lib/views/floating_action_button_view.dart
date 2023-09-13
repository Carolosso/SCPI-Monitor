import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/style/theme.dart';
import 'package:test/view_models/app_view_model.dart';

class FloatingActionButtonView extends StatelessWidget {
  const FloatingActionButtonView({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(
      builder: (context, viewModel, child) {
        return FloatingActionButton(
            backgroundColor: Styles.surfaceColor,
            onPressed: () {
              if (viewModel.isStopped) {
                viewModel.play();
              } else {
                viewModel.stopTimer();
              }
            },
            child: const Icon(
              Icons.play_arrow,
              color: Colors.black,
              size: 30,
            ));
      },
    );
  }
}
