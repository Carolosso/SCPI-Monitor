import 'package:flutter/material.dart';
import 'package:test/providers/screen_index_provider.dart';

BottomNavigationBar buildBottomNavBar(
    BuildContext context, ScreenIndexProvider siModel) {
  return BottomNavigationBar(
    selectedItemColor: Colors.black,
    currentIndex: siModel.screenIndex,
    showSelectedLabels: false,
    showUnselectedLabels: false,
    items: const [
      BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
      BottomNavigationBarItem(
          icon: Icon(Icons.perm_device_information), label: ''),
      //BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
    ],
    onTap: (value) => siModel.updateScreenIndex(value),
  );
}
