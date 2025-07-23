import 'package:get_it/get_it.dart';
import 'package:mwaeed_mobile_app/core/services/api.dart';
import 'package:mwaeed_mobile_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:mwaeed_mobile_app/features/auth/domain/repos/auth_repo.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Core Services
  getIt.registerSingleton<Api>(Api());
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(getIt.get<Api>()));
}
