import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mwaeed_mobile_app/core/helper_classes/date_helper.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/entities/appointment_entity.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/entities/rating_entity.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/cubits/edit_rating_cubit/edit_rating_cubit.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/views/widgets/edit_rating_dialog.dart';

class RatingItemWidget extends StatelessWidget {
  final RatingEntity rating;
  final bool isEdit;
  final AppointmentEntity? appointmentEntity;

  const RatingItemWidget({
    super.key,
    required this.rating,
    this.isEdit = false,
    this.appointmentEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person,
                  color: Colors.grey.shade600,
                  size: 28,
                ),
              ),
              SizedBox(width: 12),

              Expanded(
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          rating.userEntity.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          DateHelper.getFormattedDateEnglish(rating.createdAt),
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                    Spacer(),
                    isEdit
                        ? IconButton(
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => EditRatingDialog(
                                  providerName: rating.providerEntity.name,
                                  currentRating: rating.score,
                                  currentComment: rating.comment,
                                  onUpdate: (score, comment) {
                                    context.read<EditRatingCubit>().editRating(
                                      ratingId: rating.id,
                                      context: context,
                                      providerId: rating.providerEntity.id,
                                      appointmentId: appointmentEntity!.id,
                                      rating: score,
                                      comment: comment,
                                    );
                                  },
                                  onDelete: () {},
                                ),
                              );
                            },
                            icon: Icon(Icons.edit),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // التعليق
          if (rating.comment.isNotEmpty)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                rating.comment,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.black87,
                  height: 1.4,
                ),
              ),
            ),

          SizedBox(height: 12),

          // التقييم بالنجوم
          Row(
            children: [
              Text(
                'rating:',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
              SizedBox(width: 4),
              Text(
                '${rating.score}/5',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              Spacer(),
              ...List.generate(5, (index) {
                return Icon(
                  index < rating.score ? Icons.star : Icons.star_outline,
                  color: Colors.amber,
                  size: 20,
                );
              }),
              SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
