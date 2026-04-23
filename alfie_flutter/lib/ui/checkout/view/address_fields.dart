import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/ui/core/themes/spacing.dart';
import 'package:alfie_flutter/ui/core/ui/text_field/app_text_field.dart';
import 'package:flutter/material.dart';

class AddressFields extends StatelessWidget {
  final Address address;
  final Function(Address) onChanged;

  const AddressFields({
    super.key,
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
          keyboardType: TextInputType.text,
          initialValue: address.country,
          onChanged: (value) => onChanged(address.copyWith(country: value)),
        ),
        AppInputField(
          "Postal Code",
          keyboardType: TextInputType.text,
          initialValue: address.postalCode,
          onChanged: (value) => onChanged(address.copyWith(postalCode: value)),
        ),
        AppInputField(
          "City",
          keyboardType: TextInputType.text,
          initialValue: address.city,
          onChanged: (value) => onChanged(address.copyWith(city: value)),
        ),
        AppInputField(
          "Street",
          keyboardType: TextInputType.streetAddress,
          initialValue: address.street,
          onChanged: (value) => onChanged(address.copyWith(street: value)),
        ),
        AppInputField(
          "Address Line 2 (Optional)",
          keyboardType: TextInputType.text,
          initialValue: address.addressLine2 ?? "",
          onChanged: (value) =>
              onChanged(address.copyWith(addressLine2: value)),
        ),
      ],
    );
  }
}
