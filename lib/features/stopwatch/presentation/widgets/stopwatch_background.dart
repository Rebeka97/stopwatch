import 'dart:ui';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// A képernyő teljes hátterét rajzolja: gradienst vagy témaképet, illetve
/// (ha a paletta kéri) egy elmosó [BackdropFilter]-t a kép fölé.
class StopwatchBackground extends StatelessWidget {
  final AppThemePalette palette;

  const StopwatchBackground({super.key, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient:
                palette.backgroundImagePath == null
                    ? palette.backgroundGradient
                    : null,
            image: palette.backgroundImagePath != null
                ? DecorationImage(
                    image: AssetImage(palette.backgroundImagePath!),
                    fit: BoxFit.cover,
                  )
                : null,
          ),
        ),
        if (palette.backgroundImagePath != null && palette.blurBackground)
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
              child: Container(color: Colors.transparent),
            ),
          ),
      ],
    );
  }
}
