import 'package:bloc/bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/on_generate_routes.dart';
import 'package:mwaeed_mobile_app/core/services/custom_bloc_observer.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/features/home/presentation/views/home_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Prefs.init();
  setupLocator();
  await ScreenUtil.ensureScreenSize();
  Bloc.observer = CustomBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/langs',
      fallbackLocale: Locale('en'),
      child: ScreenUtilInit(
        designSize: const Size(375, 812),
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, child) {
          return MwaeedMobileApp();
        },
      ),
    ),
  );
}

class MwaeedMobileApp extends StatelessWidget {
  const MwaeedMobileApp({super.key});

  @override
  Widget build(BuildContext context) {
    final isArabic = context.locale.languageCode == 'ar';
    return MaterialApp(
      theme: ThemeData(
        progressIndicatorTheme: ProgressIndicatorThemeData(
          color: AppColors.primaryColor,
        ),
        scaffoldBackgroundColor: Colors.white,
        fontFamily: isArabic ? 'Cairo' : 'Poppins',
      ),
      onGenerateRoute: onGenerateRoutes,
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      initialRoute: HomeView.routeName,
    );
  }
}
