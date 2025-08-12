class RateModel {
  final int doctorId;
  final int patientId;
  final int appointmentId;
  final int rating;
  final int ratingTitle;
  RateModel({
    required this.doctorId,
    required this.patientId,
    required this.appointmentId,
    required this.rating,
    required this.ratingTitle,
  });

  factory RateModel.fromJson(Map<String, dynamic> jsonObject) {
    return RateModel(
      doctorId: jsonObject['doctor_id'],
      patientId: jsonObject['patient_id'],
      appointmentId: jsonObject['appointment_id'],
      rating: jsonObject['rating'],
      ratingTitle: jsonObject['reasons']['title'],
    );
  }
}
