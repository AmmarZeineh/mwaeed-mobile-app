import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_field.dart';
import 'package:mwaeed_mobile_app/features/booking/data/models/job_model.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/available_slots_cubit/available_slots_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/create_appointment_cubit/create_appointment_cubit.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/create_appointment_cubit/create_appointment_state.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/custom_app_bar.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/service_card_list.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/time_slot_ship.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppointmentViewBody extends StatefulWidget {
  const BookAppointmentViewBody({
    super.key,
    required this.services,
    required this.providerEntity,
    required this.job,
  });

  final List<ServiceEntity> services;
  final Job job;
  final ProviderEntity providerEntity;

  @override
  State<BookAppointmentViewBody> createState() =>
      _BookAppointmentViewBodyState();
}

class _BookAppointmentViewBodyState extends State<BookAppointmentViewBody> {
  // State variables
  ServiceEntity? selectedService;
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String selectedTime = '';
  final TextEditingController _noteController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  @override
  void dispose() {
    _noteController.dispose();
    super.dispose();
  }

  // Initialize data
  void _initializeData() {
    // Set first service as default if available
    if (widget.services.isNotEmpty) {
      selectedService = widget.services.first;
      _loadAvailableSlots();
    }
  }

  // Load available slots for selected service and date
  void _loadAvailableSlots() {
    if (selectedService != null) {
      context.read<AvailableSlotsCubit>().loadAvailableSlots(
        jobId: widget.job.jobId,
        providerId: widget.providerEntity.id,
        serviceDuration: selectedService!.durationInMin,
        selectedDate: _selectedDay,
      );
    }
  }

  // Handle day selection
  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (selectedDay.isBefore(
      DateTime.now().subtract(const Duration(days: 1)),
    )) {
      return; // Don't allow past dates
    }

