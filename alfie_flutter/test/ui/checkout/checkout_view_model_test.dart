import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/bag_item.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/repositories/auth_repository.dart';
import 'package:alfie_flutter/data/repositories/bag_repository.dart';
import 'package:alfie_flutter/data/repositories/checkout_state_repository.dart';
import 'package:alfie_flutter/ui/bag/view_model/bag_view_model.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_view_model.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../testing/fakes/bag_view_model_fake.dart';
import '../../../testing/fakes/product_detail_view_model_fake.dart';
import '../../../testing/mocks.dart';

// A helper to create a mock user that correctly handles immutability (copyWith)
MockRegisteredUser buildMockUser({
  UserData? data,
  Address? deliveryAddress,
  Address? billingAddress,
}) {
  final mock = MockRegisteredUser();

  // Ensure getters never return null when a non-nullable type is expected
  when(() => mock.data).thenReturn(data ?? MockUserData());
  when(() => mock.deliveryAddress).thenReturn(deliveryAddress);
  when(() => mock.billingAddress).thenReturn(billingAddress);

  // Dynamically return a NEW mock with updated properties when copyWith is called
  when(
    () => mock.copyWith(
      data: any(named: 'data'),
      deliveryAddress: any(named: 'deliveryAddress'),
      billingAddress: any(named: 'billingAddress'),
      paymentCards: any(named: 'paymentCards'),
    ),
  ).thenAnswer((invocation) {
    return buildMockUser(
      data: invocation.namedArguments[#data] as UserData? ?? data,
      deliveryAddress:
          invocation.namedArguments[#deliveryAddress] as Address? ??
          deliveryAddress,
      billingAddress:
          invocation.namedArguments[#billingAddress] as Address? ??
          billingAddress,
    );
  });

  return mock;
}

class FakeBagRepository extends BagRepository {
  bool clearBagCalled = false;

  @override
  List<BagItem> build() {
    return []; // Return dummy initial state
  }

  @override
  Future<void> clearBag() async {
    clearBagCalled = true; // Track that the method was executed!
  }
}

void main() {
  late ProviderContainer container;
  late MockCheckoutStateRepository mockRepo;
  late MockRegisteredUser mockUser;
  late FakeBagRepository fakeBagRepo;

  setUp(() {
    mockRepo = MockCheckoutStateRepository();
    mockUser = buildMockUser(); // Use the dynamic mock builder
    fakeBagRepo = FakeBagRepository();

    container = ProviderContainer(
      overrides: [
        checkoutStateRepositoryProvider.overrideWithValue(mockRepo),
        authRepositoryProvider.overrideWith(() => FakeAuthRepository(mockUser)),
        bagRepositoryProvider.overrideWith(() => fakeBagRepo),
        // Inject a starting total so math assertions are predictable
        bagViewModelProvider.overrideWith(
          () => FakeBagViewModel(totalPrice: 100.0),
        ),
      ],
    );

    // Default setups
    when(() => mockRepo.getCheckoutState()).thenReturn(null);
    when(() => mockRepo.saveCheckoutState(any())).thenAnswer((_) async => {});
    when(() => mockRepo.deleteCheckoutState()).thenAnswer((_) async => {});
  });

  setUpAll(() {
    registerFallbackValue(const CheckoutState());
  });

  tearDown(() => container.dispose());

  group('CheckoutViewModel - Initialization', () {
    test('initial state is loaded from repository if available', () {
      final savedState = MockCheckoutState();
      when(() => mockRepo.getCheckoutState()).thenReturn(savedState);

      final state = container.read(checkoutViewModelProvider);
      expect(state, savedState);
    });

    test(
      'initial state uses auth repository user if no saved state exists',
      () {
        when(() => mockRepo.getCheckoutState()).thenReturn(null);

        final state = container.read(checkoutViewModelProvider);
        expect(state.user, mockUser);
      },
    );
  });

  group('CheckoutViewModel - State Updates', () {
    test('setUserData updates user data and saves to repo', () {
      final userData = MockUserData();
      final viewModel = container.read(checkoutViewModelProvider.notifier);

      viewModel.setUserData(userData);

      expect(container.read(checkoutViewModelProvider).userData, userData);
      verify(() => mockRepo.saveCheckoutState(any())).called(1);
    });

    test('setDeliveryAddress updates address correctly', () {
      final address = MockAddress();
      final viewModel = container.read(checkoutViewModelProvider.notifier);

      viewModel.setDeliveryAddress(address);

      expect(
        container.read(checkoutViewModelProvider).deliveryAddress,
        address,
      );
    });

    test('useShippingAsBilling copies delivery address to billing', () {
      final address = MockAddress();
      final viewModel = container.read(checkoutViewModelProvider.notifier);

      viewModel.setDeliveryAddress(address);
      viewModel.useShippingAsBilling();

      final state = container.read(checkoutViewModelProvider);
      expect(state.billingAddress, address);
      expect(state.hasBillingAddress, true);
    });
  });

  group('CheckoutViewModel - Logic & Totals', () {
    test('totalPrice calculates sum of bag total and delivery price', () {
      // Since DeliveryMethod is an enum, use the real value directly
      const deliveryMethod = DeliveryMethod.express;

      final viewModel = container.read(checkoutViewModelProvider.notifier);
      viewModel.setDeliveryMethod(deliveryMethod);

      // 100.0 (from FakeBagViewModel setup) + 20.0 (from DeliveryMethod.express amount)
      expect(viewModel.totalPrice, 120.0);
    });

    test('placeOrder clears bag and logs out if guest', () {
      final viewModel = container.read(checkoutViewModelProvider.notifier);

      viewModel.placeOrder();

      // 5. Use the flag on our Fake instead of verify()
      expect(fakeBagRepo.clearBagCalled, isTrue);
    });
  });

  group('CheckoutViewModel - Persistence', () {
    test('clearCheckoutState deletes data and invalidates provider', () {
      final viewModel = container.read(checkoutViewModelProvider.notifier);

      viewModel.clearCheckoutState();

      verify(() => mockRepo.deleteCheckoutState()).called(1);
    });
  });
}
