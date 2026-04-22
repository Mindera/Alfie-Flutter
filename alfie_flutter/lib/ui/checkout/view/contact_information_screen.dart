import 'dart:developer';

import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/form_utils.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ContactInformationScreen extends HookConsumerWidget {
  const ContactInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    String firstName = "";
    String lastName = "";
    String email = "";
    String phoneNumber = "";

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Contact Info",
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                spacing: Spacing.medium,
                children: [
                  SizedBox(
                    width: double.maxFinite,
                    child: Text(
                      "Contact Details",
                      style: context.textTheme.headlineSmall,
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Form(
                    key: formKey,
                    child: Column(
                      spacing: Spacing.small,
                      children: [
                        AppInputField(
                          "First Name",
                          validator: context.validateName,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => firstName = value,
                        ),
                        AppInputField(
                          "Last Name",
                          validator: context.validateName,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => lastName = value,
                        ),
                        AppInputField(
                          "Email",
                          validator: context.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => email = value,
                          initialValue: email,
                        ),
                        AppInputField(
                          "Phone Number",
                          validator: context.validatePhoneNumber,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) => phoneNumber = value,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
          child: AppButton.primary(
            label: "Continue",
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (!isValid) return;

              final newUser = UserData(
                firstName: firstName.trim(),
                lastName: lastName.trim(),
                email: email.trim(),
                phoneNumber: phoneNumber.trim(),
              );

              log(newUser.toString());
            },
          ),
        ),
      ),
    );
  }
}
