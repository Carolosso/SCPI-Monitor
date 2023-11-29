import 'package:flutter/material.dart';
import 'package:test/providers/app_view_model.dart';
import 'package:test/style/theme.dart';

class StationItemEmpty extends StatelessWidget {
  const StationItemEmpty({
    super.key,
    required this.viewModel,
    required this.indexStation,
  });

  final AppViewModel viewModel;
  final int indexStation;
  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Styles.globalRadius),
        ),
        color: Styles.primaryColor,
        child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0, horizontal: 5),
            child: Column(
              children: [
                Text(
                  viewModel.getStationName(indexStation),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'Dodaj urządzenie w zakładce "Urządzenia"',
                    style: TextStyle(
                      color: Styles.surfaceColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                ),
              ],
            )));
  }
}
