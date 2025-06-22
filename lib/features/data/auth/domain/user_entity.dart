import 'package:equatable/equatable.dart';

class UserEntity extends Equatable {
  final String? email;
  final String? userName;
  final String? firstName;
  final String? lastName;
  final String? password;
  const UserEntity({
    this.email,
    this.userName,
    this.firstName,
    this.lastName,
    this.password,
  });
  @override
  List<Object?> get props => [
        email,
        userName,
        password,
      ];
}
