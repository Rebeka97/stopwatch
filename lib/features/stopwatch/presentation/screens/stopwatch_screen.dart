import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/dimens.dart';
import '../../../../core/theme/theme_controller.dart';
import '../widgets/laps_list.dart';
import '../widgets/mechanical_pushers.dart';
import '../widgets/stopwatch_background.dart';
import '../widgets/stopwatch_controls.dart';
import '../widgets/theme_switcher_menu.dart';
import '../widgets/time_card.dart';

class StopwatchScreen extends StatefulWidget {
  final ThemeController themeController;

  const StopwatchScreen({super.key, required this.themeController});

  @override
  State<StopwatchScreen> createState() => _StopwatchScreenState();
}

class _StopwatchScreenState extends State<StopwatchScreen> {
  static const _tickInterval = Duration(milliseconds: 10);
  static const _highlightIntervalMinutes = 10;

  int milisec = 0;
  int counter = 0;
  int minutes = 0;
  Timer? timer;

  bool isRunning = false;
  bool highlightChange = false;

  final List<String> laps = [];

  String get formattedTime =>
      '${minutes.toString().padLeft(2, '0')} : ${counter.toString().padLeft(2, '0')} : ${milisec.toString().padLeft(2, '0')}';

  void increment() {
    if (isRunning) return;
    isRunning = true;

    timer = Timer.periodic(_tickInterval, (t) {
      if (!mounted) return;
      setState(() {
        if (highlightChange) {
          highlightChange = false;
        }

        milisec++;

        if (milisec == 100) {
          milisec = 0;
          counter++;

          if (counter == 60) {
            counter = 0;
            minutes++;
          }
        }
        highlightChange =
            minutes > 0 && minutes % _highlightIntervalMinutes == 0;
      });
    });
  }

  void pause() {
    if (!isRunning) return;
    timer?.cancel();
    setState(() {
      isRunning = false;
    });
  }

  void reset() {
    setState(() {
      milisec = 0;
      counter = 0;
      minutes = 0;
      timer?.cancel();
      isRunning = false;
      highlightChange = false;
      laps.clear();
    });
  }

  void lap() {
    if (!isRunning) return;
    setState(() {
      laps.insert(0, formattedTime);
    });
  }

  void deleteLaps() {
    setState(() {
      laps.clear();
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: widget.themeController,
      builder: (context, _) {
        final palette = widget.themeController.palette;

        final cardTextStyle = TextStyle(
          fontSize: StopwatchDimens.timeCardFontSize,
          fontWeight: FontWeight.bold,
          color: palette.numberColor,
          fontFamily: palette.numberFontFamily,
        );

        return Scaffold(
          extendBodyBehindAppBar: true,
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: IconThemeData(color: palette.textWhite),
            actions: [
              ThemeSwitcherMenu(
                currentTheme: widget.themeController.currentTheme,
                palette: palette,
                onThemeSelected: widget.themeController.setTheme,
              ),
              const SizedBox(width: StopwatchDimens.spacingSmall),
            ],
          ),
          body: Stack(
            children: [
              StopwatchBackground(palette: palette),
              SafeArea(
                child: SingleChildScrollView(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 10.0),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: StopwatchDimens.frameWidth,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                _StopwatchFrame(
                                  palette: palette,
                                  cardTextStyle: cardTextStyle,
                                  minutes: minutes,
                                  seconds: counter,
                                  milliseconds: milisec,
                                  highlightChange: highlightChange,
                                  onStart: increment,
                                  onPause: pause,
                                  onReset: reset,
                                  onLap: lap,
                                ),
                                Positioned(
                                  right: StopwatchDimens.pusherOffsetRight,
                                  top: StopwatchDimens.pusherTopOffset,
                                  child: MechanicalPushers(palette: palette),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: StopwatchDimens.spacingLarge),
                          LapsList(
                            laps: laps,
                            onDeleteLaps: deleteLaps,
                            palette: palette,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _StopwatchFrame extends StatelessWidget {
  final AppThemePalette palette;
  final TextStyle cardTextStyle;
  final int minutes;
  final int seconds;
  final int milliseconds;
  final bool highlightChange;
  final VoidCallback onStart;
  final VoidCallback onPause;
  final VoidCallback onReset;
  final VoidCallback onLap;

  const _StopwatchFrame({
    required this.palette,
    required this.cardTextStyle,
    required this.minutes,
    required this.seconds,
    required this.milliseconds,
    required this.highlightChange,
    required this.onStart,
    required this.onPause,
    required this.onReset,
    required this.onLap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: StopwatchDimens.frameWidth,
      padding: const EdgeInsets.symmetric(
        vertical: StopwatchDimens.framePaddingVertical,
        horizontal: StopwatchDimens.framePaddingHorizontal,
      ),
      decoration: BoxDecoration(
        color: palette.frameColor ?? palette.cardColor.withValues(alpha: 0.35),
        borderRadius: BorderRadius.circular(StopwatchDimens.frameBorderRadius),
        border: Border.all(
          color: palette.showFrameBorder
              ? palette.textWhite
                  .withValues(alpha: palette.isGlass ? 0.55 : 0.35)
              : Colors.transparent,
          width: StopwatchDimens.frameBorderWidth,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: StopwatchDimens.titlePillWidth,
            height: StopwatchDimens.titlePillHeight,
            decoration: BoxDecoration(
              color: palette.cardColor.withValues(alpha: 0.8),
              borderRadius:
                  BorderRadius.circular(StopwatchDimens.titlePillBorderRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Stopwatch',
                  style: TextStyle(
                    color: palette.textWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: StopwatchDimens.spacingXLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TimeCard(
                timeValue: minutes.toString().padLeft(2, '0'),
                label: 'MIN',
                displayStyle: cardTextStyle,
                highlightChange: highlightChange,
                palette: palette,
              ),
              TimeCard(
                timeValue: seconds.toString().padLeft(2, '0'),
                label: 'SEC',
                displayStyle: cardTextStyle,
                highlightChange: highlightChange,
                palette: palette,
              ),
              TimeCard(
                timeValue: milliseconds.toString().padLeft(2, '0'),
                label: 'MSEC',
                displayStyle: cardTextStyle,
                highlightChange: highlightChange,
                palette: palette,
              ),
            ],
          ),
          const SizedBox(height: StopwatchDimens.spacingXLarge),
          StopwatchControls(
            palette: palette,
            onStart: onStart,
            onPause: onPause,
            onReset: onReset,
            onLap: onLap,
          ),
        ],
      ),
    );
  }
}