import 'package:autilab_project/features/data/home/data/model/rate_model.dart';

import '../../../doctor/data/model/doctor_model.dart';

class NewappointmentModel {
  final int doctorId;
  final String status;
  final String description;
  final RateModel rateModel;
  final DoctorModel doctorModel;
  // final String created;

  NewappointmentModel({
    required this.doctorId,
    required this.status,
    required this.description,
    required this.rateModel,
    required this.doctorModel,
    // required this.created,
  });

  factory NewappointmentModel.fromJson(Map<String, dynamic> jsonObject) {
    return NewappointmentModel(
      doctorId: jsonObject['doctor_id'] ?? 0,
      status: jsonObject['status'] ?? '',
      description: jsonObject['description'] ?? '',
      rateModel: RateModel.fromJson(jsonObject['rating']),
      doctorModel: DoctorModel.fomJson(jsonObject['doctor']),
    );
  }
}
