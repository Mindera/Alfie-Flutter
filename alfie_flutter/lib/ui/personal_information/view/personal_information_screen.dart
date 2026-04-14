import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:alfie_flutter/ui/personal_information/view_model/personal_information_view_model.dart';
import 'package:alfie_flutter/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PersonalInformationScreen extends ConsumerWidget {
  const PersonalInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(personalInformationViewModelProvider);

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
                  hintText: "Your First Name",
                  initialValue: user?.data.firstName,
                  validator: context.validateName,
                ),
                AppInputField(
                  "Last Name",
                  hintText: "Your Last Name",
                  initialValue: user?.data.lastName,
                  validator: context.validateName,
                ),
                AppInputField(
                  "Email",
                  hintText: "e.g. example@email.com",
                  initialValue: user?.data.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: context.validateEmail,
                ),
                AppInputField(
                  "Phone Number",
                  hintText: "e.g. 919 191 191",
                  initialValue: user?.data.phoneNumber,
                  keyboardType: TextInputType.phone,
                  validator: context.validatePhoneNumber,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
