import 'package:autilab_project/features/data/auth/data/model/user_model.dart';

class UserParam {
  String email;
  String firstName;
  String lastName;
  String? password;
  String? birthDate;
  GenderEnum? gender;
  String? photo;
  UserParam({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.password,
    this.birthDate,
    this.gender,
    this.photo,
  });
}
