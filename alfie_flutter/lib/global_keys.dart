import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

/// Exposes a singleton [GlobalKey] to manage the root [ScaffoldMessengerState].
///
/// Allows services and ViewModels to dispatch snackbars and alerts without
/// requiring a direct [BuildContext].
final scaffoldMessengerKeyProvider = Provider((ref) {
  return GlobalKey<ScaffoldMessengerState>();
});

/// Exposes a singleton [GlobalKey] to manage the root [NavigatorState].
///
/// Permits context-free navigation and serves as the primary anchor for
/// the GoRouter configuration.
final navigatorKeyProvider = Provider((ref) {
  return GlobalKey<NavigatorState>(debugLabel: 'root');
});
