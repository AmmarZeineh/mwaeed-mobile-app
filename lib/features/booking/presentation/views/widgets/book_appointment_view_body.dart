import 'dart:developer';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:mwaeed_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_field.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/job_model.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/available_slots_cubit/available_slots_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/client_secret_cubit/client_secret_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/create_appointment_cubit/create_appointment_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/create_appointment_cubit/create_appointment_state.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/custom_app_bar.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/service_card_list.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/time_slot_ship.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppoinmentViewBody extends StatefulWidget {
  const BookAppoinmentViewBody({
    super.key,
    required this.services,
    required this.providerEntity,
    required this.job,
  });

  final List<ServiceEntity> services;
  final Job job;
  final ProviderEntity providerEntity;

  @override
  State<BookAppoinmentViewBody> createState() => _BookAppoinmentViewBodyState();
}

class _BookAppoinmentViewBodyState extends State<BookAppoinmentViewBody> {
  ServiceEntity? selectedService;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String selectedTime = '';
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadSlots();
  }

  void _loadSlots() {
    if (selectedService != null) {
      context.read<AvailableSlotsCubit>().loadAvailableSlots(
        jobId: widget.job.jobId,
        providerId: widget.providerEntity.id,
        serviceDuration: selectedService!.durationInMin,
        selectedDate: _selectedDay,
      );
    }
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAppointmentCubit, CreateAppointmentState>(
      listener: (context1, mainState) {
        if (mainState is CreateAppointmentSuccess) {
          showDialog(
            barrierDismissible: selectedService!.depositAmount == null
                ? true
                : false,
            context: context,
            builder: (_) => WillPopScope(
              onWillPop: () async =>
                  selectedService!.depositAmount == null ? true : false,
              child: AlertDialog(
                title: const Text('Success'),
                content: SizedBox(
                  height: 110.h,
                  child: Column(
                    children: [
                      const Text('Appointment booked successfully'),
                      const SizedBox(height: 5),
                      selectedService!.depositAmount == null
                          ? SizedBox()
                          : Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "choose",
                                    style: AppTextStyles.w400_14,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Expanded(
                                      child:
                                          BlocConsumer<
                                            ClientSecretCubit,
                                            ClientSecretState
                                          >(
                                            listener: (context, state) {
                                              if (state
                                                  is ClientSecretFailure) {
                                                showErrorMessage(
                                                  state.message,
                                                  context,
                                                );
                                              } else if (state
                                                  is ClientSecretSuccess) {
                                                log(
                                                  state.clientSecret.toString(),
                                                );
                                                Prefs.setString(
                                                  'appointment${mainState}_secret_key',
                                                  state.clientSecret,
                                                );
                                                showSuccessMessage(
                                                  "Success",
                                                  context,
                                                );
                                                Navigator.pop(context);
                                              }
                                            },
                                            builder: (context, state) {
                                              return ElevatedButton.icon(
                                                onPressed: () {
                                                  context
                                                      .read<ClientSecretCubit>()
                                                      .fetchClientSecret(
                                                        context: context,
                                                        appointmentId:
                                                            mainState.id,
                                                        isDeposit: true,
                                                      );
                                                  Navigator.pop(context1);
                                                },
                                                icon: Icon(
                                                  Icons.payment,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  state is ClientSecretLoading
                                                      ? "جار التحميل"
                                                      : "دفع كامل",
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.green[600],
                                                  foregroundColor: Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                    ),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child:
                                          BlocConsumer<
                                            ClientSecretCubit,
                                            ClientSecretState
                                          >(
                                            listener: (context, state) {
                                              if (state
                                                  is ClientSecretFailure) {
                                                showErrorMessage(
                                                  state.message,
                                                  context,
                                                );
                                              } else if (state
                                                  is ClientSecretSuccess) {
                                                log(
                                                  state.clientSecret.toString(),
                                                );
                                                Prefs.setString(
                                                  'appointment${mainState}_secret_key',
                                                  state.clientSecret,
                                                );
                                                showSuccessMessage(
                                                  "Success",
                                                  context,
                                                );
                                                Navigator.pop(context);
                                              }
                                            },
                                            builder: (context, state) {
                                              return ElevatedButton.icon(
                                                onPressed: () {
                                                  context
                                                      .read<ClientSecretCubit>()
                                                      .fetchClientSecret(
                                                        context: context,
                                                        appointmentId:
                                                            mainState.id,
                                                        isDeposit: false,
                                                      );
                                                  Navigator.pop(context1);
                                                },
                                                icon: Icon(
                                                  Icons.payment,
                                                  color: Colors.white,
                                                ),
                                                label: Text(
                                                  state is ClientSecretLoading
                                                      ? "جار التحميل"
                                                      : "رعبون",
                                                ),
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor:
                                                      Colors.orange[600],
                                                  foregroundColor: Colors.white,
                                                  padding: EdgeInsets.symmetric(
                                                    vertical: 12,
                                                  ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          10,
                                                        ),
                                                  ),
                                                ),
                                              );
                                            },
                                          ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                    ],
                  ),
                ),
                actions: [
                  selectedService!.depositAmount == null
                      ? TextButton(
                          onPressed: () {
                            Navigator.pop(context1);
                          },
                          child: const Text('OK'),
                        )
                      : SizedBox(),
                ],
              ),
            ),
          );
        } else if (mainState is CreateAppointmentFailure) {
          ScaffoldMessenger.of(
            context1,
          ).showSnackBar(SnackBar(content: Text(mainState.message)));
        }
      },
      builder: (context, state) {
        if (state is CreateAppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return Column(
          children: [
            const CustomAppBar(text: "provider_details.book_appointment"),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// 📅 Calendar Section
                    Text(
                      'provider_details.select_date'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TableCalendar(
                        firstDay: DateTime.now(),
                        lastDay: DateTime.now().add(const Duration(days: 365)),
                        focusedDay: _focusedDay,
                        selectedDayPredicate: (day) =>
                            isSameDay(_selectedDay, day),
                        onDaySelected: (selectedDay, focusedDay) {
                          setState(() {
                            _selectedDay = selectedDay;
                            _focusedDay = focusedDay;
                          });
                          _loadSlots();
                        },
                        onPageChanged: (focusedDay) {
                          _focusedDay = focusedDay;
                        },
                        calendarFormat: CalendarFormat.month,
                        startingDayOfWeek: StartingDayOfWeek.sunday,
                        calendarStyle: CalendarStyle(
                          todayDecoration: BoxDecoration(
                            color: Colors.grey[400],
                            shape: BoxShape.circle,
                          ),
                          selectedDecoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                        headerStyle: const HeaderStyle(
                          formatButtonVisible: false,
                          titleCentered: true,
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    /// 🛠️ Service Selection
                    ServiceSelectionList(
                      services: widget.services,
                      selectedService: selectedService,
                      onServiceSelected: (service) {
                        setState(() {
                          selectedService = service;
                        });
                        _loadSlots();
                      },
                    ),

                    const SizedBox(height: 10),
                    Text(
                      'provider_details.select_hour'.tr(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
                      builder: (context, state) {
                        if (state is AvailableSlotsLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else if (state is AvailableSlotsLoaded) {
                          if (state.slots.isEmpty) {
                            return const Center(
                              child: Text("No available appiontment"),
                            );
                          }
                          return Wrap(
                            spacing: 12,
                            runSpacing: 12,
                            children: state.slots
                                .map(
                                  (time) => TimeSlotChip(
                                    time: time,
                                    isSelected: selectedTime == time,
                                    onTap: () {
                                      setState(() {
                                        selectedTime = time;
                                      });
                                    },
                                  ),
                                )
                                .toList(),
                          );
                        } else if (state is AvailableSlotsError) {
                          return Center(child: Text(state.message));
                        }
                        return const SizedBox.shrink();
                      },
                    ),

                    const SizedBox(height: 10),
                    Text("Note", style: AppTextStyles.w600_18),
                    const SizedBox(height: 6),
                    CustomTextField(title: "note", iconData: Icons.note),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: SizedBox(
                        width: double.infinity,
                        child: CustomElevatedButton(
                          onPressed: _confirmAppointment,
                          title: 'provider_details.confirm'.tr(),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void _confirmAppointment() {
    if (selectedService == null || selectedTime.isEmpty) {
      showDialog(
        context: context,
        builder: (context) => const AlertDialog(
          title: Text('Please Select'),
          content: Text('You must select a service and time before booking.'),
        ),
      );
      return;
    }

    final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);

    context.read<CreateAppointmentCubit>().createAppointment(
      providerId: widget.providerEntity.id,
      jobId: widget.job.jobId,
      appointmentDate: formattedDate,
      startTime: selectedTime,
      notes: _noteController.text,
      serviceId: selectedService!.id,
      context: context,
    );
  }
}
