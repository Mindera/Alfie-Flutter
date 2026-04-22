import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
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
    final UserData? existingUserData = ref
        .watch(checkoutViewModelProvider)
        .userData;

    final formKey = useMemoized(() => GlobalKey<FormState>());

    final firstName = useState(existingUserData?.firstName ?? "");
    final lastName = useState(existingUserData?.lastName ?? "");
    final email = useState(existingUserData?.email ?? "");
    final phoneNumber = useState(existingUserData?.phoneNumber ?? "");

    final isFormValid =
        context.validateName(firstName.value) == null &&
        context.validateName(lastName.value) == null &&
        context.validateEmail(email.value) == null &&
        context.validatePhoneNumber(phoneNumber.value) == null;

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
                    autovalidateMode: AutovalidateMode.onUnfocus,
                    child: Column(
                      spacing: Spacing.small,
                      children: [
                        AppInputField(
                          "First Name",
                          validator: context.validateName,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => firstName.value = value,
                          initialValue: firstName.value,
                        ),
                        AppInputField(
                          "Last Name",
                          validator: context.validateName,
                          keyboardType: TextInputType.name,
                          onChanged: (value) => lastName.value = value,
                          initialValue: lastName.value,
                        ),
                        AppInputField(
                          "Email",
                          validator: context.validateEmail,
                          keyboardType: TextInputType.emailAddress,
                          onChanged: (value) => email.value = value,
                          initialValue: email.value,
                        ),
                        AppInputField(
                          "Phone Number",
                          validator: context.validatePhoneNumber,
                          keyboardType: TextInputType.phone,
                          onChanged: (value) => phoneNumber.value = value,
                          initialValue: phoneNumber.value,
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
            isDisabled: !isFormValid,
            onPressed: () {
              final newUser = UserData(
                firstName: firstName.value.trim(),
                lastName: lastName.value.trim(),
                email: email.value.trim(),
                phoneNumber: phoneNumber.value.trim(),
              );

              ref.read(checkoutViewModelProvider.notifier).setUser(newUser);

              context.goTo(AppRoute.deliveryInformation);
            },
          ),
        ),
      ),
    );
  }
}
