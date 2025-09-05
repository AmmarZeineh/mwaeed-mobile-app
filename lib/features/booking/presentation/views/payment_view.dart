import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/widgets/payment_view_body.dart';

class PaymentView extends StatelessWidget {
  const PaymentView({
    super.key,
    required this.service,
    required this.appointmentDate,
    required this.appointmentTime,
  });
  final ServiceEntity service;
  final String appointmentDate;
  final String appointmentTime;
  static const routeName = '/payment';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PaymentViewBody(
          service: service,
          appointmentDate: appointmentDate,
          appointmentTime: appointmentTime,
        ),
      ),
    );
  }
}

