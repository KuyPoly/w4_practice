import 'package:flutter/material.dart';

import 'ui/providers/theme_color_provider.dart';
import 'ui/screens/settings/settings_screen.dart';
import 'ui/screens/downloads/downloads_screen.dart';
import 'ui/theme/theme.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
   MyApp({super.key});
  final ChangeTheme currentThemeColor = ChangeTheme();

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: currentThemeColor,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: appTheme,
          home: Home(notifier: currentThemeColor),
        );
      },
    );
  }
}

class Home extends StatelessWidget {
  const Home({super.key, required this.notifier});
  final ChangeTheme notifier;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      DownloadsScreen(themeNotifier: notifier),
      SettingsScreen(themeNotifer: notifier),
    ];
    return Scaffold(
      body: pages[notifier.currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: notifier.currentIndex,
        onTap: (index) {
          notifier.changeTab(index);
        },
        selectedItemColor: notifier.theme.color,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Downloads'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Settings'),
        ],
      ),
    );
  }
}
