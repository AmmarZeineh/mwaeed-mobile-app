import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/repos/profile_repo.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/widgets/profile_view_body.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});
  static const routeName = 'profile-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) =>
                  ProfileCubit(getIt.get<ProfileRepo>())..getCities(),
            ),
            
          ],
          child: ProfileViewBody(),
        ),
      ),
    );
  }
}
