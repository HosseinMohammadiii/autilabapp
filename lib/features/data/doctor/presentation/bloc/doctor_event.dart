/// Base class for all authentication-related events.
abstract class DoctorEvent {}

/// Event to trigger display of current user information.
final class DisplayDoctors extends DoctorEvent {}
