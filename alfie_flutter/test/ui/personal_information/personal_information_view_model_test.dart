import 'package:alfie_flutter/ui/personal_information/view_model/personal_information_view_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late PersonalInformationViewModel viewModel;

  setUp(() {
    viewModel = PersonalInformationViewModel();
  });

  group('PersonalInformationViewModel Validation Tests', () {
    // --- Name Validation ---
    group('validateName', () {
      test('should return null when a valid name is provided', () {
        const validName = 'John Doe';

        final result = viewModel.validateName(validName);

        expect(result, isNull);
      });

      test('should return error message when an invalid name is provided', () {
        const invalidName = 'J4359';

        final result = viewModel.validateName(invalidName);

        expect(result, 'Please enter a valid name');
      });
    });

    // --- Email Validation ---
    group('validateEmail', () {
      test('should return null when a valid email is provided', () {
        const validEmail = 'test.user@example.com';

        final result = viewModel.validateEmail(validEmail);

        expect(result, isNull);
      });

      test('should return error message when an invalid email is provided', () {
        const invalidEmail = 'test.user@invalid'; // Missing domain extension

        final result = viewModel.validateEmail(invalidEmail);

        expect(result, 'Please enter a valid email');
      });
    });

    // --- Phone Number Validation ---
    group('validatePhoneNumber', () {
      test('should return null when a valid phone number is provided', () {
        const validPhone = '+1234567890';

        final result = viewModel.validatePhoneNumber(validPhone);

        expect(result, isNull);
      });

      test(
        'should return error message when an invalid phone number is provided',
        () {
          const invalidPhone = '12345'; // Too short (min 7 digits)

          final result = viewModel.validatePhoneNumber(invalidPhone);

          expect(result, 'Please enter a valid phone number');
        },
      );
    });
  });
}
