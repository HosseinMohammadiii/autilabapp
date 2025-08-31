import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';

class DoctorModel {
  final int id;
  final String degree;
  final String description;
  final DoctorUser doctorUser;
  final List<RecentVisitedModel> doctorSpecialities;

  DoctorModel({
    required this.id,
    required this.degree,
    required this.description,
    required this.doctorUser,
    required this.doctorSpecialities,
  });
  factory DoctorModel.fomJson(Map<String, dynamic> jsonObject) {
    var doctorSpecialitiesList = (jsonObject['specialities'] as List<dynamic>?)
            ?.map(
              (item) => RecentVisitedModel.fromJson(item),
            )
            .toList() ??
        [];
    return DoctorModel(
      id: jsonObject['id'] ?? 0,
      degree: jsonObject['degree'] ?? '',
      description: jsonObject['description'] ?? '',
      doctorUser: DoctorUser.fromJson(jsonObject['user']),
      doctorSpecialities: doctorSpecialitiesList,
    );
  }
}

class DoctorUser {
  final int id;

  final String firstName;
  final String lastName;
  final String gender;
  final String birthDate;
  final String photo;
  final String description;
  final String address;
  DoctorUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
    required this.photo,
    required this.description,
    required this.address,
  });

  factory DoctorUser.fromJson(Map<String, dynamic> jsonObject) {
    return DoctorUser(
      id: jsonObject['id'],
      firstName: jsonObject['first_name'] ?? '',
      lastName: jsonObject['last_name'] ?? '',
      gender: jsonObject['gender'] ?? '',
      birthDate: jsonObject['birthdate'] ?? '',
      photo: jsonObject['photo'] ?? '',
      description: jsonObject['description'] ?? '',
      address: jsonObject['address'] ?? '',
    );
  }
}

class DoctorSpecialities {
  final String name;
  DoctorSpecialities({
    required this.name,
  });
  factory DoctorSpecialities.fromJson(Map<String, dynamic> jsonObject) {
    return DoctorSpecialities(name: jsonObject['name'] ?? '');
  }
}
