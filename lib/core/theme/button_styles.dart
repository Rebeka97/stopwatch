import 'package:flutter/material.dart';
import 'dimens.dart';

/// Az alkalmazás összes gombja (START/PAUSE/RESET/LAP) ugyanazt a
/// "puha", téma-színezhető stílust használja; ezt egy helyen tartjuk,
/// hogy ne kelljen minden gombnál újra hardcode-olni.
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
