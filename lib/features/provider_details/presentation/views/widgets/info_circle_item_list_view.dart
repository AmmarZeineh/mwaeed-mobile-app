
import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/info_circle_item.dart';

class InfoCircleItemListView extends StatelessWidget {
  const InfoCircleItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 4,
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return Padding(
          padding:  EdgeInsets.symmetric(horizontal: 20),
          child: InfoCircleItem(),
        );
      },
    );
  }
}

