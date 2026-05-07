import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FakeCheckoutViewModel extends Notifier<CheckoutState>
    implements CheckoutViewModel {
  final CheckoutState _initialState;

  // --- tracked values ---
  UserData? savedUser;
  Address? setDeliveryAddressArg;
  Address? setBillingAddressArg;
  bool continueAsGuestCalled = false;

  FakeCheckoutViewModel([this._initialState = const CheckoutState()]);

  @override
  CheckoutState build() => _initialState;

  @override
  void setUser(UserData user) {
    savedUser = user;
    state = state.copyWith(userData: user);
  }

  @override
  void setDeliveryAddress(Address address) {
    setDeliveryAddressArg = address;
    state = state.copyWith(deliveryAddress: address);
  }

  @override
  void setBillingAddress(Address billingAddress) {
    setBillingAddressArg = billingAddress;
    state = state.copyWith(billingAddress: billingAddress);
  }

  @override
  void continueAsGuestUser() {
    continueAsGuestCalled = true;
  }

  // Optional: simulate behavior if needed
  @override
  void useShippingAsBilling() {
    if (state.deliveryAddress != null) {
      state = state.copyWith(billingAddress: state.deliveryAddress);
    }
  }

  // No-op methods (override only what your tests need)
  @override
  void setDeliveryMethod(DeliveryMethod method) {}

  @override
  void setPaymentMethod(PaymentMethod method) {}

  @override
  void applyPromoCode(String code) {}

  @override
  double get totalPrice => throw UnimplementedError();
}
