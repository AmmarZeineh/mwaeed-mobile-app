import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/booking/presentation/views/provider_details.dart';
import 'package:mwaeed_mobile_app/features/favorite/presentation/cubits/favorite_cubit/add_favorite_cubit.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

class HomeProviderContainer extends StatelessWidget {
  const HomeProviderContainer({super.key, required this.providerEntity});
  final ProviderEntity providerEntity;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Material(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 2, // بديل للـ boxShadow
        shadowColor: Colors.grey.withValues(alpha: 0.1),
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(
              context,
              ProviderDetailsView.routeName,
              arguments: providerEntity,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: Colors.grey.withValues(alpha: 0.2),
                width: 1,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey[100], // إضافة لون خلفية للأيقونة
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 40,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(width: 16),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(providerEntity.name, style: AppTextStyles.w600_18),
                        const SizedBox(height: 4),

                        Text(
                          providerEntity.categories.isNotEmpty
                              ? providerEntity.categories[0].name
                              : 'No category',
                          style: AppTextStyles.w500_14.copyWith(
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                providerEntity.city,
                                style: AppTextStyles.w400_12.copyWith(
                                  color: Colors.grey[600],
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),

                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            const SizedBox(width: 4),
                            Text('4.0', style: AppTextStyles.w500_14),
                            const SizedBox(width: 8),
                            Text(
                              '10 Reviews',
                              style: AppTextStyles.w400_12.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  BlocBuilder<AddFavoriteCubit, AddFavoriteState>(
                    builder: (context, state) {
                      bool isFavorite = false;

                      if (state is AddFavoriteSuccess) {
                        isFavorite = state.isFavorite;
                      }

                      return IconButton(
                        onPressed: () {
                          context.read<AddFavoriteCubit>().toggleFavorite(
                            providerId: providerEntity.id, // حط الـ id المناسب
                            context: context,
                            isFavorite: isFavorite,
                          );
                        },
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          color: Colors.red,
                          size: 24,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
