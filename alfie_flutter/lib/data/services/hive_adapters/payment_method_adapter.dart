import 'package:alfie_flutter/data/models/payment_method.dart';
import 'package:hive/hive.dart';

class PaymentMethodAdapter extends TypeAdapter<PaymentMethod> {
  @override
  final int typeId = 18;

  @override
  PaymentMethod read(BinaryReader reader) {
    return PaymentMethod(
      id: reader.readString(),
      name: reader.readString(),
      description: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, PaymentMethod obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.description);
  }
}
