class WorkscheduelDoctorModel {
  final String id;
  final int doctorId;
  final String date;
  final List<Time> times;

  WorkscheduelDoctorModel({
    required this.id,
    required this.doctorId,
    required this.date,
    required this.times,
  });

  factory WorkscheduelDoctorModel.fromJson(Map<String, dynamic> json) {
    var timesList = (json['times'] as List<dynamic>?)
            ?.map(
              (item) => Time.fromJson(item),
            )
            .toList() ??
        [];
    return WorkscheduelDoctorModel(
      id: json['merged work_schedules IDs'] ?? '0',
      doctorId: json['doctor_id'],
      date: json['date'],
      times: timesList,
    );
  }
}

class Time {
  final String date;
  final String starttime;
  final String endtime;
  final bool isavailable;
  final int slotduration;

  Time({
    required this.date,
    required this.starttime,
    required this.endtime,
    required this.isavailable,
    required this.slotduration,
  });

  factory Time.fromJson(Map<String, dynamic> json) {
    return Time(
      date: json['date'] ?? '',
      starttime: json['start_time'] ?? '',
      endtime: json['end_time'] ?? '',
      isavailable: json['is_available'] ?? true,
      slotduration: json['slot_duration'] ?? 0,
    );
  }
}
