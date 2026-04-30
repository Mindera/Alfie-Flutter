import 'package:alfie_flutter/data/services/persistent_storage_service.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CheckoutStateRepository {
  final IPersistentStorageService _storageService;

  CheckoutStateRepository(this._storageService);

  CheckoutState? getCheckoutState() {
    return _storageService.getCheckoutState();
  }

  Future<void> saveCheckoutState(CheckoutState state) async {
    await _storageService.saveCheckoutState(state);
  }

  Future<void> deleteCheckoutState() async {
    await _storageService.deleteCheckoutState();
  }
}

final checkoutStateRepositoryProvider = Provider(
  (ref) => CheckoutStateRepository(ref.watch(persistentStorageServiceProvider)),
);
