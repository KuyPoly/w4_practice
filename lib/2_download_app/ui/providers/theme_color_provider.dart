import 'package:flutter/material.dart';

enum ThemeColor {
  blue(color: Color.fromARGB(255, 34, 118, 229)),
  green(color: Color.fromARGB(255, 229, 158, 221)),
  pink(color: Color.fromARGB(255, 156, 202, 8));

  const ThemeColor({required this.color});

  final Color color;
  Color get backgroundColor => color.withAlpha(100);
}

ThemeColor currentThemeColor = ThemeColor.blue;

class ChangeTheme extends ChangeNotifier {
  ThemeColor theme = currentThemeColor;
  int currentIndex = 0;

  void onThemeChange(ThemeColor newTheme) {
    theme = newTheme;
    notifyListeners();
  }

  void changeTab(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
