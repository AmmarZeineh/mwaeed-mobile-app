import 'package:easy_localization/easy_localization.dart';
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

    var categories = ['Doctors', 'Engineers', 'Plumbers'];
    var names = ['Ahmed', 'Mohammed', 'Abd Alrahman'];
    var rates = ['4.5', '4.2', '4.1'];
    var location = ['Damascus', 'Aleppo', 'Homs'];
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
        SliverPadding(
          padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
          sliver: SliverList.builder(
            itemCount: 3,
            itemBuilder: (context, index) => HomeProviderContainer(
              name: names[index],
              rate: rates[index],
              cat: categories[index],
              location: location[index],
            ),
          ),
        ),
      ],
    );
  }
}
