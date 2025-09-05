import 'dart:developer';

import 'package:mwaeed_mobile_app/features/home/data/models/category_model.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/category_entitiy.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

class ProviderModel {
  final int id;
  final String name;
  final String phone;
  final String city;
  final List<CategoryEntitiy> categories;

  ProviderModel({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.categories,
  });

  factory ProviderModel.fromJson(Map<String, dynamic> json) {
    log(json.toString());
    return ProviderModel(
      id: json['id'],
      name: json['name'],
      phone: json['phoneNumber'],
      city: json['city'] ?? ' ',
      categories: List.generate(
        json['jobs'].length,
        (index) => CategoryModel.fromJson(json['jobs'][index]).toEntity(),
      ),
    );
  }

  toEntity() => ProviderEntity(
    id: id,
    name: name,
    phone: phone,
    city: city,
    categories: categories,
  );
}
