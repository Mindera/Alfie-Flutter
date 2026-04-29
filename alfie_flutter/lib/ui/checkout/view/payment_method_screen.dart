import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/ui/checkout/view/add_new_card_modal.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/ui/core/ui/radio_button/radio_buttons.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:alfie_flutter/utils/payement_card_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class PaymentMethodScreen extends HookWidget {
  const PaymentMethodScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedCard = useState<PaymentCard?>(null);
    final List<PaymentCard> cardsAvailable = [PaymentCard.sample];
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Payment",
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
            RadioButtons(
              options: ["Add new Card"],
              onChanged: (_) => showModalBottomSheet(
                context: context,
                builder: (context) => AddNewCardModal(),
                isDismissible: false,
              ),
              radionOnRight: true,
              labelBuilder: (_) => "Add new card",
              iconBuilder: (_) => Image.asset(
                "assets/images/new_card.png",
                width: 56,
                fit: BoxFit.contain,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
