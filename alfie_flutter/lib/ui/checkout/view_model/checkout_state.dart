import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';

class CheckoutState {
  final User? user;
  final DeliveryMethod? deliveryMethod;
  final PaymentMethod? paymentMethod;
  final String? promoCode;

  const CheckoutState({
    this.user,
    this.deliveryMethod,
    this.paymentMethod,
    this.promoCode,
  });

  Address? get deliveryAddress => user?.deliveryAddress;
  Address? get billingAddress => user?.billingAddress;
  UserData? get userData => user?.data;

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
    User? user,
    DeliveryMethod? deliveryMethod,
    PaymentMethod? paymentMethod,
    String? promoCode,
  }) {
    return CheckoutState(
      user: user ?? this.user,
      deliveryMethod: deliveryMethod ?? this.deliveryMethod,
      paymentMethod: paymentMethod ?? this.paymentMethod,
      promoCode: promoCode ?? this.promoCode,
    );
  }
}
