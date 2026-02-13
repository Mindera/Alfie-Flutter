import 'package:flutter/material.dart';

extension ThemeExtension on BuildContext {
  ThemeData get theme {
    return Theme.of(this);
  }

  TextTheme get textTheme => TextTheme.of(this);

  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
