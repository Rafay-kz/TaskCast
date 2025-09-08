import '../../domain/entities/user.dart';

class UserModel extends User {
  const UserModel({
    required String username,
  }) : super(username: username);

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      username: json['username'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
    };
  }
}