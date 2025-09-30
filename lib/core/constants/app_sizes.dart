import 'package:flutter/widgets.dart';

class AppSpacing {
  static const double xs = 4;
  static const double sm = 8;
  static const double md = 12;
  static const double lg = 16;
  static const double xl = 20;
  static const double xxl = 24;

  static const EdgeInsets page = EdgeInsets.symmetric(
    horizontal: lg,
    vertical: md,
  );
  static const EdgeInsets section = EdgeInsets.symmetric(vertical: lg);
  static const EdgeInsets card = EdgeInsets.all(lg);
  static const EdgeInsets compactCard = EdgeInsets.all(md);
  static const EdgeInsets listTile = EdgeInsets.symmetric(
    horizontal: md,
    vertical: sm,
  );

  static const BorderRadius borderRadius = BorderRadius.all(
    Radius.circular(12),
  );
  static const BorderRadius chipRadius = BorderRadius.all(Radius.circular(10));
}
