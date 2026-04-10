import 'package:alfie_flutter/ui/auth/view_model/auth_view_model.dart';
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
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
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
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Padding(
          padding: const EdgeInsets.all(Spacing.small),
          child: Form(
            key: formKey,
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
                      obscureText: true,
                      onChanged: (value) {
                        password = value;
                      },
                      validator: context.validatePassword,
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
                        if (formKey.currentState == null) return;

                        if (!formKey.currentState!.validate()) return;

                        final success = ref
                            .read(authViewModelProvider.notifier)
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
      ),
    );
  }
}
