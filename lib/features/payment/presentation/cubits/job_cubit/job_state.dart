import 'package:mwaeed_mobile_app/features/payment/data/models/Jobs_with_services_model.dart';

abstract class JobsServicesState {
  const JobsServicesState();

  List<Object?> get props => [];
}

class JobsServicesInitial extends JobsServicesState {}

class JobsServicesLoading extends JobsServicesState {}

class JobsServicesLoaded extends JobsServicesState {
  final UserJobsResponse data;
  const JobsServicesLoaded(this.data);

  @override
  List<Object?> get props => [data];
}

class JobsServicesError extends JobsServicesState {
  final String message;
  const JobsServicesError(this.message);

  @override
  List<Object?> get props => [message];
}
