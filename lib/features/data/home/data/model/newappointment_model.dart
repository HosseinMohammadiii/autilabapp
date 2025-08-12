import 'package:autilab_project/features/data/home/data/model/rate_model.dart';

import '../../../doctor/data/model/doctor_model.dart';

class NewappointmentModel {
  final int doctorId;
  final String status;
  final String description;
  final List<RateModel> rateModel;
  final DoctorModel doctorModel;

  NewappointmentModel({
    required this.doctorId,
    required this.status,
    required this.description,
    required this.rateModel,
    required this.doctorModel,
  });

  factory NewappointmentModel.fromJson(Map<String, dynamic> jsonObject) {
    var ratingList = (jsonObject['rating'] as List<dynamic>?)
            ?.map((item) => RateModel.fromJson(item))
            .toList() ??
        [];
    return NewappointmentModel(
      doctorId: jsonObject['doctor_id'] ?? 0,
      status: jsonObject['status'] ?? '',
      description: jsonObject['description'] ?? '',
      rateModel: ratingList,
      doctorModel: DoctorModel.fomJson(jsonObject['doctor']),
    );
  }
}
