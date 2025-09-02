import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/book_appointment_view_body.dart';

class BookAppointmentView extends StatelessWidget {
  const BookAppointmentView({super.key});
  static const routeName = 'book_appoinment';
  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: BookAppoinmentViewBody()));
  }
}
