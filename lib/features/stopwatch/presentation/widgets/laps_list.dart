import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

class LapsList extends StatefulWidget {
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
  State<LapsList> createState() => _LapsListState();
}

class _LapsListState extends State<LapsList> {
  final ScrollController _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final laps = widget.laps;
    final palette = widget.palette;
    final onDeleteLaps = widget.onDeleteLaps;
    if (laps.isEmpty) return const SizedBox.shrink();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 280),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.max,
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
                  fontWeight: FontWeight.bold,
                ),
              ),
              IconButton(
                icon: Icon(
                  Icons.delete_sweep,
                  color: palette.textWhite,
                  size: 20,
                ),
                onPressed: onDeleteLaps,
                style: ButtonStyle(
                  foregroundColor: WidgetStateProperty.all(palette.textWhite),
                  overlayColor: WidgetStateProperty.all(Colors.transparent),
                ),
              ),
            ],
          ),
          Expanded(
            child: Scrollbar(
              controller: _scrollController,
              child: ListView.builder(
                controller: _scrollController,
                itemCount: laps.length,
                // A jobb oldali hely a görgetősávnak van fenntartva,
                // hogy ne lógjon rá az adatokra.
                padding: const EdgeInsets.only(right: 14),
                itemBuilder: (BuildContext context, int index) {
                  final lapNumber = laps.length - index;
                  final lapTime = laps[index];
                  final isLatestLap = index == 0;
                  final itemColor = isLatestLap
                      ? palette.latestLap
                      : palette.textWhite;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 3.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Lap $lapNumber.:',
                          style: TextStyle(
                            fontSize: 14,
                            color: itemColor,
                            fontWeight: isLatestLap
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                        Text(
                          lapTime,
                          style: TextStyle(
                            fontSize: 14,
                            color: itemColor,
                            fontWeight: isLatestLap
                                ? FontWeight.bold
                                : FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
