import 'package:get_it/get_it.dart';

import '../media/media_service.dart';

import '../../features/ads/presentation/cubit/create_ad_cubit.dart';
import '../../features/auth/domain/account_type.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/reports/presentation/cubit/reports_cubit.dart';
import '../../features/services/presentation/cubit/services_cubit.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/doctors/presentation/cubit/add_doctor_cubit.dart';
import '../../features/appointments/presentation/cubit/appointments_cubit.dart';
import '../../features/doctors/presentation/cubit/doctors_cubit.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';

/// Global service locator. Register services as `registerLazySingleton` and
/// cubits as `registerFactory` here — never construct them inside widgets.
final GetIt sl = GetIt.instance;

/// Wires up dependencies at startup.
void configureDependencies() {
  sl.registerLazySingleton<MediaService>(MediaService.new);

  sl.registerFactory<OnboardingCubit>(OnboardingCubit.new);
  sl.registerFactory<AuthCubit>(AuthCubit.new);
  sl.registerFactory<DoctorsCubit>(DoctorsCubit.new);
  sl.registerFactory<AddDoctorCubit>(AddDoctorCubit.new);
  sl.registerFactory<NotificationsCubit>(NotificationsCubit.new);
  sl.registerFactory<AppointmentsCubit>(AppointmentsCubit.new);
  sl.registerFactoryParam<ServicesCubit, AccountType, void>(
    (accountType, _) => ServicesCubit(accountType),
  );
  sl.registerFactoryParam<ReportsCubit, AccountType, void>(
    (accountType, _) => ReportsCubit(accountType),
  );
  sl.registerFactory<SettingsCubit>(SettingsCubit.new);
  sl.registerFactory<CreateAdCubit>(CreateAdCubit.new);
}
