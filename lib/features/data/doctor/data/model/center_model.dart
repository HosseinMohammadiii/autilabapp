import 'package:autilab_project/features/data/doctor/data/model/doctor_model.dart';
import 'package:autilab_project/features/data/home/data/model/recent_visited_model.dart';

class CenterModel {
  String name;
  int agemin;
  int agemax;
  String address;
  String phonenumber;
  String centerinformation;
  String imageurl;
  int latitude;
  int longitude;
  int doctorinfocount;
  DoctorUser doctorinfo;
  int specialitycount;
  RecentVisitedModel speciality;

  CenterModel({
    required this.name,
    required this.agemin,
    required this.agemax,
    required this.address,
    required this.phonenumber,
    required this.centerinformation,
    required this.imageurl,
    required this.latitude,
    required this.longitude,
    required this.doctorinfocount,
    required this.doctorinfo,
    required this.specialitycount,
    required this.speciality,
  });

  factory CenterModel.fromJson(Map<String, dynamic> jsonObject) {
    return CenterModel(
      name: jsonObject['name'] ?? '',
      agemin: jsonObject['age_min'] ?? '',
      agemax: jsonObject['age_min'] ?? '',
      address: jsonObject['address'] ?? '',
      phonenumber: jsonObject['phone_number'] ?? '',
      centerinformation: jsonObject['center_information'] ?? '',
      imageurl: jsonObject['image_url'] ?? '',
      latitude: jsonObject['latitude'] ?? 0,
      longitude: jsonObject['longitude'] ?? 0,
      doctorinfocount: jsonObject['doctor_info_count'] ?? 0,
      doctorinfo: DoctorUser.fromJson(jsonObject['doctor_info']),
      specialitycount: jsonObject['speciality_count'] ?? 0,
      speciality: RecentVisitedModel.fromJson(
        jsonObject['speciality'],
      ),
    );
  }
}