    setState(() {
      _selectedDay = selectedDay;
      _focusedDay = focusedDay;
      selectedTime = ''; // Reset selected time when date changes
    });
    _loadAvailableSlots();
  }

  // Handle service selection
  void _onServiceSelected(ServiceEntity service) {
    setState(() {
      selectedService = service;
      selectedTime = ''; // Reset selected time when service changes
    });
    _loadAvailableSlots();
  }

  // Handle time slot selection
  void _onTimeSlotSelected(String time) {
    setState(() {
      selectedTime = time;
    });
  }

  // Validate form before confirmation
  bool _validateForm() {
    if (selectedService == null) {
      _showValidationDialog('validation.select_service'.tr());
      return false;
    }

    if (selectedTime.isEmpty) {
      _showValidationDialog('validation.select_time'.tr());
      return false;
    }

    return true;
  }

  // Show validation dialog
  void _showValidationDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('validation.title'.tr()),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('common.ok'.tr()),
          ),
        ],
      ),
    );
  }

  // Confirm appointment
  void _confirmAppointment() {
    if (!_validateForm()) return;

    final formattedDate = DateFormat('yyyy-MM-dd').format(_selectedDay);

    context.read<CreateAppointmentCubit>().createAppointment(
      providerId: widget.providerEntity.id,
      jobId: widget.job.jobId,
      appointmentDate: formattedDate,
      startTime: selectedTime,
      notes: _noteController.text.trim(),
      serviceId: selectedService!.id,
      context: context,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateAppointmentCubit, CreateAppointmentState>(
      listener: _handleCreateAppointmentState,
      builder: (context, state) {
        if (state is CreateAppointmentLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return _buildMainContent();
      },
    );
  }

  // Handle create appointment state changes
  void _handleCreateAppointmentState(
    BuildContext context,
    CreateAppointmentState state,
  ) {
    if (state is CreateAppointmentSuccess) {
      _showSuccessDialog(state);
    } else if (state is CreateAppointmentFailure) {
      showErrorMessage(state.message, context);
    }
  }

  // Show success dialog after appointment creation
  void _showSuccessDialog(CreateAppointmentSuccess state) {
    final hasDeposit = selectedService?.depositAmount != null;

    showDialog(
      barrierDismissible: !hasDeposit,
      context: context,
      builder: (_) => AlertDialog(
        title: Text('success.title'.tr()),
        content: SizedBox(
          height: 60.h,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [Text('success.appointment_booked'.tr())],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('common.ok'.tr()),
          ),
        ],
      ),
    );
  }

  // Build payment buttons

  // Build main content
  Widget _buildMainContent() {
    return Column(
      children: [
        const CustomAppBar(text: "provider_details.book_appointment"),
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildDateSection(),
                SizedBox(height: 24.h),
                _buildServiceSection(),
                SizedBox(height: 24.h),
                _buildTimeSlotSection(),
                SizedBox(height: 24.h),
                _buildNotesSection(),
                SizedBox(height: 32.h),
                _buildConfirmButton(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  // Build date selection section
  Widget _buildDateSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('provider_details.select_date'.tr(), style: AppTextStyles.w600_18),
        SizedBox(height: 12.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey[200]!),
          ),
          child: TableCalendar(
            firstDay: DateTime.now(),
            lastDay: DateTime.now().add(const Duration(days: 365)),
            focusedDay: _focusedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: _onDaySelected,
            onPageChanged: (focusedDay) => _focusedDay = focusedDay,
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
              outsideDaysVisible: false,
            ),
            headerStyle: const HeaderStyle(
              formatButtonVisible: false,
              titleCentered: true,
              leftChevronIcon: Icon(Icons.chevron_left),
              rightChevronIcon: Icon(Icons.chevron_right),
            ),
          ),
        ),
      ],
    );
  }

  // Build service selection section
  Widget _buildServiceSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'provider_details.select_service'.tr(),
          style: AppTextStyles.w600_18,
        ),
        SizedBox(height: 12.h),
        ServiceSelectionList(
          services: widget.services,
          selectedService: selectedService,
          onServiceSelected: _onServiceSelected,
        ),
      ],
    );
  }

  // Build time slot section
  Widget _buildTimeSlotSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('provider_details.select_hour'.tr(), style: AppTextStyles.w600_18),
        SizedBox(height: 12.h),
        BlocBuilder<AvailableSlotsCubit, AvailableSlotsState>(
          builder: (context, state) {
            if (state is AvailableSlotsLoading) {
              return SizedBox(
                height: 60.h,
                child: const Center(child: CircularProgressIndicator()),
              );
            }
            if (state is AvailableSlotsError) {
              return Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  color: Colors.red[50],
                  borderRadius: BorderRadius.circular(8.r),
                  border: Border.all(color: Colors.red[200]!),
                ),
                child: Text(
                  state.message,
                  style: TextStyle(color: Colors.red[700]),
                ),
              );
            }

            if (state is AvailableSlotsLoaded) {
              if (state.slots.isEmpty) {
                return Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: Colors.orange[50],
                    borderRadius: BorderRadius.circular(8.r),
                    border: Border.all(color: Colors.orange[200]!),
                  ),
                  child: Text(
                    'booking.no_available_slots'.tr(),
                    style: TextStyle(color: Colors.orange[700]),
                  ),
                );
              }

              return Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: state.slots
                    .map(
                      (time) => TimeSlotChip(
                        time: time,
                        isSelected: selectedTime == time,
                        onTap: () => _onTimeSlotSelected(time),
                      ),
                    )
                    .toList(),
              );
            }

            return const SizedBox.shrink();
          },
        ),
      ],
    );
  }

  // Build notes section
  Widget _buildNotesSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('booking.notes'.tr(), style: AppTextStyles.w600_18),
        SizedBox(height: 12.h),
        CustomTextField(
          controller: _noteController,
          title: 'booking.notes_placeholder'.tr(),
          iconData: Icons.note_outlined,
        ),
      ],
    );
  }

  // Build confirm button
  Widget _buildConfirmButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomElevatedButton(
        onPressed: _confirmAppointment,
        title: 'provider_details.confirm'.tr(),
      ),
    );
  }
}
