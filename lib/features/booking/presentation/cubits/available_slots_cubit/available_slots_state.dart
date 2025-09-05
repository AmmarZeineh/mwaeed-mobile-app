part of 'available_slots_cubit.dart';

abstract class AvailableSlotsState {}

class AvailableSlotsInitial extends AvailableSlotsState {}

class AvailableSlotsLoading extends AvailableSlotsState {}

class AvailableSlotsLoaded extends AvailableSlotsState {
  final List<String> slots;

  AvailableSlotsLoaded(this.slots);
}

class AvailableSlotsError extends AvailableSlotsState {
  final String message;
  AvailableSlotsError(this.message);
}
