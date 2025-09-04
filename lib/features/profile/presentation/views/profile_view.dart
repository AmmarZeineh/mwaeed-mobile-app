import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = 'profile-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: ProfileViewBody()));
  }
}
