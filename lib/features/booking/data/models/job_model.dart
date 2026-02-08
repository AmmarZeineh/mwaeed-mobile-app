import 'package:mwaeed_mobile_app/features/booking/data/models/service_model.dart';

class Job {
  final int jobId;
  final String jobName;
  final List<ServiceModel> services;

  Job({required this.jobId, required this.jobName, required this.services});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['jobId'],
      jobName: (json['localizations'] as List).isNotEmpty
          ? json['localizations'][0]['name'] // ناخد أول اسم من الـ localizations
          : '',
      services: (json['services'] as List<dynamic>)
          .map((e) => ServiceModel.fromJson(e))
          .toList(),
    );
  }
}
