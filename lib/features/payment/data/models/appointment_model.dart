class Appointment {
  final int id;
  final int clientId;
  final int providerId;
  final int jobId;
  final int serviceId;
  final DateTime appointmentDate;
  final String startTime;
  final String endTime;
  final String status;
  final String notes;
  final DateTime createdAt;
  final DateTime updatedAt;

  Appointment({
    required this.id,
    required this.clientId,
    required this.providerId,
    required this.jobId,
    required this.serviceId,
    required this.appointmentDate,
    required this.startTime,
    required this.endTime,
    required this.status,
    required this.notes,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Appointment.fromJson(Map<String, dynamic> json) {
    return Appointment(
      id: json['id'] ?? 0,
      clientId: json['clientId'] ?? 0,
      providerId: json['providerId'] ?? 0,
      jobId: json['jobId'] ?? 0,
      serviceId: json['serviceId'] ?? 0,
      appointmentDate: DateTime.tryParse(json['appointmentDate'] ?? '') ?? DateTime.now(),
      startTime: json['startTime'] ?? '',
      endTime: json['endTime'] ?? '',
      status: json['status'] ?? '',
      notes: json['notes'] ?? '',
      createdAt: DateTime.tryParse(json['createdAt'] ?? '') ?? DateTime.now(),
      updatedAt: DateTime.tryParse(json['updatedAt'] ?? '') ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'clientId': clientId,
      'providerId': providerId,
      'jobId': jobId,
      'serviceId': serviceId,
      'appointmentDate': appointmentDate.toIso8601String(),
      'startTime': startTime,
      'endTime': endTime,
      'status': status,
      'notes': notes,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }
}
