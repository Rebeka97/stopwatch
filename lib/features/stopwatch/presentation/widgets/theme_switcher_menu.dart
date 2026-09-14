import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class ThemeSwitcherMenu extends StatelessWidget {
  final AppThemeType currentTheme;
  final AppThemePalette palette;
  final ValueChanged<AppThemeType> onThemeSelected;

  const ThemeSwitcherMenu({
    super.key,
    required this.currentTheme,
    required this.palette,
    required this.onThemeSelected,
  });

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<AppThemeType>(
      initialValue: currentTheme,
      onSelected: onThemeSelected,
      color: palette.cardColor.withValues(alpha: 0.95),
      itemBuilder: (context) {
        final menuTextColor =
            ThemeData.estimateBrightnessForColor(palette.cardColor) ==
                    Brightness.dark
                ? Colors.white
                : Colors.black87;
        return AppThemeType.values
            .map((type) => PopupMenuItem<AppThemeType>(
                  value: type,
                  child: Text(
                    AppThemePalette.getThemeName(type),
                    style: TextStyle(color: menuTextColor),
                  ),
                ))
            .toList();
      },
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.palette, color: palette.textWhite, size: 18),
          const SizedBox(width: 6),
          Text(
            AppThemePalette.getThemeName(currentTheme),
            style: TextStyle(color: palette.textWhite, fontSize: 12),
          ),
          Icon(Icons.arrow_drop_down, color: palette.textWhite, size: 18),
        ],
      ),
    );
  }
}
