import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';

class CategoryModel {
  final int id;
  final String name;

  CategoryModel({required this.id, required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['localizations'][0]['id'],
      name: json['localizations'][0]['name'],
    );
  }

  toEntity() => CategoryEntitiy(id: id, name: name);
}
