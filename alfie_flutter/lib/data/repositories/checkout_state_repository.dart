import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Persists transient checkout progression to survive app restarts or backgrounding.
class CheckoutStateRepository {
  final IPersistentStorageService _storageService;

  CheckoutStateRepository(this._storageService);

  /// Restores a previously saved [CheckoutState] from local storage.
  ///
  /// Returns `null` if no active checkout session exists.
  CheckoutState? getCheckoutState() {
    return _storageService.getCheckoutState();
  }

  /// Serializes and writes the current checkout [state] to device storage.
  Future<void> saveCheckoutState(CheckoutState state) async {
    await _storageService.saveCheckoutState(state);
  }

  /// Purges the active checkout state.
  ///
  /// Typically called upon successful order placement or explicit cart abandonment.
  Future<void> deleteCheckoutState() async {
    await _storageService.deleteCheckoutState();
  }
}

/// Provides singleton access to the [CheckoutStateRepository].
final checkoutStateRepositoryProvider = Provider(
  (ref) => CheckoutStateRepository(ref.watch(persistentStorageServiceProvider)),
);
