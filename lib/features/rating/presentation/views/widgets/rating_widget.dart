import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/entities/rating_entity.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/views/widgets/rating_item_widget.dart';

class ProductReviewsWidget extends StatefulWidget {
  final List<RatingEntity> ratings;

  const ProductReviewsWidget({super.key, required this.ratings});

  @override
  State<ProductReviewsWidget> createState() => _ProductReviewsWidgetState();
}

class _ProductReviewsWidgetState extends State<ProductReviewsWidget>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      if (_isExpanded) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // زر عرض التقييمات
        GestureDetector(
          onTap: _toggleExpansion,
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.grey.shade300),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Expanded(
                  child: Row(
                    children: [
                      AnimatedRotation(
                        turns: _isExpanded ? 0.5 : 0,
                        duration: Duration(milliseconds: 300),
                        child: Icon(
                          Icons.keyboard_arrow_down,
                          color: Colors.blue.shade700,
                        ),
                      ),
                      Spacer(),
                      Icon(Icons.star, color: Colors.amber, size: 20),
                      SizedBox(width: 8),
                      Text(
                        _isExpanded
                            ? 'إخفاء التقييمات'
                            : 'عرض التقييمات (${widget.ratings.length})',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.blue.shade700,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),

        // قائمة التقييمات
        SizeTransition(
          sizeFactor: _animation,
          child: Column(
            children: [
              SizedBox(height: 16),
              if (widget.ratings.isEmpty)
                Container(
                  padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.rate_review_outlined,
                          size: 48,
                          color: Colors.grey.shade400,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'لا توجد تقييمات حتى الآن',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ListView.separated(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: widget.ratings.length,
                  separatorBuilder: (context, index) =>
                      Divider(color: Colors.grey.shade300, thickness: 1),
                  itemBuilder: (context, index) {
                    final rating = widget.ratings[index];
                    return RatingItemWidget(rating: rating);
                  },
                ),
            ],
          ),
        ),
      ],
    );
  }
}
