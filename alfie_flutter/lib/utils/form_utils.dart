import 'package:alfie_flutter/utils/app_regex.dart';
import 'package:alfie_flutter/utils/payement_card_utils.dart';
import 'package:flutter/material.dart';

class FormUtils {
  static String? validateName(
    String? value, {
    String errorMessage = 'Please enter a valid name',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.name,
      errorMessage: errorMessage,
    );
  }

  static String? validatePassword(
    String? value, {
    String errorMessage = 'Password must be at least 4 characters',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.password,
      errorMessage: errorMessage,
    );
  }

  static String? validateCheckbox(
    bool? value, {
    String errorMessage = 'This field is required',
  }) {
    if (value != true) {
      return errorMessage;
    }
    return null;
  }

  static String? validateEmail(
    String? value, {
    String errorMessage = 'Please enter a valid email',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.email,
      errorMessage: errorMessage,
    );
  }

  static String? validatePhoneNumber(
    String? value, {
    String errorMessage = 'Please enter a valid phone number',
  }) {
    return _validate(
      value: value,
      regex: AppRegex.phone,
      errorMessage: errorMessage,
    );
  }

  static String? _validate({
    required String? value,
    required RegExp regex,
    required String errorMessage,
  }) {
    if (value == null || value.isEmpty) {
      return errorMessage;
    }

    if (!regex.hasMatch(value)) {
      return errorMessage;
    }

    return null;
  }
}

extension FormUtilsExtension on BuildContext {
  String? validateName(
    String? value, {
    String errorMessage = 'Please enter a valid name',
  }) {
    return FormUtils.validateName(value, errorMessage: errorMessage);
  }

  String? validatePassword(
    String? value, {
    String errorMessage = 'Password must be at least 4 characters',
  }) {
    return FormUtils.validatePassword(value, errorMessage: errorMessage);
  }

  String? validateCheckbox(
    bool? value, {
    String errorMessage = 'This field is required',
  }) {
    return FormUtils.validateCheckbox(value, errorMessage: errorMessage);
  }

  String? validateEmail(
    String? value, {
    String errorMessage = 'Please enter a valid email',
  }) {
    return FormUtils.validateEmail(value, errorMessage: errorMessage);
  }

  String? validatePhoneNumber(
    String? value, {
    String errorMessage = 'Please enter a valid phone number',
  }) {
    return FormUtils.validatePhoneNumber(value, errorMessage: errorMessage);
  }

  String? validateCVV(String? value) {
    return PaymentCardUtils.validateCVV(value);
  }

  String? validateDate(String? value) {
    return PaymentCardUtils.validateDate(value);
  }

  String? validateCardNumber(String? value) {
    return PaymentCardUtils.validateCardNumber(value);
  }
}
