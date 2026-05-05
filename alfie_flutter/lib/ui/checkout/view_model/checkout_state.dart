import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user_data.dart';

class CheckoutState {
  final Address? deliveryAddress;
  final Address? billingAddress;
  final UserData? userData;
  final DeliveryMethod? deliveryMethod;
  final PaymentMethod? paymentMethod;
  final String? promoCode;

  const CheckoutState({
    this.deliveryAddress,
    this.billingAddress,
    this.userData,
    this.deliveryMethod,
    this.paymentMethod,
    this.promoCode,
  });

  bool get hasContactInfo => userData != null;
  bool get hasShippingAddress => deliveryAddress != null;
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
    Address? deliveryAddress,
    Address? billingAddress,
    UserData? userData,
    DeliveryMethod? deliveryMethod,
    PaymentMethod? paymentMethod,
    String? promoCode,
  }) {
    return CheckoutState(
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      userData: userData ?? this.userData,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      promoCode: promoCode ?? this.promoCode,
    );
  }
}
