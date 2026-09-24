import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/button_styles.dart';
import '../../../../core/theme/dimens.dart';

class StopwatchControls extends StatelessWidget {
  final AppThemePalette palette;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;
  final VoidCallback onLap;

  const StopwatchControls({
    super.key,
    required this.palette,
    required this.onStart,
    required this.onPause,
    required this.onReset,
    required this.onLap,
  });

  @override
  Widget build(BuildContext context) {
    final buttonTextStyle =
        TextStyle(color: palette.textWhite, fontWeight: FontWeight.bold);
    final isHome = identical(palette, AppThemePalette.home);
    final buttonStyle = isHome
        ? transparentButtonStyle(palette.textWhite)
        : softButtonStyle(palette.cardColor, palette.textWhite);

    final controls = Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: onStart,
              style: buttonStyle,
              child: Text('START', style: buttonTextStyle),
            ),
            const SizedBox(width: StopwatchDimens.spacingSmall),
            ElevatedButton(
              onPressed: onPause,
              style: buttonStyle,
              child: Text('PAUSE', style: buttonTextStyle),
            ),
            const SizedBox(width: StopwatchDimens.spacingSmall),
            ElevatedButton(
              onPressed: onReset,
              style: buttonStyle,
              child: Text('RESET', style: buttonTextStyle),
            ),
          ],
        ),
        const SizedBox(height: StopwatchDimens.spacingMedium),
        ElevatedButton(
          onPressed: onLap,
          style: buttonStyle,
          child: const Text('LAP',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
        ),
      ],
    );

    return controls;
  }
}