import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/job_model.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/available_slots_cubit/available_slots_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/create_appointment_cubit/create_appointment_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/book_appointment_view_body.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({
    super.key,
    required this.job,
    required this.services,
    required this.providerEntity,
  });
  static const routeName = 'book_appoinment';
  final ProviderEntity providerEntity;
  final Job job;
  final List<ServiceEntity> services;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  AvailableSlotsCubit(getIt.get<BookingRepo>()),
            ),
            BlocProvider(
              create: (context) =>
                  CreateAppointmentCubit(getIt.get<BookingRepo>()),
            ),
          ],
          child: BookAppointmentViewBody(
            job: job,
            providerEntity: providerEntity,
            services: services,
          ),
        ),
      ),
    );
  }
}
