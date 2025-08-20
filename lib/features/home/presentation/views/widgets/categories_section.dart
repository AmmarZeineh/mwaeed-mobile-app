import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/categories_list_view_builder.dart';
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
