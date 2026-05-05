import 'package:alfie_flutter/data/models/delivery_method.dart';
import 'package:hive/hive.dart';

class DeliveryMethodAdapter extends TypeAdapter<DeliveryMethod> {
  @override
  final int typeId = 17;

  @override
  DeliveryMethod read(BinaryReader reader) {
    return DeliveryMethod.values[reader.readInt()];
  }

  @override
  void write(BinaryWriter writer, DeliveryMethod obj) {
    writer.writeInt(obj.index);
  }
}
