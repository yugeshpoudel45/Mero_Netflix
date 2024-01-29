import 'package:flutter/material.dart';
import 'package:netflix/config/app_constants.dart';
import 'package:netflix/pages/6.Inside_home_pages/new_releases_page.dart';
import 'package:netflix/pages/6.Inside_home_pages/notification_page.dart';
import 'package:netflix/themes/dark_theme.dart';
import 'package:netflix/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}
//TODO add the preserve and remove the native splash screen here, and also remove it after initialization.

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.light,
      // themeMode: ThemeMode.dark,
      title: AppConstants.appName,
      theme: lightTheme,
      darkTheme: darkTheme,
      // home: const NewReleasesPage(),
      home: const NotificationPage(),
    );
  }
}

//padding: const EdgeInsets.symmetric(horizontal: 16),

//Red Color
//Ff0000

//Netflix Color:
//E50914
