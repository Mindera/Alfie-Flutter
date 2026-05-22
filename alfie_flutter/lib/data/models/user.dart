import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user_data.dart';

/// Base authentication state and profile contract for a shopping session.
sealed class User {
  String get id;
  UserData? get data;
  Address? get deliveryAddress;
  Address? get billingAddress;
  List<PaymentCard> get paymentCards;

  User copyWith({
    String? id,
    UserData? data,
    Address? deliveryAddress,
    Address? billingAddress,
    List<PaymentCard>? paymentCards,
  });

  const User();
}

/// Represents a fully authenticated and persisted user session.
///
/// Enforces non-nullability on core profile [data] and requires a concrete
/// list of saved [paymentCards].
class RegisteredUser extends User {
  @override
  final String id;
  @override
  final UserData data;
  @override
  final Address? deliveryAddress;
  @override
  final Address? billingAddress;
  @override
  final List<PaymentCard> paymentCards;

  const RegisteredUser({
    required this.id,
    required this.data,
    this.deliveryAddress,
    this.billingAddress,
    required this.paymentCards,
  });

  @override
  RegisteredUser copyWith({
    String? id,
    UserData? data,
    Address? deliveryAddress,
    Address? billingAddress,
    List<PaymentCard>? paymentCards,
  }) {
    return RegisteredUser(
      id: id ?? this.id,
      data: data ?? this.data,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      paymentCards: paymentCards ?? this.paymentCards,
    );
  }
}

/// Represents an ephemeral, unauthenticated shopping session.
///
/// Profile [data] is optional, allowing users to browse and configure a cart
/// prior to formal registration or login.
class GuestUser extends User {
  @override
  final String id;
  @override
  final UserData? data;
  @override
  final Address? deliveryAddress;
  @override
  final Address? billingAddress;
  @override
  final List<PaymentCard> paymentCards;

  const GuestUser({
    required this.id,
    this.data,
    this.deliveryAddress,
    this.billingAddress,
    this.paymentCards = const [],
  });

  @override
  GuestUser copyWith({
    String? id,
    UserData? data,
    Address? deliveryAddress,
    Address? billingAddress,
    List<PaymentCard>? paymentCards,
  }) {
    return GuestUser(
      id: id ?? this.id,
      data: data ?? this.data,
      deliveryAddress: deliveryAddress ?? this.deliveryAddress,
      billingAddress: billingAddress ?? this.billingAddress,
      paymentCards: paymentCards ?? this.paymentCards,
    );
  }
}
