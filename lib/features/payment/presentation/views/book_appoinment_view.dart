
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/payment/data/models/job_model.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repo/payment_repo.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/available_slots_cubit/available_slots_cubit.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/create_appointment_cubit/create_appointment_cubit.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/widgets/book_appointment_view_body.dart';

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
                  AvailableSlotsCubit(getIt.get<PaymentRepo>()),
            ),
            BlocProvider(
              create: (context) =>
                  CreateAppointmentCubit(getIt.get<PaymentRepo>()),
            ),
          ],
          child: BookAppoinmentViewBody(
            job: job,
            providerEntity: providerEntity,
            services: services,
          ),
        ),
      ),
    );
  }
}
