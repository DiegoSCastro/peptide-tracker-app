import 'package:flutter/widgets.dart';

/// Spacing scale (4-based) used across the app for consistent layout rhythm.
abstract final class AppSpacing {
  /// 4dp.
  static const double xxs = 4;

  /// 8dp.
  static const double xs = 8;

  /// 12dp.
  static const double sm = 12;

  /// 16dp.
  static const double md = 16;

  /// 20dp.
  static const double lg = 20;

  /// 24dp.
  static const double xl = 24;

  /// 32dp.
  static const double xxl = 32;

  /// Default screen padding.
  static const EdgeInsets screen = EdgeInsets.all(md);
}

/// Corner radius scale used for cards, sheets, and controls.
abstract final class AppRadii {
  /// Controls and small surfaces.
  static const double sm = 12;

  /// Medium surfaces.
  static const double md = 16;

  /// Cards.
  static const double lg = 20;

  /// Bottom sheets and large surfaces.
  static const double xl = 28;

  /// Fully rounded pills.
  static const double pill = 999;
}
