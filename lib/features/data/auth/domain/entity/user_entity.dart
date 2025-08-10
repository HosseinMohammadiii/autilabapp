import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String userName;
  final String email;
  final String firstName;
  final String lastName;
  final String password;
  final String birthdate;
  final String gender;
  final String photo;
  final String address;
  const UserEntity({
    required this.userName,
    required this.email,
    required this.firstName,
    required this.lastName,
    required this.password,
    required this.birthdate,
    required this.gender,
    required this.photo,
    required this.address,
  });
  @override
  List<Object?> get props => [
        userName,
        email,
        password,
      ];
}
