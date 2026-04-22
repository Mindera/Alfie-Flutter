import 'package:alfie_flutter/data/repositories/user_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/form_utils.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class IdentificationScreen extends HookConsumerWidget {
  const IdentificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = useState("");

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Identification",
          leading: AppButton.tertiary(
            leading: AppIcons.back,
            onPressed: () => context.safePop(),
          ),
        ),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.small,
            vertical: Spacing.large,
          ),
          child: Column(
            spacing: Spacing.medium,
            children: [
              SizedBox(
                width: double.maxFinite,
                child: Text(
                  "Sign In or Create Account",
                  style: context.textTheme.headlineSmall,
                  textAlign: TextAlign.left,
                ),
              ),
              AppInputField(
                "Email",
                onChanged: (value) {
                  email.value = value;
                },
              ),
              SizedBox(
                width: double.maxFinite,
                child: AppButton.primary(
                  label: "Continue",
                  onPressed: () {
                    if (context.validateEmail(email.value) == null) {
                      context.pushTo(
                        ref
                                .watch(userRepositoryProvider)
                                .isEmailRegistered(email.value)
                            ? AppRoute.signIn
                            : AppRoute.createAccount,
                        queryParams: {"email": email.value},
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("Please enter a valid email address."),
                        ),
                      );
                    }
                  },
                ),
              ),
              GestureDetector(
                onTap: () {},
                child: Text(
                  "CONTINUE AS GUEST",
                  style: context.textTheme.linkMedium,
                ),
              ),
              Row(
                spacing: Spacing.medium,
                children: [
                  Expanded(child: Divider()),
                  Text("or"),
                  Expanded(child: Divider()),
                ],
              ),
              SizedBox(
                width: double.maxFinite,
                child: AppButton.secondary(
                  leading: AppIcons.minus,
                  label: "Continue with Facebook",
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: AppButton.secondary(
                  leading: AppIcons.minus,
                  label: "Continue with Apple",
                  onPressed: () {},
                ),
              ),
              SizedBox(
                width: double.maxFinite,
                child: AppButton.secondary(
                  leading: AppIcons.minus,
                  label: "Continue with Google",
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
