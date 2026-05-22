import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';

/// Represents the presentation and progression state of the checkout funnel.
///
/// Aggregates the user's profile, fulfillment preferences, and payment details
/// to evaluate readiness for final order placement.
class CheckoutState {
  /// The active profile driving the checkout, capturing both registered and guest sessions.
  final User? user;

  /// The selected fulfillment tier and associated pricing.
  final DeliveryMethod? deliveryMethod;

  /// The designated payment configuration for the transaction.
  final PaymentCard? paymentCard;

  /// An optional discount string applied to the order total.
  final String? promoCode;

  const CheckoutState({
    this.user,
    this.deliveryMethod,
    this.paymentCard,
    this.promoCode,
  });

  /// Convenience proxy extracting the delivery destination from the underlying [user].
  Address? get deliveryAddress => user?.deliveryAddress;

  /// Convenience proxy extracting the billing destination from the underlying [user].
  Address? get billingAddress => user?.billingAddress;

  /// Convenience proxy extracting personal contact details from the underlying [user].
  UserData? get userData => user?.data;

  bool get hasContactInfo => userData != null;
  bool get hasShippingAddress => deliveryAddress != null;
  bool get hasBillingAddress => billingAddress != null;
  bool get hasDeliveryMethod => deliveryMethod != null;
  bool get hasPaymentMethod => paymentCard != null;

  /// Validates that all critical funnel stages contain populated data.
  ///
  /// Serves as the primary validation gate before enabling the final purchase action.
  bool get canPlaceOrder =>
      hasContactInfo &&
      hasShippingAddress &&
      hasBillingAddress &&
      hasDeliveryMethod &&
      hasPaymentMethod;

  CheckoutState copyWith({
    User? user,
    DeliveryMethod? deliveryMethod,
    PaymentCard? paymentCard,
    String? promoCode,
  }) {
    return CheckoutState(
      user: user ?? this.user,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentCard: paymentCard ?? this.paymentCard,
      promoCode: promoCode ?? this.promoCode,
    );
  }
}
