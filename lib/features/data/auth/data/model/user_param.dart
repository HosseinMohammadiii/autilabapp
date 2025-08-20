import 'dart:io';

class UserParam {
  String email;
  String firstName;
  String lastName;
  String? password;
  String? birthDate;
  String? gender;
  String? photo;
  String? address;
  String? description;
  UserParam({
    required this.email,
    required this.firstName,
    required this.lastName,
    this.password,
    this.birthDate,
    this.gender,
    this.photo,
    this.address,
    this.description,
  });
}
