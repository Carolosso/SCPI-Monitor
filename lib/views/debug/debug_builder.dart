import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

class DebugBuilder extends StatelessWidget {
  const DebugBuilder({
    super.key,
    required this.viewModel,
  });

  final AppViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    TextEditingController queryTextController = TextEditingController();
    TextEditingController ipTextController = TextEditingController();
    TextEditingController portTextController = TextEditingController();
    return SingleChildScrollView(
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              TextField(
                controller: ipTextController,
                onSubmitted: (value) {
                  // onSubmit(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Styles.globalRadius),
                    ),
                    contentPadding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    filled: true,
                    //fillColor: viewModel.clrlvl2,
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Styles.globalRadius),
                        borderSide: BorderSide(color: Styles.surfaceColor)),
                    labelText: ' IP ',
                    labelStyle: TextStyle(color: Styles.primaryColor)),
                // autofocus: true,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                autocorrect: false,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: portTextController,
                keyboardType: TextInputType.number,
                onSubmitted: (value) {
                  // onSubmit(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Styles.globalRadius),
                    ),
                    contentPadding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    filled: true,
                    //fillColor: viewModel.clrlvl2,
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Styles.globalRadius),
                        borderSide: BorderSide(color: Styles.surfaceColor)),
                    labelText: ' Port ',
                    labelStyle: TextStyle(color: Styles.primaryColor)),
                // autofocus: true,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                autocorrect: false,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () => viewModel.debugConnectPressed(
                        ipTextController.text, portTextController.text),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Styles.surfaceColor),
                    child: const SizedBox(
                      width: 100,
                      child: Text(
                        "Connect",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () => viewModel.debugDisconnectPressed(),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.red.shade400),
                    child: const SizedBox(
                      width: 100,
                      child: Text(
                        "Disconnect",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              TextField(
                controller: queryTextController,
                onSubmitted: (value) {
                  // onSubmit(value);
                },
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(Styles.globalRadius),
                    ),
                    contentPadding: const EdgeInsets.only(
                      bottom: 5,
                    ),
                    filled: true,
                    //fillColor: viewModel.clrlvl2,
                    focusedBorder: OutlineInputBorder(
                        borderRadius:
                            BorderRadius.circular(Styles.globalRadius),
                        borderSide: BorderSide(color: Styles.surfaceColor)),
                    labelText: ' Query ',
                    labelStyle: TextStyle(color: Styles.primaryColor)),
                // autofocus: true,
                textAlign: TextAlign.center,
                textAlignVertical: TextAlignVertical.center,
                autocorrect: false,
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () =>
                      viewModel.debugQueryPressed(queryTextController.text),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Styles.surfaceColor),
                  child: const SizedBox(
                    width: 100,
                    child: Text(
                      "Send",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              SizedBox(
                child: Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: Styles.primaryColor,
                      borderRadius: BorderRadius.circular(Styles.globalRadius)),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      viewModel.debugRegister,
                      style: TextStyle(color: Styles.surfaceColor),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  onPressed: () => viewModel.debugClearPressed(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Styles.surfaceColor),
                  child: const SizedBox(
                    width: 100,
                    child: Text(
                      "Clear",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
