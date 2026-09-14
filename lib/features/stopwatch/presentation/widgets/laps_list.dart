import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LapsList extends StatelessWidget {
  final List<String> laps;
  final VoidCallback onDeleteLaps;
  final AppThemePalette palette;

  const LapsList({
    super.key,
    required this.laps,
    required this.onDeleteLaps,
    required this.palette,
  });

  @override
  Widget build(BuildContext context) {
    if (laps.isEmpty) return const SizedBox.shrink();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Column(
        children: [
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Laps:',
                style: TextStyle(
                    fontSize: 16,
                    color: palette.textWhite,
                    fontWeight: FontWeight.bold),
              ),
              IconButton(
                icon: Icon(Icons.delete_sweep,
                    color: palette.textWhite, size: 20),
                onPressed: onDeleteLaps,
                style: ButtonStyle(
                  foregroundColor:
                      WidgetStateProperty.all(palette.textWhite),
                  overlayColor:
                      WidgetStateProperty.all(Colors.transparent),
                ),
              ),
            ],
          ),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                for (int index = 0; index < laps.length; index++)
                  Builder(builder: (context) {
                    final lapNumber = laps.length - index;
                    final lapTime = laps[index];
                    final isLatestLap = index == 0;
                    final itemColor =
                        isLatestLap ? palette.latestLap : palette.textWhite;

                    final row = Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lap $lapNumber.:',
                          style: TextStyle(
                              fontSize: 14,
                              color: itemColor,
                              fontWeight: isLatestLap
                                  ? FontWeight.bold
                                  : FontWeight.w500),
                        ),
                        Text(
                          lapTime,
                          style: TextStyle(
                              fontSize: 14,
                              color: itemColor,
                              fontWeight: isLatestLap
                                  ? FontWeight.bold
                                  : FontWeight.w500),
                        ),
                      ],
                    );

                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 3.0),
                      child: row,
                    );
                  }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}