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

  factory CenterModel.fromLocal(
    String name,
    int minAge,
    int maxAge,
    String gender,
  ) {
    return CenterModel(
      name: name,
      agemin: minAge,
      agemax: maxAge,
      address:
          '1234 Maple Street - Suite 567, Downtown Building -Toronto, ON M5A 1A1 - Canada',
      gender: gender,
      phonenumber: '+1 123456789',
      centerinformation:
          'At our autism services center, we empower individuals to embrace their unique strengths and unlock their full potential through personalized support.',
      images: [
        CenterImageModel(imageUrl: 'assets/images/autism_help_center.jpg'),
      ],
      latitude: 10.2225,
      longitude: 20.3664,
      doctorinfocount: 2,
      doctorinfo: [
        DoctorUser.fromLocal('Dr.Sophia', 'Martinez',
            'assets/images/doctor_image.jpg', 'female'),
      ],
      specialitycount: 2,
      specialty: [
        RecentVisitedModel.fromLocal(RecentType.childPsychiatry),
        RecentVisitedModel.fromLocal(RecentType.generalPractice),
        RecentVisitedModel.fromLocal(RecentType.developmentalPediatricians),
      ],
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
