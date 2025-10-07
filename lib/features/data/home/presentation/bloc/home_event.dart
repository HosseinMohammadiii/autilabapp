/// Base class for all home-related events.
abstract class HomeEvent {}

/// Event to trigger display of current home information.
final class DisplayHomeContent extends HomeEvent {}

final class DisplayAppointmentList extends HomeEvent {}
