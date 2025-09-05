import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

// إضافة enum لحالات المواعيد
enum AppointmentStatus { PENDING, CONFIRMED, CANCELLED, COMPLETED }

class AppointmentSegmentButtons extends StatefulWidget {
  const AppointmentSegmentButtons({super.key, required this.onChanged});
  final ValueChanged<AppointmentStatus> onChanged;

  @override
  State<AppointmentSegmentButtons> createState() =>
      _AppointmentSegmentButtonsState();
}

class _AppointmentSegmentButtonsState extends State<AppointmentSegmentButtons> {
  AppointmentStatus _selectedStatus = AppointmentStatus.PENDING;

  // دالة للحصول على لون الخلفية حسب الحالة
  Color _getBackgroundColor(AppointmentStatus status, bool isSelected) {
    if (!isSelected) {
      return const Color(0xfff3f4f6);
    }

    switch (status) {
      case AppointmentStatus.PENDING:
        return Colors.orange;
      case AppointmentStatus.CONFIRMED:
        return Colors.green;
      case AppointmentStatus.CANCELLED:
        return Colors.red;
      case AppointmentStatus.COMPLETED:
        return Colors.blue;
    }
  }

  // دالة للحصول على لون النص والأيقونة
  Color _getForegroundColor(AppointmentStatus status, bool isSelected) {
    if (!isSelected) {
      return Colors.black87;
    }
    return Colors.white;
  }

  // دالة للحصول على لون الحدود
  Color _getBorderColor(AppointmentStatus status) {
    switch (status) {
      case AppointmentStatus.PENDING:
        return Colors.orange.withOpacity(0.15);
      case AppointmentStatus.CONFIRMED:
        return Colors.green.withOpacity(0.15);
      case AppointmentStatus.CANCELLED:
        return Colors.red.withOpacity(0.15);
      case AppointmentStatus.COMPLETED:
        return Colors.blue.withOpacity(0.15);
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> statusItems = [
      {
        'status': AppointmentStatus.PENDING,
        'label': 'appointments.pending'.tr(),
        'icon': Icons.schedule,
      },
      {
        'status': AppointmentStatus.CONFIRMED,
        'label': 'appointments.confirmed'.tr(),
        'icon': Icons.check_circle_outline,
      },
      {
        'status': AppointmentStatus.CANCELLED,
        'label': 'appointments.cancelled'.tr(),
        'icon': Icons.cancel_outlined,
      },
      {
        'status': AppointmentStatus.COMPLETED,
        'label': 'appointments.completed'.tr(),
        'icon': Icons.done_all,
      },
    ];

    return SizedBox(
      height: 60,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: statusItems.length,
        itemBuilder: (context, index) {
          final item = statusItems[index];
          final status = item['status'] as AppointmentStatus;
          final isSelected = _selectedStatus == status;

          return Padding(
            padding: EdgeInsets.only(
              right: index < statusItems.length - 1 ? 12 : 0,
            ),
            child: _buildStatusButton(
              status: status,
              label: item['label'] as String,
              icon: item['icon'] as IconData,
              isSelected: isSelected,
            ),
          );
        },
      ),
    );
  }

  Widget _buildStatusButton({
    required AppointmentStatus status,
    required String label,
    required IconData icon,
    required bool isSelected,
  }) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedStatus = status;
          widget.onChanged(_selectedStatus);
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: _getBackgroundColor(status, isSelected),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: _getBorderColor(status), width: 1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 18,
              color: _getForegroundColor(status, isSelected),
            ),
            const SizedBox(width: 6),
            Text(
              label,
              style: AppTextStyles.w600_14.copyWith(
                color: _getForegroundColor(status, isSelected),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
