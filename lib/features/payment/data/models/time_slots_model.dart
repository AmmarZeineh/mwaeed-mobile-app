class TimeSlot {
  final int dayId;
  final String startTime;
  final String endTime;

  TimeSlot({
    required this.dayId,
    required this.startTime,
    required this.endTime,
  });

  factory TimeSlot.fromJson(Map<String, dynamic> json) {
    return TimeSlot(
      dayId: json['dayId'] ?? 0,
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dayId': dayId,
      'startTime': startTime,
      'endTime': endTime,
    };
  }
}