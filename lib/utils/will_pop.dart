import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

Future<bool> onWillPop(BuildContext context) async {
  bool? exitResult = await showDialog(
    context: context,
    builder: (context) => buildExitDialog(context),
  );
  return exitResult ?? false;
}

Future<bool?> showExitDialog(BuildContext context) async {
  return await showDialog(
    context: context,
    builder: (context) => buildExitDialog(context),
  );
}

AlertDialog buildExitDialog(BuildContext context) {
  return AlertDialog(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(Styles.globalRadius)),
    ),
    title: const Text('Wyjście z aplikacji'),
    content: const Text('Czy chcesz wyjść z aplikacji?'),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(false),
        child: const Text('Nie'),
      ),
      TextButton(
        onPressed: () => Navigator.of(context).pop(true),
        child: const Text('Tak'),
      ),
    ],
  );
}
