import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginScreen extends ConsumerWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        child: Center(
          child: AppButton.primary(
            label: "Log in",
            onPressed: () {
              ref.read(authRepositoryProvider.notifier).login('alfie', 'pass');
            },
          ),
        ),
      ),
    );
  }
}
