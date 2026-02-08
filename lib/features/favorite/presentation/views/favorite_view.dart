import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/features/favorite/domain/repos/favorite_repo.dart';
import 'package:mwaeed_mobile_app/features/favorite/presentation/cubits/fetch_favorite_cubit/fetch_favorite_cubit.dart';
import 'package:mwaeed_mobile_app/features/favorite/presentation/views/widgets/favorite_view_body.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocProvider(
        create: (context) =>
            FetchFavoriteCubit(getIt.get<FavoriteRepo>())
              ..getFavorites(context: context),
        child: FavoriteViewBody(),
      ),
    );
  }
}
