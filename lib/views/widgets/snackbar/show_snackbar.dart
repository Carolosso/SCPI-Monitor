import 'package:flutter/material.dart';
import 'package:test/style/theme.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(
    BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    behavior: SnackBarBehavior.floating,
    content: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
    backgroundColor: Colors.black,
    duration: const Duration(milliseconds: 1800),
    shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(Styles.globalRadius))),
  ));
}
