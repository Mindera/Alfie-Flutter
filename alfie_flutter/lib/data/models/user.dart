import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/user_data.dart';

class User {
  final String id;
  final UserData data;
  final Address? deliveryAddress;
  final Address? billingAddress;

  const User({
    required this.id,
    required this.data,
    this.deliveryAddress,
    this.billingAddress,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is User && other.id == id;
  }

  @override
  int get hashCode {
    return Object.hash("User", id);
  }
}
