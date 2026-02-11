import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Font families
const String _libreBaskerville = 'LibreBaskerville';

// Font weights
const FontWeight _regular = FontWeight.w400;
const FontWeight _medium = FontWeight.w500;

// Display typography (serif)
final _displayLarge = TextStyle(
  fontSize: 24,
  fontFamily: _libreBaskerville,
  fontWeight: _regular,
  height: 40 / 24,
  letterSpacing: 0,
);

final _displayMedium = TextStyle(
  fontSize: 20,
  fontFamily: _libreBaskerville,
  fontWeight: _regular,
  height: 32 / 20,
  letterSpacing: 0,
);

final _displaySmall = TextStyle(
  fontSize: 18,
  fontFamily: _libreBaskerville,
  fontWeight: _regular,
  height: 28 / 18,
  letterSpacing: 0,
);

// Headline typography (sans-serif, medium weight)
final _headlineLarge = TextStyle(
  fontSize: 32,
  fontWeight: _medium,
  height: 40 / 32,
  letterSpacing: 0,
);

final _headlineMedium = TextStyle(
  fontSize: 24,
  fontWeight: _medium,
  height: 32 / 24,
  letterSpacing: -0.5,
);

final _headlineSmall = TextStyle(
  fontSize: 20,
  fontWeight: _medium,
  height: 28 / 20,
  letterSpacing: -0.5,
);

// Body typography (sans-serif, regular weight)
final _bodyLarge = TextStyle(
  fontSize: 18,
  fontWeight: _regular,
  height: 28 / 18,
  letterSpacing: 0,
);

final _bodyMedium = TextStyle(
  fontSize: 16,
  fontWeight: _regular,
  height: 24 / 16,
  letterSpacing: 0,
);

final _bodySmall = TextStyle(
  fontSize: 12,
  fontWeight: _regular,
  height: 16 / 12,
  letterSpacing: 0,
);

// Label typography (sans-serif, regular weight)
final _labelSmall = TextStyle(
  fontSize: 12,
  fontWeight: _regular,
  height: 16 / 12,
  letterSpacing: 0,
);

/// Provides the [TextTheme] used throughout the application.
///
/// Defines a complete typography scale with display styles (serif),
/// headlines, body text, and labels with consistent line heights
/// and letter spacing for readable, cohesive text hierarchy.
final textThemeProvider = Provider<TextTheme>((ref) {
  return TextTheme(
    displayLarge: _displayLarge,
    displayMedium: _displayMedium,
    displaySmall: _displaySmall,
    headlineLarge: _headlineLarge,
    headlineMedium: _headlineMedium,
    headlineSmall: _headlineSmall,
    bodyLarge: _bodyLarge,
    bodyMedium: _bodyMedium,
    bodySmall: _bodySmall,
    labelSmall: _labelSmall,
  );
});

/// Extension on [TextTheme] providing semantic text style variants.
///
/// Offers convenience getters for common text style combinations used
/// throughout the app (bold, strikethrough, links) without needing to
/// manually compose style modifications.
extension ExtendedTextTheme on TextTheme {
  /// Returns [bodyMedium] with medium font weight (w500) for emphasis.
  TextStyle? get bodyMediumBold {
    return bodyMedium?.copyWith(fontWeight: _medium);
  }

  /// Returns [bodyMedium] with strikethrough decoration.
  TextStyle? get bodyMediumStrikethrough {
    return bodyMedium?.copyWith(decoration: TextDecoration.lineThrough);
  }

  /// Returns [labelSmall] with medium font weight (w500) for emphasis.
  TextStyle? get labelSmallBold {
    return labelSmall?.copyWith(fontWeight: _medium);
  }

  /// Returns [bodyMedium] styled as an interactive link.
  ///
  /// Combines medium weight with underline decoration to indicate
  /// interactive text following standard link conventions.
  TextStyle? get linkMedium {
    return bodyMedium?.copyWith(
      fontWeight: _medium,
      decoration: TextDecoration.underline,
    );
  }

  /// Returns [bodySmall] styled as an interactive link.
  ///
  /// Combines medium weight with underline decoration, using the
  /// smaller body size for compact link layouts.
  TextStyle? get linkSmall {
    return bodySmall?.copyWith(
      fontWeight: _medium,
      decoration: TextDecoration.underline,
    );
  }
}

extension TextThemeOfContext on BuildContext {
  TextTheme get textTheme => TextTheme.of(this);
}
