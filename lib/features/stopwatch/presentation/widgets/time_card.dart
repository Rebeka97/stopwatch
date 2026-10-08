import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/dimens.dart';

final Map<String, double> _digitWidthCache = {};

// A legszélesebb számjegy szélessége, hogy a kártya szélessége ne függjön a
// tartalomtól (nem minden betűtípus támogatja a táblázatos számjegyeket).
double _widestDigit(TextStyle style) {
  final key = '${style.fontFamily}|${style.fontSize}|${style.fontWeight}';
  return _digitWidthCache.putIfAbsent(key, () {
    var widest = 0.0;
    for (var d = 0; d < 10; d++) {
      final painter = TextPainter(
        text: TextSpan(text: '$d', style: style),
        textDirection: TextDirection.ltr,
      )..layout();
      widest = math.max(widest, painter.width);
      painter.dispose();
    }
    return widest;
  });
}

class TimeCard extends StatelessWidget {
  final String timeValue;
  final String label;
  final TextStyle displayStyle;
  final bool highlightChange;
  final AppThemePalette palette;

  const TimeCard({
    super.key,
    required this.timeValue,
    required this.label,
    required this.displayStyle,
    required this.highlightChange,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    final effectiveStyle = highlightChange
        ? displayStyle.copyWith(color: palette.highlightGreen)
        : displayStyle;
    final isHome = identical(palette, AppThemePalette.home);
    final cardWidth = math.max(
      StopwatchDimens.timeCardMinWidth,
      // 24: belső padding, 10: külső margó
      _widestDigit(displayStyle) * timeValue.length + 34.0,
    );
    return SizedBox(
      width: cardWidth,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        decoration: isHome
            ? null
            : BoxDecoration(
                color: palette.cardColor.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(
                  StopwatchDimens.timeCardBorderRadius,
                ),
              ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              timeValue,
              style: effectiveStyle,
              maxLines: 1,
              softWrap: false,
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.bold,
                color: palette.textWhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
