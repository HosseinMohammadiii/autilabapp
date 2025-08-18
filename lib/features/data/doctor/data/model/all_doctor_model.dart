import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';

class AllDoctorModel {
  int? id;
  int? userid;
  String? degree;
  String? description;
  DoctorUser? user;
  DoctorSpecialities? specialities;
  String? ratingaverage;

  AllDoctorModel({
    this.id,
    this.userid,
    this.degree,
    this.description,
    this.user,
    this.specialities,
    this.ratingaverage,
  });

  factory AllDoctorModel.fromJson(Map<String, dynamic> jsonObject) {
    return AllDoctorModel(
      id: jsonObject['id'],
      userid: jsonObject['user_id'],
      degree: jsonObject['degree'] ?? '',
      description: jsonObject['description'] ?? '',
      user: DoctorUser.fromJson(jsonObject['user']),
      specialities: DoctorSpecialities.fromJson(jsonObject['specialities']),
      ratingaverage: jsonObject['rating_average'] ?? '',
    );
  }
}
