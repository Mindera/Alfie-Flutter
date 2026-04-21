import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user.dart';

class CheckoutState {
  final Address? address;
  final Address? billingAddress;
  final User? user;
  final DeliveryMethod? deliveryMethod;
  final PaymentMethod? paymentMethod;
  final String? promoCode;

  const CheckoutState({
    this.address,
    this.billingAddress,
    this.user,
    this.deliveryMethod,
    this.paymentMethod,
    this.promoCode,
  });

  bool get hasContactInfo => user != null;
  bool get hasShippingAddress => address != null;
  bool get hasBillingAddress => billingAddress != null;
  bool get hasDeliveryMethod => deliveryMethod != null;
  bool get hasPaymentMethod => paymentMethod != null;

  bool get canPlaceOrder =>
      hasContactInfo &&
      hasShippingAddress &&
      hasBillingAddress &&
      hasDeliveryMethod &&
      hasPaymentMethod;

  CheckoutState copyWith({
    Address? address,
    Address? billingAddress,
    User? user,
    DeliveryMethod? deliveryMethod,
    PaymentMethod? paymentMethod,
    String? promoCode,
  }) {
    return CheckoutState(
      address: address ?? this.address,
      billingAddress: billingAddress ?? this.billingAddress,
      user: user ?? this.user,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      promoCode: promoCode ?? this.promoCode,
    );
  }
}
