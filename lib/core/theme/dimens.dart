/// Az óra képernyőjén használt, ismétlődő layout-méretek egy helyen,
/// hogy elkerüljük a hardcode-olt "magic number"-eket a widgetekben.
class StopwatchDimens {
  StopwatchDimens._();

  /// A fő óralap (keret) szélessége és lekerekítése.
  static const double frameWidth = 320;
  static const double frameBorderRadius = 24;
  static const double frameBorderWidth = 1.5;
  static const double framePaddingVertical = 20;
  static const double framePaddingHorizontal = 16;

  /// A "Stopwatch" felirat pirula mérete.
  static const double titlePillWidth = 240;
  static const double titlePillHeight = 38;
  static const double titlePillBorderRadius = 20;

  /// A MIN/SEC/MSEC kijelzők minimum szélessége és lekerekítése.
  static const double timeCardMinWidth = 70;
  static const double timeCardBorderRadius = 14;
  static const double timeCardFontSize = 34;

  /// A kerethez illesztett mechanikus gombok pozíciója/mérete.
  static const double pusherOffsetRight = -14;
  static const double pusherTopOffset = 50;
  static const double pusherWidth = 14;

  /// Gombok lekerekítése.
  static const double buttonBorderRadius = 15;

  static const double spacingSmall = 8;
  static const double spacingMedium = 15;
  static const double spacingLarge = 20;
  static const double spacingXLarge = 25;
}
