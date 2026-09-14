import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/dimens.dart';

class MechanicalPushers extends StatelessWidget {
  final AppThemePalette palette;

  const MechanicalPushers({super.key, required this.palette});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildPusher(height: 55),
        const SizedBox(height: 55),
        _buildPusher(height: 35),
      ],
    );
  }

  Widget _buildPusher({required double height}) {
    // a keret üveges színét használjuk, ha van, hogy ne a világosabb kártyaszínbe olvadjon
    final pusherColor = palette.frameColor ?? palette.cardColor;
    return Container(
      width: StopwatchDimens.pusherWidth,
      height: height,
      decoration: BoxDecoration(
        color: pusherColor.withValues(alpha: 0.90),
        borderRadius: const BorderRadius.horizontal(
          right: Radius.circular(5),
        ),
        border: Border.all(
          color: palette.showFrameBorder
              ? palette.textWhite.withValues(alpha: 0.3)
              : Colors.transparent,
          width: 0.8,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.12),
            blurRadius: 3,
            offset: const Offset(1, 0),
          ),
        ],
      ),
    );
  }
}