import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/job_cubit/job_state.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/jobs_with_services_model.dart';

class JobsServicesCubit extends Cubit<JobsServicesState> {
  final BookingRepo paymentRepo;

  JobsServicesCubit(this.paymentRepo) : super(JobsServicesInitial());

  Future<void> fetchJobsWithServices(int userId) async {
    emit(JobsServicesLoading());
    final Either<Failure, UserJobsResponse> result = await paymentRepo
        .getJobsWithservice(id: userId);

    result.fold(
      (failure) => emit(JobsServicesError(failure.message)),
      (data) => emit(JobsServicesLoaded(data)),
    );
  }
}
