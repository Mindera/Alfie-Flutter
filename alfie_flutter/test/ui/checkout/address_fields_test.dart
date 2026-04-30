import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/ui/checkout/view/address_fields.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../testing/mocks.dart';

void main() {
  group('AddressFields Widget Tests', () {
    late MockAddress mockAddress;

    setUp(() {
      mockAddress = MockAddress();
      when(() => mockAddress.country).thenReturn('Portugal');
      when(() => mockAddress.postalCode).thenReturn('3000-000');
      when(() => mockAddress.city).thenReturn('Coimbra');
      when(() => mockAddress.street).thenReturn('Rua da Sofia');
      when(() => mockAddress.addressLine2).thenReturn('Apt 1');
    });

    testWidgets('renders all fields with correct initial values', (
      tester,
    ) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddressFields(address: mockAddress, onChanged: (_) {}),
          ),
        ),
      );

      // Verify input fields exist with their corresponding labels
      expect(find.widgetWithText(AppInputField, 'Country'), findsOneWidget);
      expect(find.widgetWithText(AppInputField, 'Postal Code'), findsOneWidget);
      expect(find.widgetWithText(AppInputField, 'City'), findsOneWidget);
      expect(find.widgetWithText(AppInputField, 'Street'), findsOneWidget);
      expect(
        find.widgetWithText(AppInputField, 'Address Line 2 (Optional)'),
        findsOneWidget,
      );

      // Verify the initial text is loaded from the Address model
      expect(find.text('Portugal'), findsOneWidget);
      expect(find.text('3000-000'), findsOneWidget);
      expect(find.text('Coimbra'), findsOneWidget);
      expect(find.text('Rua da Sofia'), findsOneWidget);
      expect(find.text('Apt 1'), findsOneWidget);
    });

    testWidgets('calls onChanged with updated copy when user inputs text', (
      tester,
    ) async {
      final updatedAddress = MockAddress();

      // Stub copyWith to return our updated mock address
      when(
        () => mockAddress.copyWith(
          country: any(named: 'country'),
          postalCode: any(named: 'postalCode'),
          city: any(named: 'city'),
          street: any(named: 'street'),
          addressLine2: any(named: 'addressLine2'),
        ),
      ).thenReturn(updatedAddress);

      Address? capturedAddress;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: AddressFields(
              address: mockAddress,
              onChanged: (address) {
                capturedAddress = address;
              },
            ),
          ),
        ),
      );

      // Simulate typing into each field and verify copyWith is triggered correctly
      await tester.enterText(
        find.widgetWithText(AppInputField, 'Country'),
        'Spain',
      );
      verify(() => mockAddress.copyWith(country: 'Spain')).called(1);
      expect(capturedAddress, equals(updatedAddress));

      await tester.enterText(
        find.widgetWithText(AppInputField, 'Postal Code'),
        '28001',
      );
      verify(() => mockAddress.copyWith(postalCode: '28001')).called(1);

      await tester.enterText(
        find.widgetWithText(AppInputField, 'City'),
        'Madrid',
      );
      verify(() => mockAddress.copyWith(city: 'Madrid')).called(1);

      await tester.enterText(
        find.widgetWithText(AppInputField, 'Street'),
        'Gran Via',
      );
      verify(() => mockAddress.copyWith(street: 'Gran Via')).called(1);

      await tester.enterText(
        find.widgetWithText(AppInputField, 'Address Line 2 (Optional)'),
        'Floor 2',
      );
      verify(() => mockAddress.copyWith(addressLine2: 'Floor 2')).called(1);
    });
  });
}
