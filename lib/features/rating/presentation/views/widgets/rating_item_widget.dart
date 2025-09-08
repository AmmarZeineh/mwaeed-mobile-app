import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/helper_classes/date_helper.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/entities/rating_entity.dart';

class RatingItemWidget extends StatelessWidget {
  final RatingEntity rating;

  const RatingItemWidget({super.key, required this.rating});

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
                child: Column(
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
