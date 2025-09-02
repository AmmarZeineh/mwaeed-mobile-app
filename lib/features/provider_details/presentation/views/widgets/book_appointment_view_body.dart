import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/custom_app_bar.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/time_slot_ship.dart';
import 'package:table_calendar/table_calendar.dart';

class BookAppoinmentViewBody extends StatefulWidget {
  const BookAppoinmentViewBody({super.key});

  @override
  State<BookAppoinmentViewBody> createState() => _BookAppoinmentViewBodyState();
}

class _BookAppoinmentViewBodyState extends State<BookAppoinmentViewBody> {
  DateTime _selectedDay = DateTime.now();
  DateTime _focusedDay = DateTime.now();
  String selectedTime = '10:00 AM';

  final List<String> timeSlots = [
    '09:00 AM',
    '09:30 AM',
    '10:00 AM',
    '10:30 AM',
    '11:00 AM',
    '11:30 AM',
    '03:00 PM',
    '03:30 PM',
    '04:00 PM',
    '04:30 PM',
    '05:00 PM',
    '05:30 PM',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(text: "provider_details.book_appointment"),
        Expanded(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                // Calendar Section
                Text(
                  'provider_details.select_date'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Table Calendar
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: TableCalendar<Event>(
                    firstDay: DateTime.now().subtract(const Duration(days: 30)),
                    lastDay: DateTime.now().add(const Duration(days: 365)),
                    focusedDay: _focusedDay,
                    selectedDayPredicate: (day) => isSameDay(_selectedDay, day),

                    // Calendar Style
                    calendarStyle: CalendarStyle(
                      // Today style
                      todayDecoration: BoxDecoration(
                        color: Colors.grey[400],
                        shape: BoxShape.circle,
                      ),

                      // Selected day style
                      selectedDecoration: BoxDecoration(
                        color: AppColors.primaryColor,
                        shape: BoxShape.circle,
                      ),

                      // Weekend style
                      weekendTextStyle: const TextStyle(color: Colors.black),

                      // Default text style
                      defaultTextStyle: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),

                      // Selected text style
                      selectedTextStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),

                      // Outside days (previous/next month)
                      outsideDaysVisible: true,
                      outsideTextStyle: TextStyle(color: Colors.grey[400]),

                      // Markers
                      markersMaxCount: 0,
                    ),

                    // Header Style
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleCentered: true,
                      titleTextStyle: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                      leftChevronIcon: const Icon(
                        Icons.chevron_left,
                        color: Colors.black,
                        size: 20,
                      ),
                      rightChevronIcon: const Icon(
                        Icons.chevron_right,
                        color: Colors.black,
                        size: 20,
                      ),
                      headerPadding: const EdgeInsets.symmetric(vertical: 8),
                    ),

                    // Days of week style
                    daysOfWeekStyle: DaysOfWeekStyle(
                      weekdayStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                      weekendStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),

                    // Calendar format
                    calendarFormat: CalendarFormat.month,
                    startingDayOfWeek: StartingDayOfWeek.sunday,

                    // Callbacks
                    onDaySelected: (selectedDay, focusedDay) {
                      if (!isSameDay(_selectedDay, selectedDay)) {
                        setState(() {
                          _selectedDay = selectedDay;
                          _focusedDay = focusedDay;
                        });
                      }
                    },

                    onPageChanged: (focusedDay) {
                      _focusedDay = focusedDay;
                    },

                    // Disable past dates
                    enabledDayPredicate: (day) {
                      return day.isAfter(
                        DateTime.now().subtract(const Duration(days: 1)),
                      );
                    },
                  ),
                ),

                const SizedBox(height: 40),

                // Time Selection Section
                Text(
                  'provider_details.select_hour'.tr(),
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 16),

                // Time Slots Grid
                Wrap(
                  spacing: 12,
                  runSpacing: 12,
                  children: timeSlots
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
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: SizedBox(
            width: double.infinity,
            child: CustomElevatedButton(
              onPressed: () {
                _confirmAppointment();
              },
              title: 'provider_details.confirm'.tr(),
            ),
          ),
        ),
      ],
    );
  }

  void _confirmAppointment() {
    final formattedDate = DateFormat('dd/MM/yyyy').format(_selectedDay);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Appointment Confirmed'),
        content: Text(
          'Your appointment has been booked for $formattedDate at $selectedTime',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}
