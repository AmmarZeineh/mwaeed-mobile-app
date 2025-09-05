
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/helper_classes/date_helper.dart';

class ReviewItemWidget extends StatelessWidget {
  const ReviewItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "Ahmad Mohsen",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      DateHelper.getFormattedDateArabic("2023-01-01"),
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: 12),
              CircleAvatar(
                radius: 24,
                backgroundColor: Colors.grey.shade200,
                child: Icon(
                  Icons.person,
                  color: Colors.grey.shade600,
                  size: 28,
                ),
              ),
            ],
          ),

          SizedBox(height: 12),

          // التعليق
          if (true)
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: Text(
                "nice doctor",
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
              ...List.generate(5, (index) {
                return Icon(
                  index < 30 ? Icons.star : Icons.star_outline,
                  color: Colors.amber,
                  size: 20,
                );
              }),
              SizedBox(width: 8),
              Text(
                '30/5',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey.shade700,
                ),
              ),
              Spacer(),
              Text(
                ':التقييم',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

