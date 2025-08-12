import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/category_widget.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/see_all_widget.dart';

class CategoriesSection extends StatelessWidget {
  const CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomSeeAllWidget(title: 'categories'),
        SizedBox(height: 8),
        SizedBox(
          height: 60.h,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: CustomCategoryWidget(color: AppColors.primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
