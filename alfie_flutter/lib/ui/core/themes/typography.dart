import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final textThemeProvider = Provider<TextTheme>((ref) {
  return TextTheme(
    //Display
    displayLarge: TextStyle(
      fontSize: 24,
      fontFamily: 'LibreBaskerville',
      fontWeight: FontWeight.w400,
      height: 40 / 24,
      letterSpacing: 0,
    ),
    displayMedium: TextStyle(
      fontSize: 20,
      fontFamily: 'LibreBaskerville',
      fontWeight: FontWeight.w400,
      height: 32 / 20,
      letterSpacing: 0,
    ),
    displaySmall: TextStyle(
      fontSize: 18,
      fontFamily: 'LibreBaskerville',
      fontWeight: FontWeight.w400,
      height: 28 / 18,
      letterSpacing: 0,
    ),

    //// Headings
    headlineLarge: TextStyle(
      fontSize: 32,
      fontWeight: FontWeight.w500,
      height: 40,
      letterSpacing: 0,
    ),
    headlineMedium: TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.w500,
      height: 32,
      letterSpacing: -0.5,
    ),
    headlineSmall: TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w500,
      height: 28,
      letterSpacing: -0.5,
    ),

    // Body Text
    bodyLarge: TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w400,
      height: 28 / 18,
      letterSpacing: 0,
    ),
    bodyMedium: TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.w400,
      height: 24 / 16,
      letterSpacing: 0,
    ),
    bodySmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      letterSpacing: 0,
    ),

    // Labels
    labelSmall: TextStyle(
      fontSize: 12,
      fontWeight: FontWeight.w400,
      height: 16 / 12,
      letterSpacing: 0,
    ),
  );
});

extension ExtendedTextTheme on TextTheme {
  TextStyle? get bodyMediumBold {
    return bodyMedium?.copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle? get bodyMediumStrikethrough {
    return bodyMedium?.copyWith(decoration: TextDecoration.lineThrough);
  }

  TextStyle? get labelSmallBold {
    return labelSmall?.copyWith(fontWeight: FontWeight.w500);
  }

  TextStyle? get linkMedium {
    return bodyMedium?.copyWith(
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
    );
  }

  TextStyle? get linkSmall {
    return bodySmall?.copyWith(
      fontWeight: FontWeight.w500,
      decoration: TextDecoration.underline,
    );
  }
}
