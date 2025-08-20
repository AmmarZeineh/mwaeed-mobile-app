import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/widgets/home_provider_container.dart';

class SliverProviderListviewBuilder extends StatelessWidget {
  const SliverProviderListviewBuilder({super.key, required this.providers});
  final List<ProviderEntity> providers;

  @override
  Widget build(BuildContext context) {
    return SliverPadding(
      padding: EdgeInsetsGeometry.symmetric(horizontal: 16),
      sliver: SliverList.builder(
        itemCount: providers.length,
        itemBuilder: (context, index) =>
            HomeProviderContainer(providerEntity: providers[index]),
      ),
    );
  }
}
