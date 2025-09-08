import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mwaeed_mobile_app/app_keys.dart';
import 'package:mwaeed_mobile_app/constants.dart';
import 'package:mwaeed_mobile_app/core/cubits/user_cubit/user_cubit.dart';
import 'package:mwaeed_mobile_app/core/helper_functions/on_generate_routes.dart';
import 'package:mwaeed_mobile_app/core/services/custom_bloc_observer.dart';
import 'package:mwaeed_mobile_app/core/services/get_it_service.dart';
import 'package:mwaeed_mobile_app/core/services/notification_service.dart';
import 'package:mwaeed_mobile_app/core/services/shared_preference_singletone.dart';
import 'package:mwaeed_mobile_app/core/utils/app_colors.dart';
import 'package:mwaeed_mobile_app/core/widgets/main_layout_view.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/entities/user_entity.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/repos/notification_repo.dart';
import 'package:mwaeed_mobile_app/features/notification/presentation/cubits/fetch_notification_cubit/fetch_notification_cubit.dart';
import 'package:mwaeed_mobile_app/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/repos/profile_repo.dart';
import 'package:mwaeed_mobile_app/features/profile/presentation/cubits/profile_cubit/profile_cubit.dart';
import 'package:mwaeed_mobile_app/features/rating/domain/repos/rating_repo.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/cubits/add_rating_cubit/add_rating_cubit.dart';
import 'package:mwaeed_mobile_app/features/rating/presentation/cubits/edit_rating_cubit/edit_rating_cubit.dart';
import 'package:mwaeed_mobile_app/firebase_options.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Prefs.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(
    NotificationService.firebaseMessaginhBackgroundHandler,
  );

  Stripe.publishableKey = AppKeys.stripeKey;
  await NotificationService.initializeNotification();
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
          return MultiBlocProvider(
            providers: [
              BlocProvider(create: (context) => UserCubit()),
              BlocProvider(
                create: (context) => ProfileCubit(getIt.get<ProfileRepo>()),
              ),
              BlocProvider(
                create: (context) =>
                    FetchNotificationCubit(getIt.get<NotificationRepo>()),
              ),
              BlocProvider(
                create: (context) => AddRatingCubit(getIt.get<RatingRepo>()),
              ),
              BlocProvider(
                create: (context) => EditRatingCubit(getIt.get<RatingRepo>()),
              ),
            ],
            child: MwaeedMobileApp(),
          );
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
      initialRoute: checkIfLoggedIn(context)
          ? MainLayoutView.routeName
          : OnboardingView.routeName,
    );
  }
}

bool checkIfLoggedIn(BuildContext context) {
  if (Prefs.getString(userKey).isNotEmpty) {
    UserEntity userEntity = UserEntity.fromJson(
      jsonDecode(Prefs.getString(userKey)),
    );
    context.read<UserCubit>().setUser(userEntity);
    return true;
  } else {
    return false;
  }
}
