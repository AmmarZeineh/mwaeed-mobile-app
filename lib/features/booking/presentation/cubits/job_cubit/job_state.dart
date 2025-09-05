import 'package:mwaeed_mobile_app/features/booking/data/models/jobs_with_services_model.dart';

abstract class JobsServicesState {
  const JobsServicesState();
}

class JobsServicesInitial extends JobsServicesState {}

class JobsServicesLoading extends JobsServicesState {}

class JobsServicesLoaded extends JobsServicesState {
  final UserJobsResponse data;
  const JobsServicesLoaded(this.data);
}

class JobsServicesError extends JobsServicesState {
  final String message;
  const JobsServicesError(this.message);
}
