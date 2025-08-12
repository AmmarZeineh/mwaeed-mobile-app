import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_text_field.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/categories_section.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/home_provider_container.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/looking_for_provider_container.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    // var categoryColors = const [
    //   AppColors.appBlue,
    //   AppColors.appGreen,
    //   AppColors.appRed,
    //   AppColors.appPurple,
    //   AppColors.appOrange,
    // ];
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
            child: Text('Providers', style: AppTextStyles.w700_16),
          ),
        ),
        SliverToBoxAdapter(child: SizedBox(height: 8)),
        SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          sliver: SliverList.builder(
            itemCount: 10,
            itemBuilder: (context, index) => HomeProviderContainer(),
          ),
        ),
      ],
    );
  }
}
