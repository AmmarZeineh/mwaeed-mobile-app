import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/home/domain/repos/home_repo.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/cubits/fetch_providers_cubit/fetch_providers_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  static const routeName = 'home-view';
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) =>
                FetchCategoriesCubit(getIt.get<HomeRepo>())..getCategories(),
          ),
          BlocProvider(
            create: (context) =>
                FetchProvidersCubit(getIt.get<HomeRepo>())..getProviders(),
          ),
        ],
        child: const HomeViewBody(),
      ),
    );
  }
}
