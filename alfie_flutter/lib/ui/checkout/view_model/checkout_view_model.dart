import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutViewModel extends Notifier<CheckoutState> {
  @override
  CheckoutState build() {
    final user = ref.read(authRepositoryProvider);

    return CheckoutState(userData: user?.data);
  }

  // ---------------------------
  // CONTACT INFO STEP
  // ---------------------------
  void setUser(UserData user) {
    state = state.copyWith(userData: user);
  }

  // ---------------------------
  // ADDRESS STEP
  // ---------------------------
  void setShippingAddress(Address address) {
    state = state.copyWith(address: address);
  }

  void setBillingAddress(Address billingAddress) {
    state = state.copyWith(billingAddress: billingAddress);
  }

  void useShippingAsBilling() {
    if (state.address != null) {
      state = state.copyWith(billingAddress: state.address);
    }
  }

  // ---------------------------
  // DELIVERY METHOD STEP
  // ---------------------------
  void setDeliveryMethod(DeliveryMethod method) {
    state = state.copyWith(deliveryMethod: method);
  }

  // ---------------------------
  // PAYMENT METHOD STEP
  // ---------------------------
  void setPaymentMethod(PaymentMethod method) {
    state = state.copyWith(paymentMethod: method);
  }

  // ---------------------------
  // PROMO CODE
  // ---------------------------
  void applyPromoCode(String code) {
    state = state.copyWith(promoCode: code);
  }
}
