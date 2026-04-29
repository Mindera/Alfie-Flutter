import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/data/services/hive_adapters/checkout_state_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

void main() {
  late CheckoutStateAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  late MockRegisteredUser mockUser;
  late MockPaymentCard mockPaymentCard;

  setUp(() {
    adapter = CheckoutStateAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();

    mockUser = MockRegisteredUser();
    mockPaymentCard = MockPaymentCard();
  });

  group('CheckoutStateAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 20);
    });

    test('write() should correctly serialize CheckoutState to binary', () {
      final state = CheckoutState(
        user: mockUser,
        deliveryMethod: DeliveryMethod.standard,
        paymentCard: mockPaymentCard,
        promoCode: 'SUMMER20',
      );

      adapter.write(mockWriter, state);

      // Verifies the 4 fields are written in the exact order specified in the adapter.
      // Explicitly providing the generic types to match the adapter's invocation exactly.
      verifyInOrder([
        () => mockWriter.write<User?>(mockUser),
        () => mockWriter.write<DeliveryMethod?>(DeliveryMethod.standard),
        () => mockWriter.write<PaymentCard?>(mockPaymentCard),
        () => mockWriter.write<String?>('SUMMER20'),
      ]);
    });

    test(
      'write() should correctly serialize CheckoutState to binary (with null fields)',
      () {
        const state = CheckoutState();

        adapter.write(mockWriter, state);

        verifyInOrder([
          () => mockWriter.write<User?>(null),
          () => mockWriter.write<DeliveryMethod?>(null),
          () => mockWriter.write<PaymentCard?>(null),
          () => mockWriter.write<String?>(null),
        ]);
      },
    );

    test('read() should correctly deserialize binary to CheckoutState', () {
      final dynamicReturns = [
        mockUser,
        DeliveryMethod.standard,
        mockPaymentCard,
        'SUMMER20',
      ];

      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      // Verify the resulting state properties match what was read
      expect(result.user, mockUser);
      expect(result.deliveryMethod, DeliveryMethod.standard);
      expect(result.paymentCard, mockPaymentCard);
      expect(result.promoCode, 'SUMMER20');

      // Verify exactly 4 reads were made
      verify(() => mockReader.read()).called(4);
    });
  });
}
