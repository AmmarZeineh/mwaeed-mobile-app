import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repo/payment_repo.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/job_cubit/job_cubit.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/widgets/provider_details_view_body.dart';

class ProviderDetailsView extends StatelessWidget {
  const ProviderDetailsView({super.key, required this.provider});
  static const String routeName = '/providerDetails';
  final ProviderEntity provider;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) =>
              JobsServicesCubit(getIt.get<PaymentRepo>())
                ..fetchJobsWithServices(provider.id),
          child: ProviderDetailsViewBody(providerEntity: provider),
        ),
      ),
    );
  }
}
