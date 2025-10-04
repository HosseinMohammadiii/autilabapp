/// Base class for all authentication-related events.
abstract class DoctorEvent {}

/// Event to trigger display of all doctors.
final class DisplayDoctors extends DoctorEvent {}

final class DisplayDoctorWorkScheduel extends DoctorEvent {
  final int doctorId;
  DisplayDoctorWorkScheduel({required this.doctorId});
}

final class SetAppointmentPatient extends DoctorEvent {
  final int doctorId;
  final int scheduelId;
  final String description;
  SetAppointmentPatient(
      {required this.doctorId,
      required this.scheduelId,
      required this.description});
}
