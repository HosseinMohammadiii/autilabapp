import 'package:autilab_project/features/data/auth/domain/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel({
    required final String userName,
    required final String email,
    required final String firstName,
    required final String lastName,
    final String? password,
    final String? birthdate,
    final Gender? gender,
    final String? photo,
    final List<Address>? address,
  }) : super(
          userName: userName,
          email: email,
          firstName: firstName,
          lastName: lastName,
          password: password,
        );

  factory UserModel.fromJson(Map<String, dynamic> jsonObject) {
    List<Address>? addressList = (jsonObject['address'] as List<dynamic>?)
        ?.map(
          (item) => Address.fromJson(item),
        )
        .toList();
    return UserModel(
      userName: jsonObject['username'] ?? '',
      email: jsonObject['email'] ?? '',
      firstName: jsonObject['first_name'] ?? '',
      lastName: jsonObject['last_name'] ?? '',
      birthdate: jsonObject['birthdate'] ?? '',
      gender: Gender.fromJson(jsonObject['data']),
      photo: jsonObject['photo'],
      address: addressList ?? [],
    );
  }
}

class Gender {
  GenderEnum genderEnum;
  Gender({required this.genderEnum});

  factory Gender.fromJson(Map<String, dynamic> jsonObject) {
    return Gender(genderEnum: _genderFromString(jsonObject['gender']));
  }
  static GenderEnum _genderFromString(String value) {
    switch (value.toUpperCase()) {
      case 'MALE':
        return GenderEnum.MALE;
      case 'FEMALE':
        return GenderEnum.FEMALE;
      default:
        throw Exception('Unknown gender value: $value');
    }
  }
}

enum GenderEnum {
  MALE,
  FEMALE,
}

class Address {
  final String? address;
  final String? city;
  final String? country;
  Address({
    required this.address,
    required this.city,
    required this.country,
  });

  factory Address.fromJson(Map<String, dynamic> jsonObject) {
    return Address(
      address: jsonObject['address'],
      city: jsonObject['city'],
      country: jsonObject['country'],
    );
  }
}
