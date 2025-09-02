import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_elevated_button.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/book_appoinment_view.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/about_section.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/custom_app_bar.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/info_circle_item_list_view.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/provider_card.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/review_section.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/working_time_section.dart';

class ProviderDetailsViewBody extends StatelessWidget {
  const ProviderDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(text: "provider_details.provider_details"),
        const ProviderCard(),
        const SizedBox(height: 120, child: InfoCircleItemListView()),

        const AboutMeSection(),

        const SizedBox(height: 15),
        const WorkingTimeSection(),

        const SizedBox(height: 15),
        ReviewsSection(),
        const SizedBox(height: 15),
        SizedBox(
          width: double.infinity,
          child: CustomElevatedButton(
            title: "provider_details.book_appointment".tr(),
            onPressed: () {
              Navigator.pushNamed(context, BookAppointmentView.routeName);
            },
          ),
        ),
      ],
    );
  }
}
