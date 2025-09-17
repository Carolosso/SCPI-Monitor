import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/views/debug/debug_builder.dart';
import 'package:test/views/widgets/custom_app_bars/debug_app_bar/custom_app_bar_for_debug.dart';

class DebugView extends StatelessWidget {
  DebugView({super.key});

  final TextEditingController queryTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer<AppViewModel>(builder: (context, viewModel, child) {
      return Scaffold(
        appBar: CustomAppBarDebugView(),
        body: DebugBuilder(
          viewModel: viewModel,
        ),
      );
    });
  }
}
