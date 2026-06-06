import 'package:flutter/widgets.dart';

/// Spacing scale (8-based) used across the app for consistent layout rhythm.
///
/// Aligned with `docs/example/DESIGN.md` (base 8, container padding 24,
/// gutter 16, card gap 12, section margin 32).
abstract final class AppSpacing {
  /// 4dp.
  static const double xxs = 4;

  /// 8dp (base unit).
  static const double xs = 8;

  /// 12dp (card gap).
  static const double sm = 12;

  /// 16dp (gutter).
  static const double md = 16;

  /// 20dp.
  static const double lg = 20;

  /// 24dp (container padding).
  static const double xl = 24;

  /// 32dp (section margin).
  static const double xxl = 32;

  /// Card gap.
  static const double cardGap = 12;

  /// Section margin.
  static const double section = 32;

  /// Default screen padding.
  static const EdgeInsets screen = EdgeInsets.fromLTRB(xl, md, xl, xl);
}

/// Corner radius scale. Primary containers use extreme radii (24-32) for the
/// "friendly-tech" look; secondary elements use 8-16.
abstract final class AppRadii {
  /// Controls, icon tiles, inputs.
  static const double sm = 8;

  /// Inputs and small surfaces.
  static const double md = 16;

  /// Cards and primary containers.
  static const double lg = 24;

  /// Large/hero containers and bottom sheets.
  static const double xl = 32;

  /// Extra-large surfaces.
  static const double xxl = 48;

  /// Fully rounded pills.
  static const double pill = 999;
}
