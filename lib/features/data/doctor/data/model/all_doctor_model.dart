import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';

class AllDoctorModel {
  int? id;
  int? userid;
  String? degree;
  String? description;
  DoctorUser? user;
  RecentVisitedModel? specialities;
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
    // var doctorSpecialitiesList = (jsonObject['specialities'] as List<dynamic>?)
    //         ?.map(
    //           (item) => DoctorSpecialities.fromJson(item),
    //         )
    //         .toList() ??
    //     [];
    return AllDoctorModel(
      id: jsonObject['id'],
      userid: jsonObject['user_id'],
      degree: jsonObject['degree'] ?? '',
      description: jsonObject['description'] ?? '',
      user: DoctorUser.fromJson(jsonObject['user']),
      specialities: RecentVisitedModel.fromJson(jsonObject['specialities']),
      ratingaverage: jsonObject['rating_average'] ?? '',
    );
  }
}

class SpecialtyDoctor {
  int? id;
  int? userid;
  String? degree;
  String? description;
  DoctorUser? user;
  List<RecentVisitedModel>? specialities;
  SpecialtyDoctor(
    this.id,
    this.userid,
    this.degree,
    this.description,
    this.user,
    this.specialities,
  );

  factory SpecialtyDoctor.fromJson(Map<String, dynamic> jsonObject) {
    var doctorSpecialitiesList = (jsonObject['specialities'] as List<dynamic>?)
            ?.map(
              (item) => RecentVisitedModel.fromJson(item),
            )
            .toList() ??
        [];
    return SpecialtyDoctor(
      jsonObject['id'],
      jsonObject['user_id'],
      jsonObject['degree'] ?? '',
      jsonObject['description'] ?? '',
      DoctorUser.fromJson(jsonObject['user']),
      doctorSpecialitiesList,
    );
  }
}
