import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';

class RatingEntity {
  final int id;
  final String comment;
  final int score;
  final String createdAt;
  final String updatedAt;
  final ProviderEntity providerEntity;
  final UserEntity userEntity;

  RatingEntity({
    required this.id,
    required this.userEntity,
    required this.comment,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.providerEntity,
  });
}
