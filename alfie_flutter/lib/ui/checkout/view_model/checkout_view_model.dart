import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
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

    final user = ref.watch(authRepositoryProvider);
    return CheckoutState(user: user);
  }

  double get totalPrice =>
      ref.read(bagViewModelProvider.notifier).total +
      (state.deliveryMethod?.price.amount ?? 0);

  void _updateState(CheckoutState newState) {
    state = newState;
    _repository.saveCheckoutState(newState);
  }

  // ---------------------------
  // CONTACT INFO STEP
  // ---------------------------
  void setUserData(UserData userData) {
    final currentUser = state.user;
    _updateState(state.copyWith(user: currentUser?.copyWith(data: userData)));
  }

  // ---------------------------
  // ADDRESS STEP
  // ---------------------------
  void setDeliveryAddress(Address deliveryAddress) {
    final currentUser = state.user;
    _updateState(
      state.copyWith(
        user: currentUser?.copyWith(deliveryAddress: deliveryAddress),
      ),
    );
  }

  void setBillingAddress(Address billingAddress) {
    final currentUser = state.user;
    _updateState(
      state.copyWith(
        user: currentUser?.copyWith(billingAddress: billingAddress),
      ),
    );
  }

  void useShippingAsBilling() {
    final currentUser = state.user;
    if (state.deliveryAddress != null) {
      _updateState(
        state.copyWith(
          user: currentUser?.copyWith(billingAddress: state.deliveryAddress),
        ),
      );
    }
  }

  void startGuestSession() {
    ref.read(authRepositoryProvider.notifier).startGuestSession();
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
