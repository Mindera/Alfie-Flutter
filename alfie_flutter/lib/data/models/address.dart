import 'dart:developer';

class Address {
  final String country;
  final String postalCode;
  final String city;
  final String street;
  final String? addressLine2;

  const Address({
    required this.country,
    required this.city,
    required this.postalCode,
    required this.street,
    this.addressLine2,
  });

  const Address.empty()
    : country = "",
      postalCode = "",
      city = "",
      street = "",
      addressLine2 = null;

  Address copyWith({
    String? country,
    String? postalCode,
    String? city,
    String? street,
    String? addressLine2,
  }) {
    return Address(
      country: country ?? this.country,
      city: city ?? this.city,
      postalCode: postalCode ?? this.postalCode,
      street: street ?? this.street,
      addressLine2: addressLine2 ?? this.addressLine2,
    );
  }

  bool isValid() =>
      country.isNotEmpty &&
      city.isNotEmpty &&
      postalCode.isNotEmpty &&
      street.isNotEmpty;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    log("$this : $other");

    return other is Address &&
        other.country == country &&
        other.postalCode == postalCode &&
        other.city == city &&
        other.street == street &&
        other.addressLine2 == addressLine2;
  }

  @override
  int get hashCode =>
      Object.hash(country, postalCode, city, street, addressLine2);

  @override
  String toString() {
    return 'Address('
        'country: $country, '
        'city: $city, '
        'postalCode: $postalCode, '
        'street: $street, '
        'addressLine2: $addressLine2'
        ')';
  }
}
