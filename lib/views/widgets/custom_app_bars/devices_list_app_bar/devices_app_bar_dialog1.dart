import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

Future<dynamic> devicesAppBarDialog1(
    BuildContext context, AppViewModel viewModel) {
  return showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => Center(
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Styles.primaryColor,
                borderRadius: BorderRadius.circular(Styles.globalRadius),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Consumer<AppViewModel>(builder: (context, viewModel, child) {
                    return SizedBox(
                        child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        viewModel.textInfo,
                        style: TextStyle(
                          color: Styles.backgroundColor,
                        ),
                      ),
                    ));
                  }),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 32,
                    width: 32,
                    child: CircularProgressIndicator(
                      color: Styles.surfaceColor,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      viewModel.switchFindDevicesInNetworkBreak();
                    },
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.surfaceColor),
                    child: const Text("Zatrzymaj"),
                  ),
                ],
              ),
            ),
          ));
}
