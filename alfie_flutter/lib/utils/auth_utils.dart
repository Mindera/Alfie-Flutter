import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Provides authentication-aware UI utilities directly on the [BuildContext].
extension AuthUtils on BuildContext {
  /// Executes an [action] if the user is authenticated, otherwise redirects them
  /// to the authentication flow.
  ///
  /// *Engineering Note:* This method performs a synchronous read of [authRepositoryProvider].
  /// It should only be invoked inside event handlers (e.g., `onPressed`), never during `build`.
  void authAction(WidgetRef ref, VoidCallback action) {
    final isAuthenticated = ref.read(authRepositoryProvider) != null;

    if (isAuthenticated) {
      action();
    } else {
      goTo(AppRoute.auth);
    }
  }
}
