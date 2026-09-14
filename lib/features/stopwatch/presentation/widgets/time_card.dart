import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/dimens.dart';

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
    return ConstrainedBox(
      constraints:
          const BoxConstraints(minWidth: StopwatchDimens.timeCardMinWidth),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 12.0),
        decoration: BoxDecoration(
          color: palette.cardColor.withValues(alpha: 0.8),
          borderRadius:
              BorderRadius.circular(StopwatchDimens.timeCardBorderRadius),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(timeValue, style: effectiveStyle),
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