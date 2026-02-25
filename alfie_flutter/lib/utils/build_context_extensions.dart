import 'package:flutter/material.dart';

/// Provides convenient shorthand access to frequently used [InheritedWidget]
/// data via the [BuildContext].
extension AppContextExtension on BuildContext {
  /// Shorthand for [Theme.of(context)].
  ThemeData get theme => Theme.of(this);

  /// Shorthand for [Theme.of(context).textTheme].
  TextTheme get textTheme => theme.textTheme;

  /// Shorthand for [MediaQuery.of(context)].
  MediaQueryData get mediaQuery => MediaQuery.of(this);
}
