import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';

class ProviderEntity {
  final int id;
  final String name;
  final String phone;
  final String city;
  final List<CategoryEntitiy> categories;

  ProviderEntity({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.categories,
  });
}
