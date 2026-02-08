import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/enums/search_type.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/utils/app_font_styles.dart';

class CustomSegmentButtons extends StatefulWidget {
  const CustomSegmentButtons({super.key, required this.onChanged});
  final ValueChanged<SearchType> onChanged;
  @override
  State<CustomSegmentButtons> createState() => _CustomSegmentButtonsState();
}

class _CustomSegmentButtonsState extends State<CustomSegmentButtons> {
  SearchType _selectedType = SearchType.provider;
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        segmentedButtonTheme: SegmentedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.primaryColor;
              }
              return const Color(0xfff3f4f6);
            }),
            foregroundColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.secondaryColor;
              }
              return Colors.black87;
            }),
            iconColor: WidgetStateProperty.resolveWith((states) {
              if (states.contains(WidgetState.selected)) {
                return AppColors.secondaryColor;
              }
              return Colors.grey.shade700;
            }),
            side: WidgetStateProperty.all(
              BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.15)),
            ),
            shape: WidgetStateProperty.all(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            textStyle: WidgetStateProperty.all(AppTextStyles.w600_14),
            padding: WidgetStateProperty.all(
              const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
          ),
        ),
      ),
      child: SegmentedButton<SearchType>(
        segments: [
          ButtonSegment(
            value: SearchType.provider,
            label: Text('common.provider'.tr()),
            icon: const Icon(Icons.person_search),
          ),
          ButtonSegment(
            value: SearchType.job,
            label: Text('common.job'.tr()),
            icon: const Icon(Icons.work_outline),
          ),
          ButtonSegment(
            value: SearchType.service,
            label: Text('common.service'.tr()),
            icon: const Icon(Icons.design_services_outlined),
          ),
        ],
        selected: {_selectedType},
        onSelectionChanged: (newSelection) {
          if (newSelection.isNotEmpty) {
            setState(() {
              _selectedType = newSelection.first;
              widget.onChanged(_selectedType);
            });
          }
        },
        multiSelectionEnabled: false,
        emptySelectionAllowed: false,
      ),
    );
  }
}
