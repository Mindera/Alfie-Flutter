import 'package:alfie_flutter/data/models/user_data.dart';
import 'package:hive/hive.dart';

class UserDataAdapter extends TypeAdapter<UserData> {
  @override
  final int typeId = 19;

  @override
  UserData read(BinaryReader reader) {
    return UserData(
      firstName: reader.readString(),
      lastName: reader.readString(),
      email: reader.readString(),
      phoneNumber: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserData obj) {
    writer.writeString(obj.firstName);
    writer.writeString(obj.lastName);
    writer.writeString(obj.email);
    writer.writeString(obj.phoneNumber);
  }
}
