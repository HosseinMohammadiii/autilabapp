import 'package:equatable/equatable.dart';

import '../data/model/user_model.dart';

class UserEntity extends Equatable {
  final String? userName;
  final String? email;

  final String? firstName;
  final String? lastName;
  final String? password;
  final String? birthdate;
  final Gender? gender;
  final String? photo;
  final List<Address>? address;
  const UserEntity({
    this.userName,
    this.email,
    this.firstName,
    this.lastName,
    this.password,
    this.birthdate,
    this.gender,
    this.photo,
    this.address,
  });
  @override
  List<Object?> get props => [
        userName,
        email,
        password,
      ];
}
