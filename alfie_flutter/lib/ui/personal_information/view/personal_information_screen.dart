import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalInformationScreen extends ConsumerWidget {
  const PersonalInformationScreen({super.key});
  static final nameRegex = RegExp(r"^[a-zA-Z\s\-']{2,30}$");
  static final emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authRepositoryProvider);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(Spacing.small),
        child: Center(
          child: Form(
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppInputField(
                  "First Name",
                  hintText: user?.data.firstName ?? "First Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your first name';
                    }

                    if (!nameRegex.hasMatch(value)) {
                      return 'Please enter a valid name';
                    }

                    return null;
                  },
                ),
                AppInputField(
                  "Last Name",
                  hintText: user?.data.lastName ?? "Last Name",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }

                    if (!nameRegex.hasMatch(value)) {
                      return 'Please enter a valid name';
                    }

                    return null;
                  },
                ),
                AppInputField(
                  "Email",
                  hintText: user?.data.email ?? "Email",
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter an email';
                    }

                    if (!emailRegex.hasMatch(value)) {
                      return 'Please enter a valid email';
                    }

                    return null;
                  },
                ),
                AppInputField(
                  "Phone Number",
                  hintText: user?.data.phoneNumber ?? "Phone Number",
                  keyboardType: TextInputType.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a phone number';
                    }

                    if (!phoneRegex.hasMatch(value)) {
                      return 'Please enter a valid phone number';
                    }

                    return null;
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
