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
import 'package:mwaeed_mobile_app/features/notification/presentation/cubits/fetch_notification_cubit/fetch_notification_cubit.dart';
import 'package:mwaeed_mobile_app/features/notification/presentation/views/notification_view.dart';
import 'package:mwaeed_mobile_app/features/search/presentation/views/search_view.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    super.initState();
    context.read<FetchNotificationCubit>().fetchNotifications(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: CustomTextField(
                        readOnly: true,
                        title: 'home.search',
                        iconData: Icons.search,
                        heroTag: 'search-field-hero',
                        onTap: () {
                          Navigator.pushNamed(context, SearchView.routeName);
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    // استخدام BlocBuilder للنقطة الحمراء
                    BlocBuilder<FetchNotificationCubit, FetchNotificationState>(
                      builder: (context, state) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.grey.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Stack(
                            children: [
                              // عرض النقطة الحمراء فقط عند وجود notifications غير مقروءة
                              if (state is FetchNotificationSuccess &&
                                  state.hasUnreadNotifications)
                                Positioned(
                                  right: 32,
                                  top: 8,
                                  child: Container(
                                    height:
                                        MediaQuery.of(context).size.width *
                                        0.025,
                                    width:
                                        MediaQuery.of(context).size.width *
                                        0.025,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                  ),
                                ),
                              IconButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    NotificationView.routeName,
                                  );
                                },
                                icon: const Icon(Icons.notifications, size: 28),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const LookingForProviderContainer(),
                const SizedBox(height: 16),
                const CategoriesSection(),
              ],
            ),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 16)),
        SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          sliver: SliverToBoxAdapter(
            child: Text('home.providers'.tr(), style: AppTextStyles.w700_16),
          ),
        ),
        const SliverToBoxAdapter(child: SizedBox(height: 8)),
        BlocBuilder<FetchProvidersCubit, FetchProvidersState>(
          builder: (context, state) {
            if (state is FetchProvidersFailure) {
              return SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
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
