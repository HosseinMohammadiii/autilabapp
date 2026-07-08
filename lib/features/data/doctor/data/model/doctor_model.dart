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
  factory DoctorUser.fromLocal(
      String name, String lastName, String photo, String gender) {
    return DoctorUser(
      id: 0,
      firstName: name,
      lastName: lastName,
      gender: gender,
      birthDate: '1996/01/01',
      photo: photo,
      description:
          'Hi, I’m Dr. Sophia Martinez – a speech therapist with over 8 years of experience helping children with autism, speech delays, and communication challenges.My goal is to support every child in finding their unique voice — with patience, care, and family collaboration.You can easily book a session or consultation through this app. I’d be honored to support your child’s journey.',
      address:
          '1234 Maple Street - Suite 567, Downtown Building -Toronto, ON M5A 1A1 - Canada',
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
