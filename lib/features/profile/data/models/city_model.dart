import 'package:mwaeed_mobile_app/features/profile/domain/entities/city_entity.dart';

class CityModel {
  final String enName;

  CityModel({required this.enName});
  factory CityModel.fromJson(Map<String, dynamic> json) =>
      CityModel(enName: json['name']);

  CityEntity toEntity() => CityEntity(enName: enName);
}
