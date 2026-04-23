import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/ui/checkout/view/address_fields.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/checkbox/checkbox.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DeliveryInformationScreen extends HookConsumerWidget {
  const DeliveryInformationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final Address? existingDeliveryAddress = ref.watch(
      checkoutViewModelProvider.select((state) => state.deliveryAddress),
    );

    final Address? existingBillingAddress = ref.watch(
      checkoutViewModelProvider.select((state) => state.billingAddress),
    );

    final billingCheckbox = useState<bool>(
      existingBillingAddress == null ||
          existingDeliveryAddress == null ||
          existingBillingAddress == existingDeliveryAddress,
    );

    final deliveryAddress = useState<Address>(
      existingDeliveryAddress ?? Address.empty(),
    );
    final billingAddress = useState<Address>(
      existingBillingAddress ?? Address.empty(),
    );

    final isFormValid =
        deliveryAddress.value.isValid() &&
        (billingCheckbox.value || billingAddress.value.isValid());

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Delivery Indormation",
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
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: Spacing.small,
            vertical: Spacing.large,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            spacing: Spacing.large,
            children: [
              Column(
                spacing: Spacing.medium,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Address",
                    style: context.textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),
                  AddressFields(
                    address: deliveryAddress.value,
                    onChanged: (newAddress) =>
                        deliveryAddress.value = newAddress,
                  ),
                ],
              ),

              Column(
                spacing: Spacing.medium,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Delivery Address",
                    style: context.textTheme.headlineSmall,
                    textAlign: TextAlign.left,
                  ),

                  CheckboxTile(
                    label: "Same as delivery address",
                    initialValue: true,
                    onChanged: (value) => billingCheckbox.value = value,
                  ),
                  if (!billingCheckbox.value)
                    AddressFields(
                      address: billingCheckbox.value
                          ? deliveryAddress.value
                          : billingAddress.value,
                      onChanged: (newAddress) =>
                          billingAddress.value = newAddress,
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
              ref
                  .read(checkoutViewModelProvider.notifier)
                  .setDeliveryAddress(deliveryAddress.value);

              ref
                  .read(checkoutViewModelProvider.notifier)
                  .setBillingAddress(billingAddress.value);

              // context.goTo(AppRoute.deliveryInformation);
            },
          ),
        ),
      ),
    );
  }
}
