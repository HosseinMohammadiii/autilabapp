import 'package:autilab_project/features/data/auth/domain/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    final String? email,
    final String? userName,
    final String? firstName,
    final String? lastName,
    final String? password,
  }) : super(
          email: email,
          userName: userName,
          firstName: firstName,
          lastName: lastName,
          password: password,
        );

  factory UserModel.fromJson(Map<String, dynamic> jsonObject) {
    return UserModel(
      email: jsonObject['email'] ?? '',
      userName: jsonObject['username'] ?? '',
      firstName: jsonObject['first_name'] ?? '',
      lastName: jsonObject['last_name'] ?? '',
    );
  }
}
