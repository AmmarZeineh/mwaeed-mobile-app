import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/enums/search_type.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/home_provider_container.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/cubits/search_cubit/search_cubit.dart';

class SearchListBlocBuilder extends StatelessWidget {
  const SearchListBlocBuilder({
    super.key,
    required this.searchString,
    required SearchType searchType,
  }) : _searchType = searchType;

  final String searchString;
  final SearchType _searchType;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchState>(
      builder: (context, state) {
        final cubit = context.read<SearchCubit>();

        if (state is SearchLoading) {
          return const SliverToBoxAdapter(
            child: Center(child: CircularProgressIndicator()),
          );
        } else if (state is SearchFailure) {
          return SliverToBoxAdapter(
            child: Center(
              child: Column(
                children: [
                  Text(state.errMessage, style: AppTextStyles.w400_16),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      if (searchString.isNotEmpty) {
                        cubit.search(
                          searchString,
                          _searchType.value,
                          isNewSearch: true,
                        );
                      }
                    },
                    child: Text('retry'.tr()),
                  ),
                ],
              ),
            ),
          );
        } else if (state is SearchLoadMoreFailure) {
          // Show error for loading more but keep existing data
          return SliverList(
            delegate: SliverChildListDelegate([
              // Use a Column inside SliverPadding to match the styling
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  children: [
                    // Show existing providers
                    ...cubit.providers.map(
                      (provider) =>
                          HomeProviderContainer(providerEntity: provider),
                    ),
                    // Show error message and retry button
                    const SizedBox(height: 16),
                    Center(
                      child: Column(
                        children: [
                          Text(
                            'Failed to load more: ${state.errMessage}',
                            style: AppTextStyles.w400_16,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          CustomElevatedButton(
                            onPressed: () => cubit.loadMore(),
                            title: 'retry'.tr(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          );
        }

        // For SearchSuccess and SearchLoadingMore states
        final providers = cubit.providers;
        if (providers.isEmpty && state is SearchSuccess) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text(
                'search.no_results_found'.tr(),
                style: AppTextStyles.w400_16,
              ),
            ),
          );
        }

        return SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // Show providers
              if (index < providers.length) {
                return HomeProviderContainer(providerEntity: providers[index]);
              }

              // Show loading indicator at the end if loading more
              if (index == providers.length && state is SearchLoadingMore) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              return null;
            },
            childCount: providers.length + (state is SearchLoadingMore ? 1 : 0),
          ),
        );
      },
    );
  }
}
