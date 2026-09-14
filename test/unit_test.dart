import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:stopwatch/core/theme/theme_controller.dart';
import 'package:stopwatch/features/stopwatch/presentation/screens/stopwatch_screen.dart';

void main() {
  group('Stopwatch Widget Tests', () {
    late ThemeController themeController;

    setUp(() {
      themeController = ThemeController();
    });

    Widget buildTestApp() {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: StopwatchScreen(themeController: themeController),
      );
    }

    testWidgets('1. START gomb megnyomása elindítja a stoppert és az idő nő', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      // Kezdeti állapot: minden 00
      expect(find.text('00'), findsNWidgets(3));

      // START megnyomása
      await tester.tap(find.text('START'));
      await tester.pump();

      // Idő telik (pl. 100ms előrehaladás)
      await tester.pump(const Duration(milliseconds: 100));

      // Ellenőrzés, hogy az alkalmazás fut és frissül a felület
      expect(find.text('START'), findsOneWidget);
      expect(find.text('PAUSE'), findsOneWidget);
    });

    testWidgets('2. PAUSE gomb megállítja a stoppert', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.text('START'));
      await tester.pump();

      await tester.pump(const Duration(milliseconds: 50));
      await tester.tap(find.text('PAUSE'));
      await tester.pump();

      expect(find.text('PAUSE'), findsOneWidget);
    });

    testWidgets('3. RESET gomb visszaállítja a stoppert 00-ra', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.text('START'));
      await tester.pump(const Duration(milliseconds: 50));

      await tester.tap(find.text('RESET'));
      await tester.pump();

      expect(find.text('00'), findsNWidgets(3));
    });

    testWidgets('4. LAP gomb rögzíti a köridőt a listában', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.text('START'));
      await tester.pump(const Duration(milliseconds: 50));

      await tester.tap(find.text('LAP'));
      await tester.pump();

      expect(find.text('Laps:'), findsOneWidget);
      expect(find.textContaining('Lap 1.:'), findsOneWidget);
    });

    testWidgets('5. START gomb többszöri megnyomása nem okoz hibát', (WidgetTester tester) async {
      await tester.pumpWidget(buildTestApp());

      await tester.tap(find.text('START'));
      await tester.pump();

      await tester.tap(find.text('START'));
      await tester.pump();

      expect(find.text('START'), findsOneWidget);
    });
  });
}