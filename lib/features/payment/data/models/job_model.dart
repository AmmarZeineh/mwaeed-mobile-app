
import 'package:mwaeed_mobile_app/features/payment/data/models/service_model.dart';

class Job {
  final int jobId;
  final String jobName;
  final List<Service> services;

  Job({required this.jobId, required this.jobName, required this.services});

  factory Job.fromJson(Map<String, dynamic> json) {
    return Job(
      jobId: json['jobId'],
      jobName: json['jobName'],
      services: (json['services'] as List<dynamic>)
          .map((e) => Service.fromJson(e))
          .toList(),
    );
  }
}
