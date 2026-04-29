import 'package:alfie_flutter/data/models/payment_card.dart';
import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:hive/hive.dart';

class PaymentCardAdapter extends TypeAdapter<PaymentCard> {
  @override
  final int typeId = 22;

  @override
  PaymentCard read(BinaryReader reader) {
    return PaymentCard(
      type: reader.read() as PaymentCardType,
      number: reader.read() as String,
      name: reader.read() as String,
      month: reader.read() as int,
      year: reader.read() as int,
      cvv: reader.read() as int,
    );
  }

  @override
  void write(BinaryWriter writer, PaymentCard obj) {
    writer.write(obj.type);
    writer.write(obj.number);
    writer.write(obj.name);
    writer.write(obj.month);
    writer.write(obj.year);
    writer.write(obj.cvv);
  }
}
