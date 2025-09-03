import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/search/domain/repos/search_repo.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/views/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});
  static const routeName = 'search-view';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocProvider(
          create: (context) => SearchCubit(getIt.get<SearchRepo>()),
          child: SearchViewBody(),
        ),
      ),
    );
  }
}
