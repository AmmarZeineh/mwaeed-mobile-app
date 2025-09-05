import 'package:mwaeed_mobile_app/features/profile/domain/entities/city_entity.dart';

class CityModel {
  final String enName;
  final String arName;

  CityModel({required this.enName, required this.arName});
  factory CityModel.fromJson(Map<String, dynamic> json) =>
      CityModel(enName: json['nameEn'], arName: json['nameAr']);

  CityEntity toEntity() => CityEntity(enName: enName, arName: arName);
}
