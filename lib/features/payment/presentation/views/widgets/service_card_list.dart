import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/service_entity.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/widgets/service_card.dart';

class ServiceSelectionList extends StatelessWidget {
  final List<ServiceEntity> services;
  final ServiceEntity? selectedService;
  final Function(ServiceEntity) onServiceSelected;

  const ServiceSelectionList({
    super.key,
    required this.services,
    required this.selectedService,
    required this.onServiceSelected,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 4),
        itemCount: services.length,
        itemBuilder: (context, index) {
          final service = services[index];
          final isSelected = selectedService?.id == service.id;

          return Container(
            width: 160,
            margin: const EdgeInsets.only(right: 12),
            child: ServiceCard(
              service: service,
              isSelected: isSelected,
              onTap: () => onServiceSelected(service),
            ),
          );
        },
      ),
    );
  }
}
