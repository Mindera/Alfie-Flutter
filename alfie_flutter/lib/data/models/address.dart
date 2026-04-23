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
    );
  }

  bool isValid() =>
      country.isNotEmpty &&
      city.isNotEmpty &&
      postalCode.isNotEmpty &&
      street.isNotEmpty;
}
