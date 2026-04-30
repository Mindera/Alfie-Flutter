import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class OrderConfirmationScreen extends ConsumerWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        leading: AppButton.tertiary(
          leading: AppIcons.close,
          onPressed: () {
            ref.read(checkoutViewModelProvider.notifier).clearCheckoutState();
            context.goTo(AppRoute.home);
          },
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
          vertical: Spacing.extraSmall,
          horizontal: Spacing.small,
        ),
        child: Column(
          spacing: Spacing.small,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Thank you!", style: context.textTheme.displayLarge),
            Text("ORDER NUMBER #1A2B3C4D"),
            Text(
              "We sent an email to email@email.com with everything you need to know about your order. Log in or register to enjoy a personalized experience and access all our services.",
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: context.mediaQuery.padding.add(
          EdgeInsets.symmetric(horizontal: Spacing.small),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: Spacing.extraSmall,
          children: [
            SizedBox(
              width: double.infinity,
              child: AppButton.primary(
                label: "Create account",
                onPressed: () {
                  final userData = ref.read(checkoutViewModelProvider).userData;
                  ref
                      .read(checkoutViewModelProvider.notifier)
                      .clearCheckoutState();
                  context.goTo(AppRoute.createAccount, extra: userData);
                },
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: AppButton.secondary(label: "View order", onPressed: () {}),
            ),
          ],
        ),
      ),
    );
  }
}
