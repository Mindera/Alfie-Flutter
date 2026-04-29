import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:alfie_flutter/data/services/hive_adapters/user_adapters.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../testing/mocks.dart';

class MockUserData extends Mock implements UserData {}

class MockAddress extends Mock implements Address {}

class MockPaymentCard extends Mock implements PaymentCard {}

void main() {
  late MockBinaryReader mockReader;
  late MockBinaryWriter mockWriter;
  late MockUserData mockUserData;
  late MockAddress mockAddress;
  late MockPaymentCard mockCard;

  setUp(() {
    mockReader = MockBinaryReader();
    mockWriter = MockBinaryWriter();
    mockUserData = MockUserData();
    mockAddress = MockAddress();
    mockCard = MockPaymentCard();
  });

  group('RegisteredUserAdapter Tests -', () {
    late RegisteredUserAdapter adapter;

    setUp(() {
      adapter = RegisteredUserAdapter();
    });

    test('should have the correct typeId', () {
      expect(adapter.typeId, 23);
    });

    test(
      'write() should correctly serialize RegisteredUser with all fields',
      () {
        final cards = [mockCard];
        final user = RegisteredUser(
          id: 'reg_123',
          data: mockUserData,
          deliveryAddress: mockAddress,
          billingAddress: mockAddress,
          paymentCards: cards,
        );

        adapter.write(mockWriter, user);

        verifyInOrder([
          () => mockWriter.writeString('reg_123'),
          () => mockWriter.write<UserData>(
            mockUserData,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Address?>(
            mockAddress,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Address?>(
            mockAddress,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<PaymentCard>>(
            cards,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test('write() should handle null addresses for RegisteredUser', () {
      final user = RegisteredUser(
        id: 'reg_123',
        data: mockUserData,
        deliveryAddress: null,
        billingAddress: null,
        paymentCards: [],
      );

      adapter.write(mockWriter, user);

      verify(
        () => mockWriter.write<Address?>(
          null,
          writeTypeId: any(named: 'writeTypeId'),
        ),
      ).called(2);
    });

    test('read() should correctly deserialize RegisteredUser', () {
      final cards = [mockCard];
      when(() => mockReader.readString()).thenReturn('reg_123');

      final dynamicReturns = [
        mockUserData, // data
        mockAddress, // deliveryAddress
        null, // billingAddress
        cards, // paymentCards
      ];

      when(
        () => mockReader.read(),
      ).thenAnswer((_) => dynamicReturns.removeAt(0));

      final result = adapter.read(mockReader);

      expect(result.id, 'reg_123');
      expect(result.data, mockUserData);
      expect(result.deliveryAddress, mockAddress);
      expect(result.billingAddress, isNull);
      expect(result.paymentCards, cards);
    });
  });

  group('GuestUserAdapter Tests -', () {
    late GuestUserAdapter adapter;

    setUp(() {
      adapter = GuestUserAdapter();
    });

    test('should have the correct typeId', () {
      expect(adapter.typeId, 24);
    });

    test(
      'write() should correctly serialize GuestUser with null data/addresses',
      () {
        final user = GuestUser(
          id: 'guest_456',
          data: null,
          deliveryAddress: null,
          billingAddress: null,
          paymentCards: [],
        );

        adapter.write(mockWriter, user);

        verifyInOrder([
          () => mockWriter.writeString('guest_456'),
          () => mockWriter.write<UserData?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Address?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<Address?>(
            null,
            writeTypeId: any(named: 'writeTypeId'),
          ),
          () => mockWriter.write<List<PaymentCard>>(
            [],
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ]);
      },
    );

    test(
      'write() should correctly serialize GuestUser with data and addresses',
      () {
        final user = GuestUser(
          id: 'guest_456',
          data: mockUserData,
          deliveryAddress: mockAddress,
          billingAddress: mockAddress,
          paymentCards: [mockCard],
        );

        adapter.write(mockWriter, user);

        verify(
          () => mockWriter.write<UserData?>(
            mockUserData,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ).called(1);
        verify(
          () => mockWriter.write<Address?>(
            mockAddress,
            writeTypeId: any(named: 'writeTypeId'),
          ),
        ).called(2);
      },
    );

    test(
      'read() should correctly deserialize GuestUser with missing optional fields',
      () {
        when(() => mockReader.readString()).thenReturn('guest_456');

        final dynamicReturns = [
          null, // data
          null, // deliveryAddress
          null, // billingAddress
          <PaymentCard>[], // paymentCards
        ];

        when(
          () => mockReader.read(),
        ).thenAnswer((_) => dynamicReturns.removeAt(0));

        final result = adapter.read(mockReader);

        expect(result.id, 'guest_456');
        expect(result.data, isNull);
        expect(result.deliveryAddress, isNull);
        expect(result.billingAddress, isNull);
        expect(result.paymentCards, isEmpty);
      },
    );
  });
}
