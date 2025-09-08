import 'package:mwaeed_mobile_app/features/auth/data/models/user_model.dart';
import 'package:mwaeed_mobile_app/features/home/data/models/provider_model.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/entities/rating_entity.dart';

class RatingModel {
  final int id;
  final String comment;
  final int score;
  final String createdAt;
  final String updatedAt;
  final ProviderModel providerModel;
  final UserModel userModel;

  RatingModel({
    required this.id,
    required this.userModel,
    required this.comment,
    required this.score,
    required this.createdAt,
    required this.updatedAt,
    required this.providerModel,
  });

  factory RatingModel.fromJson(Map<String, dynamic> json) => RatingModel(
    id: json['id'] as int,
    comment: json['comment'] as String,
    score: json['score'] as int,
    createdAt: json['createdAt'] as String,
    updatedAt: json['updatedAt'] as String,
    providerModel: ProviderModel.fromJson(
      json['provider'] as Map<String, dynamic>,
    ),
    userModel: UserModel.fromRatingJson(json['client'] as Map<String, dynamic>),
  );

  RatingEntity toEntity() {
    return RatingEntity(
      id: id,
      comment: comment,
      score: score,
      createdAt: createdAt,
      updatedAt: updatedAt,
      providerEntity: providerModel.toEntity(),
      userEntity: userModel.toEntity(),
    );
  }
}
