import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:mwaeed_mobile_app/core/errors/failure.dart';
import 'package:mwaeed_mobile_app/features/payment/data/models/Jobs_with_services_model.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repo/payment_repo.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/job_cubit/job_state.dart';

class JobsServicesCubit extends Cubit<JobsServicesState> {
  
  final PaymentRepo paymentRepo;

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
