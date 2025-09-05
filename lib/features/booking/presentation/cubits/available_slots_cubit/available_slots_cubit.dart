import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/appointment_model.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';
import 'package:mwaeed_mobile_app/features/payment/data/models/Schedule_model.dart';

part 'available_slots_state.dart';

class AvailableSlotsCubit extends Cubit<AvailableSlotsState> {
  final BookingRepo repository;

  AvailableSlotsCubit(this.repository) : super(AvailableSlotsInitial());
  

  Future<void> loadAvailableSlots({
    required int jobId,
    required int providerId,
    required int serviceDuration,
    required DateTime selectedDate,
  }) async {
    emit(AvailableSlotsLoading());

    try {
      // 🔹 1. Get appointments
      final appointmentsResult = await repository.getProviderAppointments(
        providerId: providerId,
        jobId: jobId,
      );

      // 🔹 2. Get schedule
      final scheduleResult = await repository.getProviderSchedule(
        providerId: providerId,
        jobId: jobId,
      );

      appointmentsResult.fold(
        (failure) => emit(AvailableSlotsError(failure.message)),
        (appointments) {
          scheduleResult.fold(
            (failure) => emit(AvailableSlotsError(failure.message)),
            (schedules) {
              // 🔹 3. Get schedule for selected day
              final scheduleForDay = schedules.firstWhere(
                (s) =>
                    s.dayOfWeek.toUpperCase() ==
                    selectedDate.weekdayName.toUpperCase(),
                orElse: () =>
                    Schedule(id: 0, dayOfWeek: '', timeSlots: [], jobId: jobId),
              );

              // 🔹 4. Calculate available slots
              final slots = calculateAvailableSlots(
                appointments: appointments,
                schedule: scheduleForDay,
                serviceDurationInMin: serviceDuration,
                selectedDate: selectedDate,
              );

              emit(AvailableSlotsLoaded(slots));
            },
          );
        },
      );
    } catch (e) {
      emit(AvailableSlotsError(e.toString()));
    }
  }
}

List<String> calculateAvailableSlots({
  required List<Appointment> appointments,
  required Schedule schedule,
  required int serviceDurationInMin,
  required DateTime selectedDate,
}) {
  final List<String> availableSlots = [];

  if (schedule.dayOfWeek.toUpperCase() !=
      selectedDate.weekdayName.toUpperCase()) {
    return availableSlots; // Not a working day
  }

  for (var slot in schedule.timeSlots) {
    DateTime start = DateTime.parse(
      '${selectedDate.toIso8601String().split('T').first} ${slot.startTime}',
    );
    DateTime end = slot.endTime.isEmpty
        ? start.add(const Duration(hours: 8))
        : DateTime.parse(
            '${selectedDate.toIso8601String().split('T').first} ${slot.endTime}',
          );

    while (start.add(Duration(minutes: serviceDurationInMin)).isBefore(end) ||
        start
            .add(Duration(minutes: serviceDurationInMin))
            .isAtSameMomentAs(end)) {
      final currentEnd = start.add(Duration(minutes: serviceDurationInMin));

      final isBooked = appointments.any((a) {
        final bookedStart = DateTime.parse(
          '${a.appointmentDate.toIso8601String().split('T').first} ${a.startTime}',
        );
        final bookedEnd = DateTime.parse(
          '${a.appointmentDate.toIso8601String().split('T').first} ${a.endTime}',
        );
        return start.isBefore(bookedEnd) && currentEnd.isAfter(bookedStart);
      });

      if (!isBooked) {
        availableSlots.add(
          '${start.hour.toString().padLeft(2, '0')}:${start.minute.toString().padLeft(2, '0')}',
        );
      }

      start = start.add(Duration(minutes: serviceDurationInMin));
    }
  }

  return availableSlots;
}

extension WeekdayExt on DateTime {
  String get weekdayName {
    const days = [
      'MONDAY',
      'TUESDAY',
      'WEDNESDAY',
      'THURSDAY',
      'FRIDAY',
      'SATURDAY',
      'SUNDAY',
    ];
    return days[weekday - 1];
  }
}
