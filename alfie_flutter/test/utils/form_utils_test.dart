import 'package:alfie_flutter/utils/form_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockBuildContext extends Mock implements BuildContext {}

void main() {
  late MockBuildContext mockContext;

  setUp(() {
    mockContext = MockBuildContext();
  });

  group('FormUtils Validation Tests', () {
    // --- Name Validation ---
    group('validateName', () {
      test('should return null when a valid name is provided', () {
        const validName = 'John Doe';

        final result = mockContext.validateName(validName);

        expect(result, isNull);
      });

      test('should return error message when an invalid name is provided', () {
        const invalidName = 'J4359';

        final result = mockContext.validateName(invalidName);

        expect(result, 'Please enter a valid name');
      });
    });

    // --- Email Validation ---
    group('validateEmail', () {
      test('should return null when a valid email is provided', () {
        const validEmail = 'test.user@example.com';

        final result = mockContext.validateEmail(validEmail);

        expect(result, isNull);
      });

      test('should return error message when an invalid email is provided', () {
        const invalidEmail = 'test.user@invalid'; // Missing domain extension

        final result = mockContext.validateEmail(invalidEmail);

        expect(result, 'Please enter a valid email');
      });
    });

    // --- Phone Number Validation ---
    group('validatePhoneNumber', () {
      test('should return null when a valid phone number is provided', () {
        const validPhone = '+1234567890';

        final result = mockContext.validatePhoneNumber(validPhone);

        expect(result, isNull);
      });

      test(
        'should return error message when an invalid phone number is provided',
        () {
          const invalidPhone = '12345'; // Too short (min 7 digits)

          final result = mockContext.validatePhoneNumber(invalidPhone);

          expect(result, 'Please enter a valid phone number');
        },
      );
    });
  });
}
