import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/ui/checkout/view/add_new_card_modal.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/radio_button/radio_buttons.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/payement_card_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class PaymentMethodScreen extends HookConsumerWidget {
  final PaymentCard? initialValue;
  const PaymentMethodScreen({super.key, this.initialValue});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedCard = useState<PaymentCard?>(initialValue);

    final List<PaymentCard> cardsAvailable = [];
    final state = ref.watch(checkoutViewModelProvider);

    // if (!(state.user?.paymentCards.contains(PaymentCard.sample) ?? false)) {
    //   cardsAvailable.add(PaymentCard.sample);
    // }
    cardsAvailable.addAll(state.user?.paymentCards ?? []);

    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Payment",
          leading: AppButton.tertiary(
            leading: AppIcons.back,
            onPressed: () {
              context.safePop();
              if (selectedCard.value != null) {
                ref
                    .read(checkoutViewModelProvider.notifier)
                    .setPaymentMethod(selectedCard.value!);
              }
            },
          ),
        ),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RadioButtons(
              initialValue: selectedCard.value,
              options: cardsAvailable,
              labelBuilder: (card) => card.displayString(),
              iconBuilder: (card) => PaymentCardUtils.getCardIcon(card.type),
              radionOnRight: true,
              onChanged: (card) => selectedCard.value = card,
            ),
            ListTile(
              title: Column(
                spacing: Spacing.extraSmall,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [Text("Add new card")],
              ),
              leading: Image.asset(
                "assets/images/new_card.png",
                width: 56,
                fit: BoxFit.contain,
              ),
              onTap: () => showModalBottomSheet(
                context: context,
                builder: (context) => AddNewCardModal(),
                isDismissible: false,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
