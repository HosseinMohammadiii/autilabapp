class CenterModel {
  final String name;
  final int ageMin;
  final int ageMax;
  final String address;
  final String phoneNumber;
  final String centerInformation;
  final String imageUrl;
  final String latitude;
  final String longitude;
  CenterModel({
    required this.name,
    required this.ageMin,
    required this.ageMax,
    required this.address,
    required this.phoneNumber,
    required this.centerInformation,
    required this.imageUrl,
    required this.latitude,
    required this.longitude,
  });
  factory CenterModel.fromJosn(Map<String, dynamic> jsonObject) {
    return CenterModel(
      name: jsonObject['name'],
      ageMin: jsonObject[' age_min'],
      ageMax: jsonObject['age_max'],
      address: jsonObject['address'],
      phoneNumber: jsonObject['phone_number'],
      centerInformation: jsonObject['center_information'],
      imageUrl: jsonObject['image_url'],
      latitude: jsonObject['latitude'],
      longitude: jsonObject['longitude'],
    );
  }
}
