// service_entity.dart

import 'package:mwaeed_mobile_app/features/booking/data/models/service_model.dart';

class ServiceEntity {
  final int id;
  final String name;
  final String description;
  final double price;
  final double? depositAmount;
  final int durationInMin;

  ServiceEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.depositAmount,
    required this.durationInMin,
  });

  // تحويل من الموديل إلى الانتتيتي
  factory ServiceEntity.fromModel(ServiceModel model) {
    return ServiceEntity(
      id: model.id,
      name: model.name,
      description: model.description,
      price: model.price,
      depositAmount: model.depositAmount,
      durationInMin: model.durationInMin,
    );
  }
}
