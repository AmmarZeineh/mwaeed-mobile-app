import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/fetch_appointments_cubit/fetch_appointments_cubit.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/widgets/appointment_card.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/widgets/appointments_segment_buttons.dart';

class AppointmentsViewBody extends StatefulWidget {
  const AppointmentsViewBody({super.key});

  @override
  State<AppointmentsViewBody> createState() => _AppointmentsViewBodyState();
}

class _AppointmentsViewBodyState extends State<AppointmentsViewBody> {
  @override
  initState() {
    super.initState();
    context.read<FetchAppointmentsCubit>().fetchAppointments(
      context: context,
      state: 'PENDING',
    );
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 16),
            child: Text(
              'nav.appointments'.tr(),
              textAlign: TextAlign.center,
              style: AppTextStyles.w600_18.copyWith(
                color: AppColors.primaryColor,
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: AppointmentSegmentButtons(
              onChanged: (value) {
                context.read<FetchAppointmentsCubit>().fetchAppointments(
                  context: context,
                  state: value.name,
                );
              },
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16)),

        BlocBuilder<FetchAppointmentsCubit, FetchAppointmentsState>(
          builder: (context, state) {
            if (state is FetchAppointmentsLoading) {
              return SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            } else if (state is FetchAppointmentsSuccess) {
              return SliverList.builder(
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AppointmentCard(
                      appointment: state.appointments[index],
                    ),
                  );
                },
                itemCount: state.appointments.length,
              );
            } else if (state is FetchAppointmentsFailure) {
              return SliverToBoxAdapter(
                child: Center(child: Text(state.errMessage)),
              );
            }
            return SliverToBoxAdapter(child: SizedBox());
          },
        ),
      ],
    );
  }
}
