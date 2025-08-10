import 'dart:io';

class UserParam {
  String email;
  String firstName;
  String lastName;
  String? password;
  String? birthDate;
  String? gender;
  File? photo;
  String? address;
  UserParam({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.password,
    this.birthDate,
    this.gender,
    this.photo,
    this.address,
  });
}
