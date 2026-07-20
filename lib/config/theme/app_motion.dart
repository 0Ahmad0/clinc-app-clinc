import 'package:flutter/animation.dart';

/// Motion tokens. Short, calm entrances with a soft ease-out — defined once and
/// reused (never inline durations/curves in widgets).
class AppMotion {
  const AppMotion._();

  static const Duration fade = Duration(milliseconds: 450);
  static const Duration slide = Duration(milliseconds: 500);
  static const Duration quick = Duration(milliseconds: 350);

  /// cubic-bezier(.22, 1, .36, 1) — the emphasized ease-out from the system.
  static const Curve emphasized = Cubic(0.22, 1, 0.36, 1);
}
