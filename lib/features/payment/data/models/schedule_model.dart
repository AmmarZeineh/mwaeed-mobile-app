import 'package:mwaeed_mobile_app/features/payment/data/models/time_slots_model.dart';

class Schedule {
  final int id;
  final String dayOfWeek;
  final int jobId;
  final List<TimeSlot> timeSlots;

  Schedule({
    required this.id,
    required this.dayOfWeek,
    required this.jobId,
    required this.timeSlots,
  });

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
      id: json['id'] ?? 0,
      dayOfWeek: json['dayOfWeek'] ?? '',
      jobId: json['jobId'] ?? 0,
      timeSlots: (json['timeSlots'] as List<dynamic>)
          .map((slot) => TimeSlot.fromJson(slot))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'dayOfWeek': dayOfWeek,
      'jobId': jobId,
      'timeSlots': timeSlots.map((slot) => slot.toJson()).toList(),
    };
  }
}
