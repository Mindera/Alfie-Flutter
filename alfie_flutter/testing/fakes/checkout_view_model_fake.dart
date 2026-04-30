import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';

class FakeCheckoutViewModel extends CheckoutViewModel {
  final CheckoutState initialState;
  UserData? savedUser;

  FakeCheckoutViewModel([this.initialState = const CheckoutState()]);

  @override
  CheckoutState build() {
    return initialState;
  }

  @override
  void setUser(UserData user) {
    savedUser = user;
    state = state.copyWith(userData: user);
  }
}
