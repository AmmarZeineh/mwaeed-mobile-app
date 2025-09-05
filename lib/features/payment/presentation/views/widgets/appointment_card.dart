import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/appointment_entity.dart';

class AppointmentCard extends StatelessWidget {
  final AppointmentEntity appointment;
  final VoidCallback? onTap;
  final VoidCallback? onEdit;
  final VoidCallback? onCancel;

  const AppointmentCard({
    super.key,
    required this.appointment,
    this.onTap,
    this.onEdit,
    this.onCancel,
  });

  Color _getStatusColor(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Colors.orange;
      case 'CONFIRMED':
        return Colors.green;
      case 'CANCELLED':
        return Colors.red;
      case 'COMPLETED':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status.toUpperCase()) {
      case 'PENDING':
        return Icons.schedule;
      case 'CONFIRMED':
        return Icons.check_circle;
      case 'CANCELLED':
        return Icons.cancel;
      case 'COMPLETED':
        return Icons.done_all;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    return DateFormat('dd MMM yyyy', 'ar').format(date);
  }

  String _formatTime(String time) {
    return time;
  }

  @override
  Widget build(BuildContext context) {
    final statusColor = _getStatusColor(appointment.status);
    final statusIcon = _getStatusIcon(appointment.status);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(bottom: 16.h),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: Colors.grey.withOpacity(0.2),
            width: 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status and actions
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20.r),
                    border: Border.all(
                      color: statusColor.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        statusIcon,
                        size: 16.sp,
                        color: statusColor,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        'appointments.${appointment.status.toLowerCase()}'.tr(),
                        style: AppTextStyles.w600_12.copyWith(
                          color: statusColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                if (appointment.status.toUpperCase() == 'PENDING') ...[
                  if (onEdit != null)
                    IconButton(
                      onPressed: onEdit,
                      icon: Icon(
                        Icons.edit_outlined,
                        size: 20.sp,
                        color: AppColors.primaryColor,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 32.w,
                        minHeight: 32.h,
                      ),
                    ),
                  if (onCancel != null)
                    IconButton(
                      onPressed: onCancel,
                      icon: Icon(
                        Icons.close,
                        size: 20.sp,
                        color: Colors.red,
                      ),
                      constraints: BoxConstraints(
                        minWidth: 32.w,
                        minHeight: 32.h,
                      ),
                    ),
                ],
              ],
            ),
            
            SizedBox(height: 16.h),
            
            // Date and Time
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.calendar_today,
                    label: 'appointments.date'.tr(),
                    value: _formatDate(appointment.appointmentDate),
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.access_time,
                    label: 'appointments.time'.tr(),
                    value: '${_formatTime(appointment.startTime)} - ${_formatTime(appointment.endTime)}',
                  ),
                ),
              ],
            ),
            
            SizedBox(height: 12.h),
            
            // Service and Provider Info
            Row(
              children: [
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.design_services,
                    label: 'appointments.service_id'.tr(),
                    value: '#${appointment.serviceId}',
                  ),
                ),
                SizedBox(width: 16.w),
                Expanded(
                  child: _buildInfoItem(
                    icon: Icons.person,
                    label: 'appointments.provider_id'.tr(),
                    value: '#${appointment.providerId}',
                  ),
                ),
              ],
            ),
            
            if (appointment.notes.isNotEmpty) ...[
              SizedBox(height: 12.h),
              _buildInfoItem(
                icon: Icons.note_outlined,
                label: 'appointments.notes'.tr(),
                value: appointment.notes,
                maxLines: 2,
              ),
            ],
            
            SizedBox(height: 16.h),
            
            // Payment Info
            Container(
              padding: EdgeInsets.all(12.w),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8.r),
                border: Border.all(
                  color: Colors.grey.withOpacity(0.2),
                  width: 1,
                ),
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.payment,
                        size: 16.sp,
                        color: AppColors.primaryColor,
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        'appointments.payment_info'.tr(),
                        style: AppTextStyles.w600_14.copyWith(
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Spacer(),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: appointment.isFullyPaid ? Colors.green : Colors.orange,
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Text(
                          appointment.isFullyPaid
                              ? 'appointments.fully_paid'.tr()
                              : 'appointments.partial_payment'.tr(),
                          style: AppTextStyles.w600_12.copyWith(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'appointments.total_paid'.tr(),
                            style: AppTextStyles.w400_12.copyWith(
                              color: Colors.grey[600],
                            ),
                          ),
                          Text(
                            '${appointment.totalPaid} ${'common.currency'.tr()}',
                            style: AppTextStyles.w600_14.copyWith(
                              color: Colors.green,
                            ),
                          ),
                        ],
                      ),
                      if (appointment.remainingAmount > 0)
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              'appointments.remaining'.tr(),
                              style: AppTextStyles.w400_12.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            Text(
                              '${appointment.remainingAmount} ${'common.currency'.tr()}',
                              style: AppTextStyles.w600_14.copyWith(
                                color: Colors.orange,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                  if (appointment.depositPaid) ...[
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          size: 14.sp,
                          color: Colors.green,
                        ),
                        SizedBox(width: 4.w),
                        Text(
                          'appointments.deposit_paid'.tr(),
                          style: AppTextStyles.w400_12.copyWith(
                            color: Colors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
            
            SizedBox(height: 8.h),
            
            // Footer with ID and created date
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${'appointments.id'.tr()}: #${appointment.id}',
                  style: AppTextStyles.w400_12.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
                Text(
                  _formatDate(appointment.createdAt),
                  style: AppTextStyles.w400_12.copyWith(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required String label,
    required String value,
    int maxLines = 1,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: Colors.grey[600],
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: AppTextStyles.w400_12.copyWith(
                color: Colors.grey[600],
              ),
            ),
          ],
        ),
        SizedBox(height: 2.h),
        Text(
          value,
          style: AppTextStyles.w600_14,
          maxLines: maxLines,
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }
}