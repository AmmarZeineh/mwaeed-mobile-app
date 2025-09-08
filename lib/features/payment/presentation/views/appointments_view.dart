import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repos/payment_repo.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/fetch_appointments_cubit/fetch_appointments_cubit.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/widgets/appointments_view_body.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/repos/rating_repo.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/cubits/fetch_user_rating_cubit/fetch_user_rating_cubit.dart';

class AppointmentsView extends StatelessWidget {
  const AppointmentsView({super.key});
  static const String routeName = 'appointments-view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                FetchAppointmentsCubit(getIt.get<PaymentRepo>()),
          ),
          BlocProvider(
            create: (context) => FetchUserRatingCubit(getIt.get<RatingRepo>()),
          ),
        ],
        child: AppointmentsViewBody(),
      ),
    );
  }
}
