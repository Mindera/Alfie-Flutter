import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/ui/checkout/view_model/checkout_state.dart';
import 'package:alfie_flutter/data/services/hive_adapters/checkout_state_adapter.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

class MockAddress extends Mock implements Address {}

class MockUserData extends Mock implements UserData {}

class MockPaymentMethod extends Mock implements PaymentMethod {}

void main() {
  late CheckoutStateAdapter adapter;
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;

  late MockAddress mockAddress;
  late MockAddress mockBillingAddress;
  late MockUserData mockUserData;
  late MockPaymentMethod mockPaymentMethod;

  setUp(() {
    adapter = CheckoutStateAdapter();
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();

    mockAddress = MockAddress();
    mockBillingAddress = MockAddress();
    mockUserData = MockUserData();
    mockPaymentMethod = MockPaymentMethod();
  });

  group('CheckoutStateAdapter Tests -', () {
    test('should have the correct typeId', () {
      expect(adapter.typeId, 20);
    });

    test('write() should correctly serialize CheckoutState to binary', () {
      final state = CheckoutState(
        address: mockAddress,
        billingAddress: mockBillingAddress,
        userData: mockUserData,
        deliveryMethod: DeliveryMethod.standard,
        paymentMethod: mockPaymentMethod,
        promoCode: 'SUMMER20',
      );

      adapter.write(mockWriter, state);

      verifyInOrder([
        () => mockWriter.write<Address?>(
          mockAddress,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<Address?>(
          mockBillingAddress,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<UserData?>(
          mockUserData,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<DeliveryMethod?>(
          DeliveryMethod.standard,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<PaymentMethod?>(
          mockPaymentMethod,
          writeTypeId: any(named: 'writeTypeId'),
        ),
        () => mockWriter.write<String?>(
          'SUMMER20',
          writeTypeId: any(named: 'writeTypeId'),
        ),
      ]);
    });

    test(
      'write() should correctly serialize CheckoutState to binary (with null fields)',
      () {
        const state = CheckoutState();

        adapter.write(mockWriter, state);

        verifyInOrder([
          () => mockWriter.write<Address?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Address?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<UserData?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<DeliveryMethod?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<PaymentMethod?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<String?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('read() should correctly deserialize binary to CheckoutState', () {
      final dynamicReturns = [
        mockAddress,
        mockBillingAddress,
        mockUserData,
        DeliveryMethod.standard,
        mockPaymentMethod,
        'SUMMER20',
      ];

      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.address, mockAddress);
      expect(result.billingAddress, mockBillingAddress);
      expect(result.userData, mockUserData);
      expect(result.deliveryMethod, DeliveryMethod.standard);
      expect(result.paymentMethod, mockPaymentMethod);
      expect(result.promoCode, 'SUMMER20');

      verify(() => mockReader.read()).called(6);
    });
  });
}
