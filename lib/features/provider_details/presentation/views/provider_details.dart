import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/features/provider_details/presentation/views/widgets/provider_details_view_body.dart';

class ProviderDetailsView extends StatelessWidget {
  const ProviderDetailsView({super.key});
  static const String routeName = '/providerDetails';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SafeArea(child: ProviderDetailsViewBody()));
  }
}
