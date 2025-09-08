import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class RatingDialog extends StatefulWidget {
  final String providerName;
  final String? providerImage;
  final Function(int rating, String comment) onSubmit;

  const RatingDialog({
    super.key,
    required this.providerName,
    this.providerImage,
    required this.onSubmit,
  });

  @override
  State<RatingDialog> createState() => _RatingDialogState();
}

class _RatingDialogState extends State<RatingDialog> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20.w),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.r),
            color: AppColors.secondaryColor,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Rate Service', style: AppTextStyles.w600_20),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(Icons.close, color: Colors.grey, size: 24.sp),
                  ),
                ],
              ),

              SizedBox(height: 20.h),

              // Provider Info
              Column(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.grey[200],
                    radius: 40.r,
                    backgroundImage: widget.providerImage != null
                        ? NetworkImage(widget.providerImage!)
                        : null,
                    child: widget.providerImage == null
                        ? Icon(Icons.person, size: 40.sp, color: Colors.grey)
                        : null,
                  ),
                  SizedBox(height: 10.h),
                  Text(widget.providerName, style: AppTextStyles.w600_18),
                  SizedBox(height: 5.h),
                  Text(
                    'How was your experience with this provider?',
                    style: AppTextStyles.w400_14.copyWith(color: Colors.grey),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              // Rating Stars
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _rating = index + 1;
                      });
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 4.w),
                      child: Icon(
                        index < _rating ? Icons.star : Icons.star_border,
                        size: 40.sp,
                        color: index < _rating ? Colors.amber : Colors.grey,
                      ),
                    ),
                  );
                }),
              ),

              SizedBox(height: 10.h),

              // Rating Text
              Text(_getRatingText(_rating), style: AppTextStyles.w500_16),

              SizedBox(height: 25.h),

              // Comment TextField
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: InputDecoration(
                  hintText: 'Write your comment here (optional)',
                  hintStyle: AppTextStyles.w400_14.copyWith(color: Colors.grey),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    borderSide: BorderSide(
                      color: AppColors.primaryColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.all(15.w),
                ),
                style: AppTextStyles.w400_14,
              ),

              SizedBox(height: 25.h),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          side: const BorderSide(color: Colors.grey),
                        ),
                      ),
                      child: Text(
                        'Cancel',
                        style: AppTextStyles.w500_16.copyWith(
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 15.w),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _rating > 0
                          ? () {
                              widget.onSubmit(
                                _rating,
                                _commentController.text.trim(),
                              );
                              Navigator.of(context).pop();
                            }
                          : null,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        padding: EdgeInsets.symmetric(vertical: 15.h),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        disabledBackgroundColor: Colors.grey.shade300,
                      ),
                      child: Text(
                        'Submit Rating',
                        style: AppTextStyles.w500_16.copyWith(
                          color: AppColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  String _getRatingText(int rating) {
    switch (rating) {
      case 1:
        return 'Very Poor';
      case 2:
        return 'Poor';
      case 3:
        return 'Average';
      case 4:
        return 'Good';
      case 5:
        return 'Excellent';
      default:
        return 'Select Rating';
    }
  }
}
