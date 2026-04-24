import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/radio_button/radio_buttons.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeliveryMethodScreen extends HookConsumerWidget {
  final DeliveryMethod? initialValue;
  const DeliveryMethodScreen({super.key, this.initialValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedOption = useState<DeliveryMethod?>(initialValue);
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Delivery Method",
          leading: AppButton.tertiary(
            leading: AppIcons.back,
            onPressed: () => context.safePop(),
          ),
        ),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: RadioButtons(
          initialValue: initialValue,
          options: DeliveryMethod.values,
          labelBuilder: (method) => method.label,
          radionOnRight: true,
          descriptionBuilder: (DeliveryMethod method) => method.description,
          onChanged: (method) => selectedOption.value = method,
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.symmetric(horizontal: Spacing.small),
          child: AppButton.primary(
            label: "Continue",
            isDisabled: selectedOption.value == null,
            onPressed: () {
              ref
                  .read(checkoutViewModelProvider.notifier)
                  .setDeliveryMethod(selectedOption.value!);

              context.safePop();
            },
          ),
        ),
      ),
    );
  }
}
