import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/auth/view_model/auth_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/checkbox/checkbox.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:alfie_flutter/utils/form_utils.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class CreateAccountScreen extends HookConsumerWidget {
  const CreateAccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final firstName = useState<String?>(null);
    final lastName = useState<String?>(null);
    final email = useState<String?>(null);
    final password = useState<String?>(null);
    final phone = useState<String?>(null);
    final acceptedTerms = useState<bool>(false);
    final wantsNewsletter = useState<bool>(false);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Create Account",
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
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            autovalidateMode: AutovalidateMode.onUnfocus,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  spacing: Spacing.medium,
                  children: [
                    AppInputField(
                      "First Name",
                      validator: context.validateName,
                      keyboardType: TextInputType.name,
                      onChanged: (value) => firstName.value = value,
                    ),
                    AppInputField(
                      "Last Name",
                      validator: context.validateName,
                      keyboardType: TextInputType.name,
                      onChanged: (value) => lastName.value = value,
                    ),
                    AppInputField(
                      "Email",
                      validator: context.validateEmail,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: (value) => email.value = value,
                    ),
                    AppInputField(
                      "Password",
                      obscureText: true,
                      validator: context.validatePassword,
                      onChanged: (value) => password.value = value,
                    ),
                    AppInputField(
                      "Phone Number",
                      validator: context.validatePhoneNumber,
                      keyboardType: TextInputType.phone,
                      onChanged: (value) => phone.value = value,
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      spacing: Spacing.small,
                      children: [
                        CheckboxTile(
                          initialValue: false,
                          leftCheckbox: true,
                          label:
                              r"I've read and agreed with User Terms and Conditions of Service.",
                          onChanged: (value) =>
                              acceptedTerms.value = value ?? false,
                          validator: context.validateCheckbox,
                        ),
                        CheckboxTile(
                          initialValue: false,
                          leftCheckbox: true,
                          label:
                              r"I want to receive news and special offers via email.",
                          onChanged: (value) =>
                              wantsNewsletter.value = value ?? false,
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(Spacing.small),
          child: AppButton.primary(
            label: "Create Account",
            onPressed: () {
              final isValid = formKey.currentState!.validate();
              if (!isValid) return;

              try {
                final newUser = UserData(
                  firstName: firstName.value!.trim(),
                  lastName: lastName.value!.trim(),
                  email: email.value!.trim(),
                  phoneNumber: phone.value!.trim(),
                );

                ref.read(authViewModelProvider.notifier).createAccount(newUser);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Account created successfully!'),
                  ),
                );

                context.safePop();
              } catch (e) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Could not create account: ${e.toString()}'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
