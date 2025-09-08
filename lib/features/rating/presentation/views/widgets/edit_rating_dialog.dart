import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/snack_bars.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';
import 'package:mwaeed_mobile_app/features/home/domain/entities/provider_entity.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/cubits/cubit/delete_rating_cubit.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/cubits/edit_rating_cubit/edit_rating_cubit.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/cubits/fetch_user_rating_cubit/fetch_user_rating_cubit.dart';

// Import your existing styles and colors

class EditRatingDialog extends StatefulWidget {
  final ProviderEntity providerEntitiy;
  final String? providerImage;
  final int currentRating;
  final String currentComment;
  final Function(int rating, String comment) onUpdate;
  final VoidCallback onDelete;

  const EditRatingDialog({
    super.key,
    required this.providerEntitiy,
    this.providerImage,
    required this.currentRating,
    required this.currentComment,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  State<EditRatingDialog> createState() => _EditRatingDialogState();
}

class _EditRatingDialogState extends State<EditRatingDialog> {
  late int _rating;
  late TextEditingController _commentController;

  @override
  void initState() {
    super.initState();
    _rating = widget.currentRating;
    _commentController = TextEditingController(text: widget.currentComment);
  }

  @override
  void dispose() {
    _commentController.dispose();
    super.dispose();
  }

  void _showDeleteConfirmation() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16.r),
          ),
          title: Text('Delete Rating', style: AppTextStyles.w600_18),
          content: Text(
            'Are you sure you want to delete your rating? This action cannot be undone.',
            style: AppTextStyles.w400_14.copyWith(color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cancel',
                style: AppTextStyles.w500_14.copyWith(color: Colors.grey),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close confirmation dialog
                Navigator.of(context).pop(); // Close edit dialog
                widget.onDelete();
              },
              child: Text(
                'Delete',
                style: AppTextStyles.w500_14.copyWith(color: Colors.red),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.r)),
      child: BlocConsumer<DeleteRatingCubit, DeleteRatingState>(
        listener: (context, state) {
          if (state is DeleteRatingSuccess) {
            context
                .read<FetchUserRatingCubit>()
                .getUserRatingForSpicificProvider(
                  providerId: widget.providerEntitiy.id,
                  context: context,
                );
            showSuccessMessage('Rating Deleted Successfully', context);
          } else if (state is DeleteRatingFailure) {
            showErrorMessage(state.errMessage, context);
          }
        },
        builder: (context, state) {
          if (state is DeleteRatingLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return BlocConsumer<EditRatingCubit, EditRatingState>(
            listener: (context, state) {
              if (state is EditRatingSuccess) {
                context
                    .read<FetchUserRatingCubit>()
                    .getUserRatingForSpicificProvider(
                      providerId: widget.providerEntitiy.id,
                      context: context,
                    );
                showSuccessMessage('Rating Edited Successfully', context);
              } else if (state is EditRatingFailure) {
                showErrorMessage(state.errMessage, context);
              }
            },
            builder: (context, state) {
              if (state is EditRatingLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              return SingleChildScrollView(
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
                          Text('Edit Rating', style: AppTextStyles.w600_20),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Delete Button
                              IconButton(
                                onPressed: _showDeleteConfirmation,
                                icon: Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                  size: 24.sp,
                                ),
                                tooltip: 'Delete Rating',
                              ),
                              // Close Button
                              IconButton(
                                onPressed: () => Navigator.of(context).pop(),
                                icon: Icon(
                                  Icons.close,
                                  color: Colors.grey,
                                  size: 24.sp,
                                ),
                              ),
                            ],
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
                                ? Icon(
                                    Icons.person,
                                    size: 40.sp,
                                    color: Colors.grey,
                                  )
                                : null,
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            widget.providerEntitiy.name,
                            style: AppTextStyles.w600_18,
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            'Update your experience with this provider',
                            style: AppTextStyles.w400_14.copyWith(
                              color: Colors.grey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),

                      SizedBox(height: 30.h),

                      // Current Rating Display
                      Container(
                        padding: EdgeInsets.all(12.w),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Current Rating',
                              style: AppTextStyles.w500_12.copyWith(
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 5.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < widget.currentRating
                                      ? Icons.star
                                      : Icons.star_border,
                                  size: 20.sp,
                                  color: index < widget.currentRating
                                      ? Colors.amber
                                      : Colors.grey,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.h),

                      // New Rating Stars
                      Text('New Rating', style: AppTextStyles.w500_14),
                      SizedBox(height: 10.h),
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
                                index < _rating
                                    ? Icons.star
                                    : Icons.star_border,
                                size: 40.sp,
                                color: index < _rating
                                    ? Colors.amber
                                    : Colors.grey,
                              ),
                            ),
                          );
                        }),
                      ),

                      SizedBox(height: 10.h),

                      // Rating Text
                      Text(
                        _getRatingText(_rating),
                        style: AppTextStyles.w500_16,
                      ),

                      SizedBox(height: 25.h),

                      // Comment TextField
                      TextField(
                        controller: _commentController,
                        maxLines: 4,
                        decoration: InputDecoration(
                          hintText: 'Update your comment (optional)',
                          hintStyle: AppTextStyles.w400_14.copyWith(
                            color: Colors.grey,
                          ),
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
                                  ? () async {
                                      await widget.onUpdate(
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
                                'Update Rating',
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
              );
            },
          );
        },
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
