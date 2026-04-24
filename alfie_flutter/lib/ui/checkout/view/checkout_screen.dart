import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/routing/app_route.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/checkout/view/checkout_item.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/core/themes/app_icons.dart';
import 'package:alfie_flutter/ui/core/themes/colors.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/themes/typography.dart';
import 'package:alfie_flutter/ui/core/ui/button/app_button.dart';
import 'package:alfie_flutter/ui/core/ui/header.dart';
import 'package:alfie_flutter/utils/build_context_extensions.dart';
import 'package:alfie_flutter/utils/navigation_helpers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutScreen extends ConsumerWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final checkoutState = ref.watch(checkoutViewModelProvider);
    final user = ref.watch(authRepositoryProvider);

    final items = [
      CheckoutItem(
        label: "Ship to",
        content: user?.deliveryAddress.toString(),
        nullValueFallBackMessage: "Add a delivery address",
        onPressed: () => context.pushTo(AppRoute.deliveryInformation),
      ),
      CheckoutItem(
        label: "Billing Address",
        content: user?.billingAddress.toString(),
        nullValueFallBackMessage: "Add a billing address",
        onPressed: () => context.pushTo(AppRoute.deliveryInformation),
      ),
      CheckoutItem(
        label: "Delivery Method",
        content: checkoutState.deliveryMethod?.toString(),
        nullValueFallBackMessage: "Select a delivery method",
        onPressed: () => context.pushTo(
          AppRoute.deliveryMethod,
          extra: checkoutState.deliveryMethod,
        ),
      ),
      CheckoutItem(
        label: "Payment Method",
        nullValueFallBackMessage: "Add a payment method",
        onPressed: () => context.pushTo(AppRoute.paymentMethod),
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        flexibleSpace: Header(
          title: "Checkout",
          leading: AppButton.tertiary(
            leading: AppIcons.back,
            onPressed: () => context.goTo(AppRoute.bag),
          ),
        ),
        automaticallyImplyLeading: false,
        automaticallyImplyActions: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(Spacing.small),
        child: CustomScrollView(
          slivers: [
            SliverList.separated(
              itemCount: items.length,
              itemBuilder: (_, i) => items[i],
              separatorBuilder: (_, i) => Divider(),
            ),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(),

                  CheckoutItem(content: "Add promo code / gift card"),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.neutral,
            border: Border(top: BorderSide(color: AppColors.neutral200)),
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              Spacing.small,
              Spacing.extraSmall,
              Spacing.small,
              Spacing.extraSmall + MediaQuery.of(context).viewInsets.bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: Spacing.extraSmall,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Total', style: context.textTheme.bodyMediumBold),
                        Text(
                          '\$${ref.read(bagViewModelProvider.notifier).total.toStringAsFixed(2)}',
                          style: context.textTheme.bodyMediumBold,
                        ),
                      ],
                    ),
                    Text(
                      "Shipping and taxes are calculated in checkout.",
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
                SizedBox(
                  width: double.infinity,
                  child: AppButton.primary(label: "Continue", onPressed: () {}),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
