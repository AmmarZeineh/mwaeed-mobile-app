import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/favorite/presentation/cubits/fetch_favorite_cubit/fetch_favorite_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/home_provider_container.dart';

class FavoriteViewBody extends StatefulWidget {
  const FavoriteViewBody({super.key});

  @override
  State<FavoriteViewBody> createState() => _FavoriteViewBodyState();
}

class _FavoriteViewBodyState extends State<FavoriteViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<FetchFavoriteCubit>().getFavorites(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'nav.favorite'.tr(),
            textAlign: TextAlign.center,
            style: AppTextStyles.w600_18.copyWith(
              color: AppColors.primaryColor,
            ),
          ),
        ),
        Expanded(
          child: BlocBuilder<FetchFavoriteCubit, FetchFavoriteState>(
            builder: (context, state) {
              if (state is FetchFavoriteFailure) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(state.message, maxLines: 5),
                      const SizedBox(height: 12),
                      CustomElevatedButton(
                        title: 'common.try_again'.tr(),
                        onPressed: () {
                          context.read<FetchFavoriteCubit>().getFavorites(
                            context: context,
                          );
                        },
                      ),
                    ],
                  ),
                );
              } else if (state is FetchFavoriteSuccess) {
                return RefreshIndicator(
                  onRefresh: () async {
                    await context.read<FetchFavoriteCubit>().getFavorites(
                      context: context,
                    );
                  },
                  child: FavoriteListView(providers: state.favorites),
                );
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ],
    );
  }
}

class FavoriteListView extends StatelessWidget {
  const FavoriteListView({super.key, required this.providers});
  final List<ProviderEntity> providers;

  @override
  Widget build(BuildContext context) {
    if (providers.isEmpty) {
      return ListView(
        physics:
            const AlwaysScrollableScrollPhysics(), // مهم حتى لو فاضي يشتغل السحب
        children: const [
          SizedBox(height: 200),
          Center(child: Text("No favorites yet")),
        ],
      );
    }

    return ListView.builder(
      physics:
          const AlwaysScrollableScrollPhysics(), // حتى يشتغل الرفريش بالسحب
      itemCount: providers.length,
      itemBuilder: (context, index) {
        return HomeProviderContainer(providerEntity: providers[index]);
      },
    );
  }
}
