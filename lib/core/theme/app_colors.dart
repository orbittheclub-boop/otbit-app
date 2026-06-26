import 'package:flutter/material.dart';

/// Brand colors — extracted from the app icon's coral gradient. Identical in
/// light and dark. Neutral/surface colors live in [AppPalette] so they adapt.
abstract final class AppColors {
  // Extracted from the app icon (black background + soft pink "O").
  static const Color primary = Color(0xFFF0BCC4);
  static const Color primaryDark = Color(0xFFD98FA0);
  static const Color primaryLight = Color(0xFFF7DBE1);

  /// Text/icon color on top of [primary] — dark, matching the icon's black.
  static const Color onPrimary = Color(0xFF1A1416);

  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color danger = Color(0xFFEF4444);

  /// Brand gradient (pink shades), for hero / brand surfaces.
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF7DBE1), Color(0xFFE39FB1)],
  );
}

/// Theme-adaptive neutral palette. Access via `context.palette`.
@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  const AppPalette({
    required this.ink,
    required this.textSecondary,
    required this.textTertiary,
    required this.background,
    required this.surface,
    required this.border,
    required this.primarySoft,
  });

  final Color ink;
  final Color textSecondary;
  final Color textTertiary;
  final Color background;
  final Color surface;
  final Color border;
  final Color primarySoft;

  static const AppPalette light = AppPalette(
    ink: Color(0xFF191F28),
    textSecondary: Color(0xFF6B7684),
    textTertiary: Color(0xFFADB5BD),
    background: Color(0xFFFFFFFF),
    surface: Color(0xFFF7F8FA),
    border: Color(0xFFEAECEF),
    primarySoft: Color(0xFFFDEEF2),
  );

  static const AppPalette dark = AppPalette(
    ink: Color(0xFFF1F3F5),
    textSecondary: Color(0xFF9CA3AF),
    textTertiary: Color(0xFF6B7280),
    background: Color(0xFF121316),
    surface: Color(0xFF1C1E22),
    border: Color(0xFF2C2F36),
    primarySoft: Color(0x33F0BCC4),
  );

  @override
  AppPalette copyWith({
    Color? ink,
    Color? textSecondary,
    Color? textTertiary,
    Color? background,
    Color? surface,
    Color? border,
    Color? primarySoft,
  }) {
    return AppPalette(
      ink: ink ?? this.ink,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      background: background ?? this.background,
      surface: surface ?? this.surface,
      border: border ?? this.border,
      primarySoft: primarySoft ?? this.primarySoft,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      ink: Color.lerp(ink, other.ink, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      background: Color.lerp(background, other.background, t)!,
      surface: Color.lerp(surface, other.surface, t)!,
      border: Color.lerp(border, other.border, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
    );
  }
}

extension AppPaletteX on BuildContext {
  AppPalette get palette =>
      Theme.of(this).extension<AppPalette>() ?? AppPalette.light;
}
