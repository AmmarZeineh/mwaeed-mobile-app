import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_field.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/cubits/fetch_providers_cubit/fetch_providers_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/categories_section.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/looking_for_provider_container.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/sliver_provider_list_view_builder.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                SizedBox(height: 16),
                CustomTextField(title: 'home.search', iconData: Icons.search),
                SizedBox(height: 16),
                LookingForProviderContainer(),
                SizedBox(height: 16),
                CategoriesSection(),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text('home.providers'.tr(), style: AppTextStyles.w700_16),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 8)),
        BlocBuilder<FetchProvidersCubit, FetchProvidersState>(
          builder: (context, state) {
            if (state is FetchProvidersFailure) {
              return SliverToBoxAdapter(
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Text(state.errMessage, maxLines: 5),
                    ),
                    CustomElevatedButton(
                      title: 'common.try_again'.tr(),
                      onPressed: () {
                        context.read<FetchProvidersCubit>().getProviders();
                      },
                    ),
                  ],
                ),
              );
            } else if (state is FetchProvidersSuccess) {
              return SliverProviderListviewBuilder(providers: state.providers);
            } else {
              return const SliverToBoxAdapter(
                child: Center(child: CircularProgressIndicator()),
              );
            }
          },
        ),
      ],
    );
  }
}
