import 'package:alfie_flutter/data/models/payment_card_type.dart';
import 'package:hive/hive.dart';

class CardTypeAdapter extends TypeAdapter<PaymentCardType> {
  @override
  final int typeId = 21;

  @override
  PaymentCardType read(BinaryReader reader) {
    return PaymentCardType.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, PaymentCardType obj) {
    writer.writeInt(obj.index);
  }
}
