import 'package:autilab_project/features/data/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required final String userName,
    required final String email,
    required final String firstName,
    required final String lastName,
    final String? password,
    required final String birthdate,
    required final String gender,
    required final String photo,
    required final String address,
  }) : super(
          userName: userName,
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password ?? '',
          address: address,
          birthdate: birthdate,
          gender: gender,
          photo: photo,
        );

  factory UserModel.fromJson(Map<String, dynamic> jsonObject) {
    return UserModel(
      userName: jsonObject['username'] ?? '',
      email: jsonObject['email'] ?? '',
      firstName: jsonObject['first_name'] ?? '',
      lastName: jsonObject['last_name'] ?? '',
      birthdate: jsonObject['birthdate'] ?? '',
      gender: jsonObject['gender'],
      photo: jsonObject['photo'] ?? '',
      address: jsonObject['address'] ?? '',
    );
  }
}
