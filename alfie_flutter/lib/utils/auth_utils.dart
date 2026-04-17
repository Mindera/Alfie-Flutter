import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AuthUtils on BuildContext {
  void authAction(WidgetRef ref, VoidCallback action) {
    final isAuthenticated = ref.read(authRepositoryProvider) != null;

    if (isAuthenticated) {
      action();
    } else {
      goTo(AppRoute.auth);
    }
  }
}
