import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/cubits/cubit/fetch_categories_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/category_widget.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/see_all_widget.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSeeAllWidget(title: 'home.categories'.tr()),
        SizedBox(height: 8),
        SizedBox(
          height: 60.h,
          child: BlocBuilder<FetchCategoriesCubit, FetchCategoriesState>(
            builder: (context, state) {
              if (state is FetchCategoriesFailure) {
                return Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(state.errMessage, maxLines: 5),
                    ),
                    CustomElevatedButton(
                      title: 'common.try_again'.tr(),
                      onPressed: () {
                        context.read<FetchCategoriesCubit>().getCategories();
                      },
                    ),
                  ],
                );
              } else if (state is FetchCategoriesSuccess) {
                return CategoriesListviewBuilder(
                  categories: state.categories,
                  hasMore: state.hasMore,
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ],
    );
  }
}

class CategoriesListviewBuilder extends StatefulWidget {
  const CategoriesListviewBuilder({
    super.key,
    required this.categories,
    required this.hasMore,
  });

  final List<CategoryEntitiy> categories;
  final bool hasMore;

  @override
  State<CategoriesListviewBuilder> createState() =>
      _CategoriesListviewBuilderState();
}

class _CategoriesListviewBuilderState extends State<CategoriesListviewBuilder> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      if (_controller.position.pixels >=
          _controller.position.maxScrollExtent - 200) {
        context.read<FetchCategoriesCubit>().getCategories(loadMore: true);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: _controller,
      scrollDirection: Axis.horizontal,
      itemCount: widget.categories.length + (widget.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index < widget.categories.length) {
          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: CustomCategoryWidget(
              color: AppColors.primaryColor,
              name: widget.categories[index].name,
            ),
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
