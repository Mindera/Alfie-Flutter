import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/global_keys.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/snack_bar.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/form_utils.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInScreen extends ConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    String email = '';
    String password = '';

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
      body: Padding(
        padding: const EdgeInsets.all(Spacing.small),
        child: Form(
          autovalidateMode: AutovalidateMode.onUnfocus,

          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: Spacing.medium,
                children: [
                  AppInputField(
                    "Email",
                    keyboardType: TextInputType.emailAddress,
                    validator: context.validateEmail,
                    onChanged: (value) {
                      email = value;
                    },
                  ),
                  AppInputField(
                    "Password",
                    onChanged: (value) {
                      password = value;
                    },
                  ),
                  GestureDetector(
                    child: Text(
                      "Forgot password?",
                      style: context.textTheme.linkMedium,
                    ),
                    onTap: () {},
                  ),
                ],
              ),
              SafeArea(
                child: SizedBox(
                  width: double.maxFinite,
                  child: AppButton.primary(
                    label: "Log in",
                    onPressed: () {
                      final success = ref
                          .read(authRepositoryProvider.notifier)
                          .signIn(email, password);

                      if (!success) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          AppSnackBar.build(
                            context: context,
                            infoText: 'Invalid email or password',
                            messengerKey: ref.watch(
                              scaffoldMessengerKeyProvider,
                            ),
                          ),
                        );
                      } else {
                        context.goTo(AppRoute.account);
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
