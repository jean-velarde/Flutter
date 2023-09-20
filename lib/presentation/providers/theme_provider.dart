import 'package:flutter/material.dart';

class ThemeProviderColor extends ChangeNotifier {
  int themeColor = 0;

  Future<void> changeTheme() async {
    themeColor++;
    if (themeColor >= 7) {
      themeColor = 0;
    }
    notifyListeners();
  }
}
