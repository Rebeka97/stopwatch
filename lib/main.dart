import 'package:flutter/material.dart';
import 'core/theme/theme_controller.dart';
import 'features/stopwatch/presentation/screens/stopwatch_screen.dart';

void main() {
  runApp(StopwatchApp());
}

class StopwatchApp extends StatelessWidget {
  final ThemeController _themeController = ThemeController();

  StopwatchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StopwatchScreen(themeController: _themeController),
    );
  }
}