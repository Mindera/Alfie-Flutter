import 'package:alfie_flutter/data/models/address.dart';
import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/user.dart';
import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:hive/hive.dart';

class RegisteredUserAdapter extends TypeAdapter<RegisteredUser> {
  @override
  final int typeId = 23;

  @override
  RegisteredUser read(BinaryReader reader) {
    return RegisteredUser(
      id: reader.readString(),
      data: reader.read() as UserData,
      deliveryAddress: reader.read() as Address?,
      billingAddress: reader.read() as Address?,
      paymentCards: (reader.read() as List).cast<PaymentCard>(),
    );
  }

  @override
  void write(BinaryWriter writer, RegisteredUser obj) {
    writer.writeString(obj.id);
    writer.write(obj.data);
    writer.write(obj.deliveryAddress);
    writer.write(obj.billingAddress);
    writer.write(obj.paymentCards);
  }
}

class GuestUserAdapter extends TypeAdapter<GuestUser> {
  @override
  final int typeId = 24;

  @override
  GuestUser read(BinaryReader reader) {
    return GuestUser(
      id: reader.readString(),
      data: reader.read() as UserData?,
      deliveryAddress: reader.read() as Address?,
      billingAddress: reader.read() as Address?,
      paymentCards: (reader.read() as List).cast<PaymentCard>(),
    );
  }

  @override
  void write(BinaryWriter writer, GuestUser obj) {
    writer.writeString(obj.id);
    writer.write(obj.data);
    writer.write(obj.deliveryAddress);
    writer.write(obj.billingAddress);
    writer.write(obj.paymentCards);
  }
}
