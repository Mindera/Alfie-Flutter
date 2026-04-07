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

class UserData {
  final String firstName;
  final String lastName;
  final String email;
  final String phoneNumber;

  const UserData({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phoneNumber,
  });
}
