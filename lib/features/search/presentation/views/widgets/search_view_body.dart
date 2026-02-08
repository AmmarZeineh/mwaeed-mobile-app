import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/enums/search_type.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_field.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/cubits/search_cubit/search_cubit.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/views/widgets/custom_segments_button.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/views/widgets/search_list_bloc_builder.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  SearchType _searchType = SearchType.provider;
  String searchString = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent * 0.8) {
      // When user scrolls to 80% of the list, load more
      final cubit = context.read<SearchCubit>();
      final state = cubit.state;
      if (state is SearchSuccess && state.hasMoreData) {
        cubit.loadMore();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                CustomTextField(
                  title: 'home.search',
                  iconData: Icons.search,
                  heroTag: 'search-page-field-hero',
                  readOnly: false,
                  autofocus: true,
                  onSubmitted: (p0) {
                    searchString = p0;
                    if (searchString.isNotEmpty) {
                      context.read<SearchCubit>().search(
                        searchString,
                        _searchType.value,
                        isNewSearch: true,
                      );
                    }
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  'search.what_are_you_looking_for'.tr(),
                  style: AppTextStyles.w700_16,
                ),
                const SizedBox(height: 12),
                SizedBox(
                  width: double.infinity,
                  child: CustomSegmentButtons(
                    onChanged: (SearchType value) {
                      setState(() => _searchType = value);
                      // If there's an active search, restart it with new type
                      if (searchString.isNotEmpty) {
                        context.read<SearchCubit>().search(
                          searchString,
                          value.value,
                          isNewSearch: true,
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SearchListBlocBuilder(
            searchString: searchString,
            searchType: _searchType,
          ),
        ],
      ),
    );
  }
}
