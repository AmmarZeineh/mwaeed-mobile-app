import 'package:flutter/material.dart';
import 'package:mwaeed_mobile_app/core/widgets/custom_nav_bar.dart';
import 'package:mwaeed_mobile_app/features/favorite/presentation/views/favorite_view.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/home_view.dart';
import 'package:mwaeed_mobile_app/features/payment/presentation/views/appointments_view.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/views/profile_view.dart';

class MainLayoutView extends StatefulWidget {
  const MainLayoutView({super.key});
  static const routeName = 'main-layout';

  @override
  State<MainLayoutView> createState() => _MainLayoutViewState();
}

class _MainLayoutViewState extends State<MainLayoutView> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeView(),
    const AppointmentsView(),
    const FavoriteView(),
    const ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: CustomBottomNavBarWithBadge(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
