import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeCheckoutViewModel extends Notifier<CheckoutState>
    implements CheckoutViewModel {
  final CheckoutState _initialState;

  // --- tracked values ---
  UserData? savedUserData;
  Address? setDeliveryAddressArg;
  Address? setBillingAddressArg;
  bool startGuestSessionCalled = false;
  bool clearStateCalled = false;

  FakeCheckoutViewModel([this._initialState = const CheckoutState()]);

  @override
  CheckoutState build() => _initialState;

  @override
  void setUserData(UserData userData) {
    savedUserData = userData;
    final currentUser = state.user;
    state = state.copyWith(user: currentUser?.copyWith(data: userData));
  }

  @override
  void setDeliveryAddress(Address deliveryAddress) {
    setDeliveryAddressArg = deliveryAddress;
    final currentUser = state.user;
    state = state.copyWith(
      user: currentUser?.copyWith(deliveryAddress: deliveryAddress),
    );
  }

  @override
  void setBillingAddress(Address billingAddress) {
    setBillingAddressArg = billingAddress;
    final currentUser = state.user;
    state = state.copyWith(
      user: currentUser?.copyWith(billingAddress: billingAddress),
    );
  }

  @override
  void startGuestSession() {
    startGuestSessionCalled = true;
  }

  @override
  void useShippingAsBilling() {
    final currentUser = state.user;
    if (state.deliveryAddress != null) {
      state = state.copyWith(
        user: currentUser?.copyWith(billingAddress: state.deliveryAddress),
      );
    }
  }

  // No-op methods (override only what your tests need)
  @override
  void setDeliveryMethod(DeliveryMethod method) {}

  @override
  void setPaymentMethod(PaymentCard paymentCard) {}

  @override
  void applyPromoCode(String code) {}

  @override
  double get totalPrice => 0.0;

  @override
  void placeOrder() {}

  @override
  void clearCheckoutState() {
    clearStateCalled = true;
  }
}
