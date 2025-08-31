/// Base class for all authentication-related events.
abstract class DoctorEvent {}

/// Event to trigger display of all doctors.
final class DisplayDoctors extends DoctorEvent {}
