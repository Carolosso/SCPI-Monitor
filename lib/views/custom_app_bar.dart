import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar(
      {super.key,
      required this.title,
      required this.showAction,
      required this.showLeading,
      required this.onActionTap});

  final String title;
  final bool showAction;
  final bool showLeading;
  final VoidCallback onActionTap;

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
