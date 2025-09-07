import 'package:get_it/get_it.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/core/services/notification_service.dart';
import 'package:mwaeed_mobile_app/features/booking/data/repos/booking_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/booking/domain/repo/booking_repo.dart';
import 'package:mwaeed_mobile_app/features/home/data/repos/home_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/home/domain/repos/home_repo.dart';
import 'package:mwaeed_mobile_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';
import 'package:mwaeed_mobile_app/features/notification/data/repos/notification_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/notification/domain/repos/notification_repo.dart';
import 'package:mwaeed_mobile_app/features/payment/data/repos/payment_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/payment/domain/repos/payment_repo.dart';
import 'package:mwaeed_mobile_app/features/profile/data/repos/profile_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/profile/domain/repos/profile_repo.dart';
import 'package:mwaeed_mobile_app/features/search/data/repos/search_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/search/domain/repos/search_repo.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Core Services
  getIt.registerSingleton<Api>(Api());
  getIt.registerSingleton<NotificationService>(NotificationService());
  getIt.registerSingleton<HomeRepo>(HomeRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<SearchRepo>(SearchRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<PaymentRepo>(PaymentRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<ProfileRepo>(ProfileRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<BookingRepo>(BookingRepoImpl(getIt.get<Api>()));
  getIt.registerSingleton<NotificationRepo>(
    NotificationRepoImpl(getIt.get<Api>()),
  );
}
