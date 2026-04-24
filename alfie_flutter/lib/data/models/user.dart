import 'package:alfie_flutter/data/models/user_data.dart';

class User {
  final String id;
  final UserData data;

  const User({required this.id, required this.data});

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
