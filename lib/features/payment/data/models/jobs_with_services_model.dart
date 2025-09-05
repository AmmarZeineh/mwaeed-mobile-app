
import 'package:mwaeed_mobile_app/features/payment/data/models/job_model.dart';

class UserJobsResponse {
  final int userId;
  final List<Job> jobs;

  UserJobsResponse({required this.userId, required this.jobs});

  factory UserJobsResponse.fromJson(Map<String, dynamic> json) {
    return UserJobsResponse(
      userId: json['userId'],
      jobs: (json['jobs'] as List<dynamic>)
          .map((e) => Job.fromJson(e))
          .toList(),
    );
  }
}
