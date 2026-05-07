import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user_data.dart';

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
}

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

  RegisteredUser({
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

  GuestUser({
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
