import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Sign In",
          leading: AppButton.tertiary(
            leading: AppIcons.back,
            onPressed: () => context.safePop(),
          ),
        ),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        centerTitle: true,
      ),
      body: SizedBox(
        width: double.maxFinite,
        child: Center(
          child: AppButton.primary(
            label: "Log in",
            onPressed: () {
              ref
                  .read(authRepositoryProvider.notifier)
                  .signIn('admin@alfie.com', 'pass');
            },
          ),
        ),
      ),
    );
  }
}
