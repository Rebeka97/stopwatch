import 'package:flutter/material.dart';
import 'dimens.dart';

ButtonStyle softButtonStyle(Color backgroundColor, Color foregroundColor) {
  return ElevatedButton.styleFrom(
    backgroundColor: backgroundColor.withValues(alpha: 0.85),
    foregroundColor: foregroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(StopwatchDimens.buttonBorderRadius),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    elevation: 3,
    shadowColor: Colors.black.withValues(alpha: 0.12),
  );
}

/// Button with no fill or shadow, just text, so it sits directly on a background image.
ButtonStyle transparentButtonStyle(Color foregroundColor) {
  return ElevatedButton.styleFrom(
    backgroundColor: Colors.transparent,
    foregroundColor: foregroundColor,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(StopwatchDimens.buttonBorderRadius),
    ),
    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
    elevation: 0,
    shadowColor: Colors.transparent,
  );
}
