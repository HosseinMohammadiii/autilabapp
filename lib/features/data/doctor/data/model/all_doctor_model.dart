import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';

//Local doctors list
final List<AllDoctorModel> localDoctorsList = [
  AllDoctorModel(
    id: 1,
    userid: 101,
    degree: 'phd',
    description: 'Description',
    user: DoctorUser.fromLocal(
      'Dr.Sam',
      'Diego',
      'assets/images/doctor3.png',
      'male',
    ),
    specialities: RecentVisitedModel.fromLocal(RecentType.pediatricNutrition),
    ratingaverage: 4.5,
  ),
  AllDoctorModel(
    id: 2,
    userid: 102,
    degree: 'phd',
    description: 'Description',
    user: DoctorUser.fromLocal(
      'Dr.Sophia',
      'Matinez',
      'assets/images/doctor_image.jpg',
      'female',
    ),
    specialities: RecentVisitedModel.fromLocal(RecentType.childPsychiatry),
    ratingaverage: 4.8,
  ),
  AllDoctorModel(
    id: 3,
    userid: 103,
    degree: 'phd',
    description: 'Description',
    user: DoctorUser.fromLocal(
      'Dr.Sam',
      'Diego',
      'assets/images/doctor3.png',
      'male',
    ),
    specialities: RecentVisitedModel.fromLocal(RecentType.childPsychiatry),
    ratingaverage: 1.5,
  ),
  AllDoctorModel(
    id: 4,
    userid: 104,
    degree: 'phd',
    description: 'Description',
    user: DoctorUser.fromLocal(
      'Dr.Sam',
      'Diego',
      'assets/images/doctor3.png',
      'male',
    ),
    specialities: RecentVisitedModel.fromLocal(RecentType.speechtherapy),
    ratingaverage: 4.2,
  ),
];

class AllDoctorModel {
  int? id;
  int? userid;
  String? degree;
  String? description;
  DoctorUser? user;
  RecentVisitedModel? specialities;
  double? ratingaverage;

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
      ratingaverage: jsonObject['rating_average'] ?? 0.0,
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
