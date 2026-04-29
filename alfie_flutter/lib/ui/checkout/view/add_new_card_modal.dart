import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/form_utils.dart';
import 'package:alfie_flutter/utils/input_formatters.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/payement_card_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AddNewCardModal extends HookWidget {
  const AddNewCardModal({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey = useMemoized(() => GlobalKey<FormState>());
    final card = useState<PaymentCard>(PaymentCard.sample);
    return Padding(
      padding: const EdgeInsets.all(
        Spacing.small,
      ).add(context.mediaQuery.padding + context.mediaQuery.viewInsets),
      child: Form(
        key: formKey,
        autovalidateMode: AutovalidateMode.onUnfocus,
        child: SingleChildScrollView(
          child: Column(
            spacing: Spacing.medium,
            children: [
              Header(
                title: "Add new vard",
                leading: AppButton.tertiary(
                  leading: AppIcons.close,
                  onPressed: () => context.safePop(),
                ),
              ),
              Column(
                spacing: Spacing.small,
                children: [
                  AppInputField(
                    "Card Number",
                    keyboardType: TextInputType.number,
                    validator: context.validateCardNumber,
                    onChanged: (value) => card.value = card.value.copyWith(
                      number: PaymentCardUtils.getCleanedNumber(value),
                    ),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(19),
                      CardNumberInputFormatter(),
                    ],
                  ),

                  AppInputField(
                    "Name on card",
                    keyboardType: TextInputType.text,
                    validator: (String? value) =>
                        value!.isEmpty ? "This field is required" : null,
                    onChanged: (value) =>
                        card.value = card.value.copyWith(name: value),
                  ),

                  Row(
                    spacing: Spacing.small,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: AppInputField(
                          "Expiry Date",
                          validator: context.validateDate,
                          keyboardType: TextInputType.datetime,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                            CardMonthInputFormatter(),
                          ],
                          onChanged: (value) {
                            final expiryDate = PaymentCardUtils.getExpiryDate(
                              value,
                            );
                            if (expiryDate != null) {
                              card.value = card.value.copyWith(
                                month: expiryDate[0],
                                year: expiryDate[1],
                              );
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: AppInputField(
                          "CVV",
                          validator: context.validateCVV,
                          keyboardType: TextInputType.number,
                          onChanged: (value) {
                            if (value.isEmpty) return;
                            card.value = card.value.copyWith(
                              cvv: int.parse(value),
                            );
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            LengthLimitingTextInputFormatter(4),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(
                width: double.maxFinite,
                child: AppButton.primary(label: "Continue", onPressed: () {}),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
