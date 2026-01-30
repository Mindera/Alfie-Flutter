import 'package:flutter/material.dart';

class AppColors {
  // Private constructor to prevent instantiation
  const AppColors._();

  static const Color transparent = Colors.transparent;

  /// Neutrals: a grey scale that is used for the majority of UI elements.
  static const Color neutral = Color(0xFFFFFFFF);
  static const Color neutral100 = Color(0xFFF7F7F7);
  static const Color neutral200 = Color(0xFFE9E9E9);
  static const Color neutral300 = Color(0xFFCDCDCD);
  static const Color neutral400 = Color(0xFFA5A5A5);
  static const Color neutral500 = Color(0xFF767676);
  static const Color neutral600 = Color(0xFF4A4A4A);
  static const Color neutral700 = Color(0xFF2B2B2B);
  static const Color neutral800 = Color(0xFF111111);
  static const Color neutral900 = Color(0xFF000000);

  /// Semantic/Functional: to communicate error or success states.

  /// Error colors
  static const Color error100 = Color(0xFFFEF2F1);
  static const Color error200 = Color(0xFFF9DEDC);
  static const Color error300 = Color(0xFFE99FA2);
  static const Color error400 = Color(0xFFEB676D);
  static const Color error500 = Color(0xFFE03E40);
  static const Color error600 = Color(0xFFB22525);
  static const Color error700 = Color(0xFF952525);
  static const Color error800 = Color(0xFF770500);

  /// Success colors
  static const Color success100 = Color(0xFFEDF7E7);
  static const Color success200 = Color(0xFFD4EAC3);
  static const Color success300 = Color(0xFFA3CF82);
  static const Color success400 = Color(0xFF84C553);
  static const Color success500 = Color(0xFF60A62B);
  static const Color success600 = Color(0xFF48911F);
  static const Color success700 = Color(0xFF368316);
  static const Color success800 = Color(0xFF006201);
}
