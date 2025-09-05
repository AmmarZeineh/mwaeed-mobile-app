import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final localizations = json['localizations'] as List<dynamic>? ?? [];
    final firstLocalization = localizations.isNotEmpty
        ? localizations[0] as Map<String, dynamic>
        : {};

    return CategoryModel(
      id: firstLocalization['id'] ?? 0, // 🔥 Default 0 لو null
      name: firstLocalization['name']?.toString() ?? '', // 🔥 Default ''
    );
  }

  toEntity() => CategoryEntitiy(id: id, name: name);
}
