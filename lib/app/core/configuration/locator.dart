import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../modules/auth/data/remote/auth_remote_data_source.dart';
import '../../../modules/auth/domain/repositories/auth_repository.dart';
import '../../domain/services/api_service.dart';
import '../../domain/services/api_services_imp.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Core Services
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ApiServices>(() => ApiServicesImp(locator()));
  // Auth & User Modules
  locator.registerLazySingleton<AuthRepository>(
        () => AuthRepository(AuthRemoteDataSource(locator())),
  );

}
