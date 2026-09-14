import 'package:flutter/material.dart';
import 'app_theme_type.dart';

/// Egy téma összes vizuális tulajdonságát leíró, immutable adatosztály.
///
/// Az egyes témák (lásd lentebb a static const mezőket) csak adatokat
/// definiálnak; a UI réteg sosem tartalmaz témánkénti hardcode-olt
/// elágazást (switch/if a téma típusára), hanem mindig a paletta
/// megfelelő mezőjét olvassa ki.
class AppThemePalette {
  final LinearGradient backgroundGradient;
  final Color cardColor;
  final Color textWhite;
  final Color highlightGreen;
  final Color latestLap;
  final bool isGlass;
  final String? backgroundImagePath;
  final bool blurBackground;
  final Color? frameColor;
  final bool showFrameBorder;

  /// Az óra számjegyeinek betűtípusa; null esetén az alapértelmezett marad.
  final String? numberFontFamily;

  /// Az óra számjegyeinek egyedi színe; null esetén [textWhite] érvényes.
  final Color? numberColorOverride;

  const AppThemePalette({
    required this.backgroundGradient,
    required this.cardColor,
    required this.textWhite,
    required this.highlightGreen,
    required this.latestLap,
    this.isGlass = false,
    this.backgroundImagePath,
    this.blurBackground = false,
    this.frameColor,
    this.showFrameBorder = true,
    this.numberFontFamily,
    this.numberColorOverride,
  });

  Color get bgSolid => backgroundGradient.colors.first;

  /// Az óra számjegyeinek ténylegesen alkalmazandó színe.
  Color get numberColor => numberColorOverride ?? textWhite;

  // 1. Pink
  static const pink = AppThemePalette(
    backgroundGradient: LinearGradient(
      colors: [Color(0xFFD9A0B3), Color(0xFFC48B9E)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardColor: Color(0xFFE2B0C2),
    textWhite: Colors.white,
    highlightGreen: Colors.greenAccent,
    latestLap: Color.fromARGB(255, 161, 66, 109),
  );

  // 2. Black and White
  static const blackAndWhite = AppThemePalette(
    backgroundGradient: LinearGradient(
      colors: [Color(0xFF141414), Color(0xFF141414)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    cardColor: Color.fromARGB(186, 39, 39, 39),
    textWhite: Color(0xFFEAEAEA),
    highlightGreen: Color(0xFFEAEAEA),
    latestLap: Color.fromARGB(255, 107, 103, 103),
    backgroundImagePath: 'assets/blackandwhite.jpg',
    frameColor: Color.fromARGB(167, 8, 8, 8),
    showFrameBorder: false,
    numberFontFamily: 'FragileBombers',
  );

  // 3. Autumn
  static const autumn = AppThemePalette(
    isGlass: true,
    backgroundGradient: LinearGradient(
      colors: [Color(0xFF5A4A41), Color(0xFF382D26)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardColor: Color.fromARGB(166, 156, 115, 74),
    textWhite: Color(0xFFF7EBE1),
    highlightGreen: Color(0xFFE0C4B2),
    latestLap: Color.fromARGB(255, 54, 40, 30),
    backgroundImagePath: 'assets/autumn.jpg',
    blurBackground: true,
    frameColor: Color(0xCC170D07),
    showFrameBorder: false,
    numberFontFamily: 'LeagueGothic',
  );

  // 4. Nature
  static const nature = AppThemePalette(
    backgroundGradient: LinearGradient(
      colors: [Color(0xFFF2ECE1), Color.fromARGB(255, 235, 222, 200)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardColor: Color(0xFF7C8F78),
    textWhite: Color.fromARGB(255, 91, 109, 87),
    highlightGreen: Color(0xFFB3C4AE),
    latestLap: Color(0xFF4A5C46),
    numberColorOverride: Color.fromARGB(255, 235, 221, 195),
  );

  // 5. Mermaid
  static const mermaid = AppThemePalette(
    isGlass: true,
    backgroundGradient: LinearGradient(
      colors: [
        Color(0xFFFCE6F4),
        Color(0xFFE2E6FF),
        Color(0xFFD3F7EE),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardColor: Color(0x66FFFFFF),
    textWhite: Color(0xFF31263E),
    highlightGreen: Color(0xFF38B2AC),
    latestLap: Color.fromARGB(255, 239, 96, 208),
    backgroundImagePath: 'assets/mermaid.jpg',
    blurBackground: true,
    showFrameBorder: false,
    numberFontFamily: 'HistoryOfWawa',
    numberColorOverride: Color.fromARGB(255, 250, 176, 208),
  );

  // 6. Galaxy
  static const galaxy = AppThemePalette(
    isGlass: true,
    backgroundGradient: LinearGradient(
      colors: [Color(0xFF140B10), Color(0xFF0F070B)],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    ),
    cardColor: Color.fromARGB(170, 23, 15, 19),
    textWhite: Colors.white,
    highlightGreen: Color(0xFFFF52A2),
    latestLap: Color.fromARGB(255, 255, 65, 160),
    backgroundImagePath: 'assets/galaxy.jpeg',
    frameColor: Color.fromARGB(146, 37, 19, 32),
    showFrameBorder: false,
    numberFontFamily: 'Orbitron',
  );

  // 7. Home
  static const home = AppThemePalette(
    isGlass: true,
    backgroundGradient: LinearGradient(
      colors: [Color(0xFFE4E9F2), Color(0xFFC8D1E0)],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    cardColor: Color(0x5AFFFFFF),
    textWhite: Color(0xFF1C2029),
    highlightGreen: Color(0xFF00B5D8),
    latestLap: Color(0xFF805AD5),
    backgroundImagePath: 'assets/home.jpg',
  );

  static const Map<AppThemeType, AppThemePalette> _palettes = {
    AppThemeType.pink: pink,
    AppThemeType.blackAndWhite: blackAndWhite,
    AppThemeType.autumn: autumn,
    AppThemeType.nature: nature,
    AppThemeType.mermaid: mermaid,
    AppThemeType.galaxy: galaxy,
    AppThemeType.home: home,
  };

  static const Map<AppThemeType, String> _themeNames = {
    AppThemeType.pink: 'Pink (Alap)',
    AppThemeType.blackAndWhite: 'B&W',
    AppThemeType.autumn: 'Autumn',
    AppThemeType.nature: 'Nature',
    AppThemeType.mermaid: 'Mermaid',
    AppThemeType.galaxy: 'Galaxy',
    AppThemeType.home: 'Home',
  };

  static AppThemePalette getPalette(AppThemeType type) => _palettes[type]!;

  static String getThemeName(AppThemeType type) => _themeNames[type]!;
}
