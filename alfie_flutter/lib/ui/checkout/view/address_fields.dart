import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

/// A reusable form component for capturing physical [Address] details.
///
/// Designed to be embedded within larger forms (e.g., delivery and billing),
/// delegating state mutations back to the parent via the [onChanged] callback.
class AddressFields extends StatelessWidget {
  final String keyPrefix;
  final Address address;
  final Function(Address) onChanged;

  const AddressFields({
    super.key,
    this.keyPrefix = "address_fields",
    required this.address,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: Spacing.small,
      children: [
        AppInputField(
          "Country",
          key: Key('${keyPrefix}_country_field'),
          keyboardType: TextInputType.text,
          initialValue: address.country,
          onChanged: (value) => onChanged(address.copyWith(country: value)),
        ),
        AppInputField(
          "Postal Code",
          key: Key('${keyPrefix}_postal_code_field'),
          keyboardType: TextInputType.text,
          initialValue: address.postalCode,
          onChanged: (value) => onChanged(address.copyWith(postalCode: value)),
        ),
        AppInputField(
          "City",
          key: Key('${keyPrefix}_city_field'),
          keyboardType: TextInputType.text,
          initialValue: address.city,
          onChanged: (value) => onChanged(address.copyWith(city: value)),
        ),
        AppInputField(
          "Street",
          key: Key('${keyPrefix}_street_field'),
          keyboardType: TextInputType.streetAddress,
          initialValue: address.street,
          onChanged: (value) => onChanged(address.copyWith(street: value)),
        ),
        AppInputField(
          "Address Line 2 (Optional)",
          key: Key('${keyPrefix}_address_line_2_field'),
          keyboardType: TextInputType.text,
          initialValue: address.addressLine2 ?? "",
          onChanged: (value) =>
              onChanged(address.copyWith(addressLine2: value)),
        ),
      ],
    );
  }
}
