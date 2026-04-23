import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alfie_flutter/data/repositories/checkout_state_repository.dart';

class CheckoutViewModel extends Notifier<CheckoutState> {
  CheckoutStateRepository get _repository =>
      ref.read(checkoutStateRepositoryProvider);

  @override
  CheckoutState build() {
    final savedState = _repository.getCheckoutState();
    if (savedState != null) {
      return savedState;
    }

    final user = ref.read(authRepositoryProvider);
    return CheckoutState(userData: user?.data);
  }

  void _updateState(CheckoutState newState) {
    state = newState;
    _repository.saveCheckoutState(newState);
  }

  // ---------------------------
  // CONTACT INFO STEP
  // ---------------------------
  void setUser(UserData user) {
    _updateState(state.copyWith(userData: user));
  }

  // ---------------------------
  // ADDRESS STEP
  // ---------------------------
  void setDeliveryAddress(Address address) {
    _updateState(state.copyWith(deliveryAddress: address));
  }

  void setBillingAddress(Address billingAddress) {
    _updateState(state.copyWith(billingAddress: billingAddress));
  }

  void useShippingAsBilling() {
    if (state.deliveryAddress != null) {
      _updateState(state.copyWith(billingAddress: state.deliveryAddress));
    }
  }

  // ---------------------------
  // DELIVERY METHOD STEP
  // ---------------------------
  void setDeliveryMethod(DeliveryMethod method) {
    _updateState(state.copyWith(deliveryMethod: method));
  }

  // ---------------------------
  // PAYMENT METHOD STEP
  // ---------------------------
  void setPaymentMethod(PaymentMethod method) {
    _updateState(state.copyWith(paymentMethod: method));
  }

  // ---------------------------
  // PROMO CODE
  // ---------------------------
  void applyPromoCode(String code) {
    _updateState(state.copyWith(promoCode: code));
  }
}

final checkoutViewModelProvider =
    NotifierProvider<CheckoutViewModel, CheckoutState>(
      () => CheckoutViewModel(),
    );
