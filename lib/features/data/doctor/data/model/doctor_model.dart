class DoctorModel {
  final int id;
  final String degree;
  final String description;
  final DoctorUser doctorUser;
  final List<DoctorSpecialities> doctorSpecialities;

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
              (item) => DoctorSpecialities.fromJson(item),
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
  final String firstName;
  final String lastName;
  final String gender;
  final String birthDate;
  DoctorUser({
    required this.firstName,
    required this.lastName,
    required this.gender,
    required this.birthDate,
  });

  factory DoctorUser.fromJson(Map<String, dynamic> jsonObject) {
    return DoctorUser(
      firstName: jsonObject['first_name'] ?? '',
      lastName: jsonObject['last_name'] ?? '',
      gender: jsonObject['gender'] ?? '',
      birthDate: jsonObject['birthdate'] ?? '',
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
