import 'package:autilab_project/features/data/auth/data/model/user_model.dart';
import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';

class AllDoctorModel {
  int? id;
  int? userid;
  String? degree;
  String? description;
  UserModel? user;
  DoctorSpecialities? specialities;
  int? ratingaverage;

  AllDoctorModel({
    this.id,
    this.userid,
    this.degree,
    this.description,
    this.user,
    this.specialities,
    this.ratingaverage,
  });

  AllDoctorModel.fromJson(Map<String, dynamic> jsonObject) {
    id = jsonObject['id'];
    userid = jsonObject['user_id'];
    degree = jsonObject['degree'];
    description = jsonObject['description'];
    user = jsonObject['user'] != null
        ? UserModel?.fromJson(jsonObject['user'])
        : null;
    specialities = jsonObject['specialities'] != null
        ? DoctorSpecialities?.fromJson(jsonObject['specialities'])
        : null;
    ratingaverage = jsonObject['rating_average'];
  }
}
