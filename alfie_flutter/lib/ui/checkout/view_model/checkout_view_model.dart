import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:alfie_flutter/data/repositories/checkout_state_repository.dart';

/// Orchestrates the multi-step checkout funnel and preserves progression state.
final checkoutViewModelProvider =
    NotifierProvider<CheckoutViewModel, CheckoutState>(
      () => CheckoutViewModel(),
    );

/// State controller for the active checkout session payload.
///
/// Synchronizes local UI progression with the [CheckoutStateRepository] to
/// survive application backgrounding or accidental dismissals.
class CheckoutViewModel extends Notifier<CheckoutState> {
  CheckoutStateRepository get _repository =>
      ref.read(checkoutStateRepositoryProvider);

  /// Initializes the funnel by attempting to hydrate a suspended session from local storage.
  ///
  /// If no suspended session exists, defaults to the active [authRepositoryProvider] state.
  @override
  CheckoutState build() {
    final savedState = _repository.getCheckoutState();
    if (savedState != null) {
      return savedState;
    }

    final user = ref.watch(authRepositoryProvider);
    return CheckoutState(user: user);
  }

  /// The aggregate sum of the cart contents and selected fulfillment fees.
  double get totalPrice =>
      ref.read(bagViewModelProvider.notifier).total +
      (state.deliveryMethod?.price.amount ?? 0);

  /// Mutates the active state and immediately synchronizes the snapshot to persistent storage.
  void _updateState(CheckoutState newState) {
    state = newState;
    _repository.saveCheckoutState(newState);
  }

  void setUserData(UserData userData) {
    final currentUser = state.user;
    _updateState(state.copyWith(user: currentUser?.copyWith(data: userData)));
  }

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

  /// Duplicates the current [CheckoutState.deliveryAddress] into the billing address slot.
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

  void setDeliveryMethod(DeliveryMethod method) {
    _updateState(state.copyWith(deliveryMethod: method));
  }

  /// Assigns the active [paymentCard] and registers it to the user's profile if unrecognized.
  void setPaymentMethod(PaymentCard paymentCard) {
    final currentCards = state.user?.paymentCards ?? [];

    final List<PaymentCard> updatedCards = List.from(currentCards);
    if (!updatedCards.contains(paymentCard)) {
      updatedCards.add(paymentCard);
    }

    _updateState(
      state.copyWith(
        paymentCard: paymentCard,
        user: state.user?.copyWith(paymentCards: updatedCards),
      ),
    );
  }

  void applyPromoCode(String code) {
    _updateState(state.copyWith(promoCode: code));
  }

  /// Finalizes the transaction, purges the transient cart, and conditionally cleans up guest sessions.
  void placeOrder() {
    ref.read(bagRepositoryProvider.notifier).clearBag();

    if (state.user is GuestUser) {
      ref.read(authRepositoryProvider.notifier).logout();
    }
  }

  /// Purges the locally persisted checkout snapshot and resets the funnel to its initial state.
  void clearCheckoutState() {
    _repository.deleteCheckoutState();
    ref.invalidateSelf();
  }
}
