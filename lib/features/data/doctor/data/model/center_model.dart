import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';

class CenterModel {
  String name;
  int agemin;
  int agemax;
  String address;
  String phonenumber;
  String centerinformation;
  String gender;
  List<CenterImageModel> images;
  double latitude;
  double longitude;
  int doctorinfocount;
  List<DoctorUser> doctorinfo;
  int specialitycount;
  List<RecentVisitedModel> specialty;

  CenterModel({
    required this.name,
    required this.agemin,
    required this.agemax,
    required this.address,
    required this.gender,
    required this.phonenumber,
    required this.centerinformation,
    required this.images,
    required this.latitude,
    required this.longitude,
    required this.doctorinfocount,
    required this.doctorinfo,
    required this.specialitycount,
    required this.specialty,
  });

  factory CenterModel.fromJson(Map<String, dynamic> jsonObject) {
    var doctorInfoList = (jsonObject['doctor_info'] as List<dynamic>?)
            ?.map(
              (item) => DoctorUser.fromJson(item),
            )
            .toList() ??
        [];
    var specialtyList = (jsonObject['specialities'] as List<dynamic>?)
            ?.map(
              (item) => RecentVisitedModel.fromJson(item),
            )
            .toList() ??
        [];
    var centerImageList = (jsonObject['images'] as List<dynamic>?)
            ?.map(
              (item) => CenterImageModel.fromJson(item),
            )
            .toList() ??
        [];
    return CenterModel(
      name: jsonObject['name'] ?? '',
      agemin: jsonObject['age_min'] ?? 0,
      agemax: jsonObject['age_max'] ?? 0,
      address: jsonObject['address'] ?? '',
      gender: jsonObject['gender'],
      phonenumber: jsonObject['phone_number'] ?? '',
      centerinformation: jsonObject['center_information'] ?? '',
      images: centerImageList,
      latitude: jsonObject['latitude'] ?? 0,
      longitude: jsonObject['longitude'] ?? 0,
      doctorinfocount: jsonObject['doctor_info_count'] ?? 0,
      doctorinfo: doctorInfoList,
      specialitycount: jsonObject['speciality_count'] ?? 0,
      specialty: specialtyList,
    );
  }
}

class CenterImageModel {
  final String imageUrl;
  CenterImageModel({required this.imageUrl});

  factory CenterImageModel.fromJson(Map<String, dynamic> jsonObject) {
    return CenterImageModel(
      imageUrl: jsonObject['image_url'],
    );
  }
}
