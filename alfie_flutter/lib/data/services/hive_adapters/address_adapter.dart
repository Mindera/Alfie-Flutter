import 'package:alfie_flutter/data/models/address.dart';
import 'package:hive/hive.dart';

class AddressAdapter extends TypeAdapter<Address> {
  @override
  final int typeId = 16;

  @override
  Address read(BinaryReader reader) {
    return Address(
      country: reader.readString(),
      postalCode: reader.readString(),
      city: reader.readString(),
      street: reader.readString(),
      addressLine2: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Address obj) {
    writer.writeString(obj.country);
    writer.writeString(obj.postalCode);
    writer.writeString(obj.city);
    writer.writeString(obj.street);
    writer.writeString(obj.addressLine2);
  }
}
