// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class User {
  String userName;
  String userPin;
  User({
    required this.userName,
    required this.userPin,
  });

  User copyWith({
    String? userName,
    String? userPin,
  }) {
    return User(
      userName: userName ?? this.userName,
      userPin: userPin ?? this.userPin,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userName': userName,
      'userPin': userPin,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      userName: map['userName'] as String,
      userPin: map['userPin'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'User(userName: $userName, userPin: $userPin)';

  @override
  bool operator ==(covariant User other) {
    if (identical(this, other)) return true;

    return other.userName == userName && other.userPin == userPin;
  }

  @override
  int get hashCode => userName.hashCode ^ userPin.hashCode;
}
