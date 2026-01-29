import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final appButtonThemeProvider = Provider<AppButtonTheme>(
  (ref) => AppButtonTheme(
    primary: ButtonStyle(),
    secondary: ButtonStyle(),
    tertiary: ButtonStyle(),
    destructive: ButtonStyle(),
  ),
);

class AppButtonTheme extends ThemeExtension<AppButtonTheme> {
  final ButtonStyle? primary;
  final ButtonStyle? secondary;
  final ButtonStyle? tertiary;
  final ButtonStyle? destructive;

  const AppButtonTheme({
    this.primary,
    this.secondary,
    this.tertiary,
    this.destructive,
  });

  @override
  AppButtonTheme copyWith({
    ButtonStyle? primary,
    ButtonStyle? secondary,
    ButtonStyle? tertiary,
    ButtonStyle? destructive,
  }) {
    return AppButtonTheme(
      primary: primary ?? this.primary,
      secondary: secondary ?? this.secondary,
      tertiary: tertiary ?? this.tertiary,
      destructive: destructive ?? this.destructive,
    );
  }

  @override
  AppButtonTheme lerp(ThemeExtension<AppButtonTheme>? other, double t) {
    if (other is! AppButtonTheme) return this;
    return AppButtonTheme(
      primary: ButtonStyle.lerp(primary, other.primary, t),
      secondary: ButtonStyle.lerp(secondary, other.secondary, t),
      tertiary: ButtonStyle.lerp(tertiary, other.tertiary, t),
      destructive: ButtonStyle.lerp(destructive, other.destructive, t),
    );
  }
}
