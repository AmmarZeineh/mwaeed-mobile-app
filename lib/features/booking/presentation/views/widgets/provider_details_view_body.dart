import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/job_model.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/job_cubit/job_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/job_cubit/job_state.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/book_appoinment_view.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/custom_app_bar.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/job_services_section.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/provider_card.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/selected_job_dialog.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

class ProviderDetailsViewBody extends StatelessWidget {
  const ProviderDetailsViewBody({super.key, required this.providerEntity});
  final ProviderEntity providerEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CustomAppBar(text: "provider_details.provider_details"),
        ProviderCard(providerEntity: providerEntity),
        const SizedBox(height: 10),

        // const AboutMeSection(),

        // const SizedBox(height: 15),
        // const WorkingTimeSection(),

        // const SizedBox(height: 15),
        // ReviewsSection(),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text("services", style: AppTextStyles.w700_16),
        ),
        const SizedBox(height: 15),
        Expanded(child: JobsServicesSection(userId: providerEntity.id)),

        SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomElevatedButton(
              title: "provider_details.book_appointment".tr(),
              onPressed: () async {
                final cubit = context.read<JobsServicesCubit>();
                final state = cubit.state;
                log(context.read<UserCubit>().currentUser!.email);

                if (state is JobsServicesLoaded) {
                  final selectedJob = await showDialog<Job>(
                    context: context,
                    builder: (context) =>
                        JobSelectionDialog(jobs: state.data.jobs),
                  );

                  if (selectedJob != null) {
                    Navigator.pushNamed(
                      // ignore: use_build_context_synchronously
                      context,
                      BookAppointmentView.routeName,
                      arguments: {
                        'provider': providerEntity,
                        'job': selectedJob,
                        'services': selectedJob.services
                            .map(
                              (service) => ServiceEntity(
                                id: service.id,
                                name: service.name,
                                description: service.description,
                                price: service.price,
                                depositAmount: service.depositAmount,
                                durationInMin: service.durationInMin,
                                // إذا الـ Entity تحتوي على أيقونة
                              ),
                            )
                            .toList(),
                      },
                    );
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('الرجاء الانتظار حتى تحميل المهن'),
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
