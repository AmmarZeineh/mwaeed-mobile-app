import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/cubits/client_secret_cubit/client_secret_cubit.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/appointment_entity.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repos/payment_repo.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/cancel_appointment_cubit/cancel_appointment_cubit.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/cubits/fetch_appointments_cubit/fetch_appointments_cubit.dart';

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

  bool _canCancelAppointment(String status) {
    return status.toUpperCase() == 'PENDING' ||
        status.toUpperCase() == 'CONFIRMED';
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
          border: Border.all(color: Colors.grey.withOpacity(0.2), width: 1),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with status and cancel button
            Row(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 12.w,
                    vertical: 6.h,
                  ),
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
                      Icon(statusIcon, size: 16.sp, color: statusColor),
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
                // زر الإلغاء في الزاوية العلوية اليمنى
                if (_canCancelAppointment(appointment.status))
                  BlocProvider(
                    create: (context) =>
                        CancelAppointmentCubit(getIt.get<PaymentRepo>()),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.red.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8.r),
                        border: Border.all(
                          color: Colors.red.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child:
                          BlocConsumer<
                            CancelAppointmentCubit,
                            CancelAppointmentState
                          >(
                            listener: (context, state) {
                              if (state is CancelAppointmentSuccess) {
                                context
                                    .read<FetchAppointmentsCubit>()
                                    .fetchAppointments(
                                      context: context,
                                      state: appointment.status,
                                    );
                              }
                            },
                            builder: (context, state) {
                              if (state is CancelAppointmentLoading) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: CircularProgressIndicator(),
                                  ),
                                );
                              } else if (state is CancelAppointmentFailure) {
                                return Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      'Error',
                                      style: AppTextStyles.w400_14.copyWith(
                                        color: Colors.red,
                                      ),
                                    ),
                                  ),
                                );
                              }

                              return IconButton(
                                onPressed: () async {
                                  await context
                                      .read<CancelAppointmentCubit>()
                                      .cancelAppointment(
                                        context: context,
                                        appointmentId: appointment.id,
                                        state: appointment.status,
                                      );
                                },
                                icon: Icon(
                                  Icons.close,
                                  size: 20.sp,
                                  color: Colors.red,
                                ),
                                constraints: BoxConstraints(
                                  minWidth: 36.w,
                                  minHeight: 36.h,
                                ),
                                tooltip: 'إلغاء الموعد',
                              );
                            },
                          ),
                    ),
                  ),
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
                    value:
                        '${_formatTime(appointment.startTime)} - ${_formatTime(appointment.endTime)}',
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
            appointment.status == 'CANCELLED'
                ? SizedBox()
                : Container(
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

                        if (appointment.remainingAmount > 0)
                          GestureDetector(
                            onTap: () async {
                              showDialog(
                                context: context,
                                builder: (context) => BlocProvider(
                                  create: (context) => ClientSecretCubit(
                                    getIt.get<BookingRepo>(),
                                  ),
                                  child: AlertDialog(
                                    content: SizedBox(
                                      height: 120.h,
                                      child: Column(
                                        children: [
                                          Text(
                                            'Choose payment',
                                            style: AppTextStyles.w600_16,
                                          ),
                                          SizedBox(height: 24),
                                          BlocBuilder<
                                            ClientSecretCubit,
                                            ClientSecretState
                                          >(
                                            builder: (context, state) {
                                              if (state
                                                  is ClientSecretLoading) {
                                                return Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                );
                                              } else if (state
                                                  is ClientSecretFailure) {
                                                return Text(
                                                  'Error: ${state.message}',
                                                  style: AppTextStyles.w400_14
                                                      .copyWith(
                                                        color: Colors.red,
                                                      ),
                                                );
                                              }
                                              if (state
                                                  is ClientSecretSuccess) {
                                                return CustomElevatedButton(
                                                  title: 'pay.pay'.tr(),
                                                  onPressed: () async {
                                                    showDialog(
                                                      context: context,
                                                      barrierDismissible: false,
                                                      builder: (context) => AlertDialog(
                                                        content: Column(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: [
                                                            CircularProgressIndicator(),
                                                            SizedBox(
                                                              height: 16,
                                                            ),
                                                            Text(
                                                              'جاري تحضير الدفع...',
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                    try {
                                                      // 2. تهيئة Payment Sheet
                                                      await Stripe.instance.initPaymentSheet(
                                                        paymentSheetParameters: SetupPaymentSheetParameters(
                                                          paymentIntentClientSecret:
                                                              state
                                                                  .clientSecret,
                                                          merchantDisplayName:
                                                              "Mwaeed",
                                                          style:
                                                              ThemeMode.light,
                                                          appearance: PaymentSheetAppearance(
                                                            colors:
                                                                PaymentSheetAppearanceColors(
                                                                  primary:
                                                                      Colors
                                                                          .blue,
                                                                ),
                                                          ),
                                                          // إضافة billing details إذا كانت متوفرة
                                                          customerId:
                                                              null, // أضف customer ID إذا كان متوفراً
                                                          customerEphemeralKeySecret:
                                                              null, // أضف ephemeral key إذا كان متوفراً
                                                          setupIntentClientSecret:
                                                              null,
                                                          allowsDelayedPaymentMethods:
                                                              true,
                                                        ),
                                                      );

                                                      Navigator.pop(
                                                        context,
                                                      ); // إغلاق loading dialog

                                                      // 3. عرض Payment Sheet
                                                      await Stripe.instance
                                                          .presentPaymentSheet();
                                                      Navigator.pop(context);
                                                      // 4. الدفع نجح - تحديث حالة الموعد
                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        const SnackBar(
                                                          content: Text(
                                                            "✅ تم الدفع بنجاح",
                                                          ),
                                                          backgroundColor:
                                                              Colors.green,
                                                          duration: Duration(
                                                            seconds: 3,
                                                          ),
                                                        ),
                                                      );
                                                    } on StripeException catch (
                                                      e
                                                    ) {
                                                      Navigator.pop(context);

                                                      print(
                                                        'Stripe Error: ${e.error}',
                                                      );

                                                      String errorMessage;
                                                      switch (e.error.code) {
                                                        case FailureCode
                                                            .Canceled:
                                                          errorMessage =
                                                              "تم إلغاء عملية الدفع";
                                                          break;
                                                        case FailureCode.Failed:
                                                          errorMessage =
                                                              "فشل في عملية الدفع";
                                                          break;
                                                        case FailureCode
                                                            .Timeout:
                                                          errorMessage =
                                                              "انتهت مهلة الدفع";
                                                          break;
                                                        default:
                                                          errorMessage =
                                                              "خطأ في الدفع: ${e.error.localizedMessage ?? 'خطأ غير معروف'}";
                                                      }

                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            errorMessage,
                                                          ),
                                                          backgroundColor:
                                                              Colors.red,
                                                          duration: Duration(
                                                            seconds: 4,
                                                          ),
                                                        ),
                                                      );
                                                    } catch (e) {
                                                      Navigator.pop(
                                                        context,
                                                      ); // إغلاق loading dialog إذا كان مفتوحاً

                                                      print(
                                                        'General Error: $e',
                                                      );

                                                      ScaffoldMessenger.of(
                                                        context,
                                                      ).showSnackBar(
                                                        SnackBar(
                                                          content: Text(
                                                            "خطأ عام: $e",
                                                          ),
                                                          backgroundColor:
                                                              Colors.red,
                                                          duration: Duration(
                                                            seconds: 4,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  },
                                                );
                                              }
                                              return ChoosFullyOrDepositButtons(
                                                appointmentEntity: appointment,
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: 16.w,
                                vertical: 8.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green,

                                borderRadius: BorderRadius.circular(12.r),
                              ),
                              child: Text(
                                'payment.pay'.tr(),
                                style: AppTextStyles.w600_12.copyWith(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
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
            Icon(icon, size: 14.sp, color: Colors.grey[600]),
            SizedBox(width: 4.w),
            Text(
              label,
              style: AppTextStyles.w400_12.copyWith(color: Colors.grey[600]),
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

class ChoosFullyOrDepositButtons extends StatelessWidget {
  const ChoosFullyOrDepositButtons({
    super.key,
    required this.appointmentEntity,
  });
  final AppointmentEntity appointmentEntity;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              await context.read<ClientSecretCubit>().fetchClientSecret(
                context: context,
                appointmentId: appointmentEntity.id,
                isDeposit: true,
              );
            },
            icon: Icon(Icons.payment, color: Colors.white),
            label: Text("دفع كامل"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.green[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        SizedBox(width: 12),
        Expanded(
          child: ElevatedButton.icon(
            onPressed: () async {
              await context.read<ClientSecretCubit>().fetchClientSecret(
                context: context,
                appointmentId: appointmentEntity.id,
                isDeposit: false,
              );
            },
            icon: Icon(Icons.account_balance_wallet, color: Colors.white),
            label: Text("عربون"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.orange[600],
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
