import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';

class UserModel {
  final String accessToken;
  final int id;
  final String name;
  final String email;
  final String phoneNumber;
  final String city;

  UserModel({
    required this.accessToken,
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.city,
  });

  UserModel.fromJson(Map<String, dynamic> json)
    : accessToken = json['accessToken'],
      id = json['user']['id'],
      name = json['user']['name'],
      email = json['user']['email'],
      phoneNumber = json['user']['phoneNumber'],
      city = json['user']['city'] ?? ' ';

  factory UserModel.fromRatingJson(Map<String, dynamic> json) => UserModel(
    accessToken: '',
    id: json['id'],
    name: json['name'],
    email: '',
    phoneNumber: '',
    city: '',
  );

  toEntity() => UserEntity(
    accessToken: accessToken,
    id: id,
    name: name,
    email: email,
    phoneNumber: phoneNumber,
    city: city,
  );
}
