import 'package:autilab_project/features/data/home/data/model/rate_model.dart';

import '../../../doctor/data/model/doctor_model.dart';

class NewappointmentModel {
  final int doctorId;
  final String status;
  final String description;
  final List<RateModel> rateModel;
  final DoctorModel doctorModel;
  WorkSchedule workSchedule;

  NewappointmentModel({
    required this.doctorId,
    required this.status,
    required this.description,
    required this.rateModel,
    required this.doctorModel,
    required this.workSchedule,
  });

  factory NewappointmentModel.fromJson(Map<String, dynamic> jsonObject) {
    var planFeaturesList = (jsonObject['rating'] as List<dynamic>?)
            ?.map(
              (item) => RateModel.fromJson(item),
            )
            .toList() ??
        [];
    return NewappointmentModel(
      doctorId: jsonObject['doctor_id'] ?? 0,
      status: jsonObject['status'] ?? '',
      description: jsonObject['description'] ?? '',
      rateModel: planFeaturesList,
      doctorModel: DoctorModel.fomJson(jsonObject['doctor']),
      workSchedule: WorkSchedule.fromJson(
        jsonObject['work_schedule'],
      ),
    );
  }
}

class WorkSchedule {
  final int id;
  final int doctorid;
  String date;
  String starttime;
  final String endtime;
  final bool isavailable;
  final int slotduration;

  WorkSchedule({
    required this.id,
    required this.doctorid,
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.isavailable,
    required this.slotduration,
  });
  factory WorkSchedule.fromJson(Map<String, dynamic> jsonObject) {
    return WorkSchedule(
      id: jsonObject['id'] ?? 0,
      doctorid: jsonObject['doctor_id'],
      date: jsonObject['date'],
      starttime: jsonObject['start_time'],
      endtime: jsonObject['end_time'],
      isavailable: jsonObject['is_available'],
      slotduration: jsonObject['slot_duration'],
    );
  }
}
