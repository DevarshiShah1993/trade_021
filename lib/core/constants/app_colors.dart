import 'package:flutter/material.dart';

/// Color constants shared across widgets.
///
/// Per project preference these are *not* wired into a ThemeData; widgets
/// read them directly. Keeps the call site explicit.
class AppColors {
  AppColors._();

  static const Color background = Colors.white;
  static const Color surface = Color(0xFFF5F5F5);
  static const Color divider = Color(0xFFE6E6E6);
  static const Color primaryText = Color(0xFF111111);
  static const Color secondaryText = Color(0xFF7A7A7A);
  static const Color accent = Color(0xFF111111);

  // Trading semantic colors (matched to demo).
  static const Color up = Color(0xFF1B7A2C);
  static const Color down = Color(0xFFD32F2F);
  static const Color neutral = Color(0xFF111111);
}
