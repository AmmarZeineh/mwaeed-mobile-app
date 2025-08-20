import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/cubits/fetch_categories_cubit/fetch_categories_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/category_widget.dart';

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
