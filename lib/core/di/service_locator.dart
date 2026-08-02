import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

import '../media/media_service.dart';
import '../services/fcm_token_sync_service.dart';
import '../domain/services/api_service.dart';
import '../domain/services/api_services_imp.dart';

import '../../features/ads/presentation/cubit/create_ad_cubit.dart';
import '../../features/auth/domain/account_type.dart';
import '../../features/auth/data/clinic_auth_remote_data_source.dart';
import '../../features/auth/domain/clinic_auth_repository.dart';
import '../../features/auth/presentation/cubit/auth_cubit.dart';
import '../../features/home/data/clinic_dashboard_remote_data_source.dart';
import '../../features/home/domain/clinic_dashboard_repository.dart';
import '../../features/home/presentation/cubit/home_cubit.dart';
import '../../features/onboarding/presentation/cubit/onboarding_cubit.dart';
import '../../features/reports/data/clinic_reports_remote_data_source.dart';
import '../../features/reports/domain/clinic_reports_repository.dart';
import '../../features/reports/presentation/cubit/reports_cubit.dart';
import '../../features/settings/data/clinic_settings_remote_data_source.dart';
import '../../features/settings/domain/clinic_settings_repository.dart';
import '../../features/services/data/clinic_services_remote_data_source.dart';
import '../../features/services/domain/clinic_services_repository.dart';
import '../../features/services/presentation/cubit/services_cubit.dart';
import '../../features/settings/presentation/cubit/settings_cubit.dart';
import '../../features/doctors/presentation/cubit/add_doctor_cubit.dart';
import '../../features/appointments/data/clinic_appointments_remote_data_source.dart';
import '../../features/appointments/domain/clinic_appointments_repository.dart';
import '../../features/doctors/data/clinic_doctors_remote_data_source.dart';
import '../../features/doctors/data/models/clinic_doctor_model.dart';
import '../../features/doctors/domain/clinic_doctors_repository.dart';
import '../../features/appointments/presentation/cubit/appointments_cubit.dart';
import '../../features/doctors/presentation/cubit/doctors_cubit.dart';
import '../../features/notifications/data/clinic_notifications_remote_data_source.dart';
import '../../features/notifications/domain/clinic_notifications_repository.dart';
import '../../features/notifications/presentation/cubit/notifications_cubit.dart';

/// Global service locator. Register services as `registerLazySingleton` and
/// cubits as `registerFactory` here — never construct them inside widgets.
final GetIt sl = GetIt.instance;

/// Wires up dependencies at startup.
void configureDependencies() {
  sl.registerLazySingleton<MediaService>(MediaService.new);
  sl.registerLazySingleton<Dio>(Dio.new);
  sl.registerLazySingleton<ApiServices>(() => ApiServicesImp(sl()));
  sl.registerLazySingleton<ClinicAuthRemoteDataSource>(
    () => ClinicAuthRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicAuthRepository>(
    () => ClinicAuthRepository(sl()),
  );
  sl.registerLazySingleton<ClinicDashboardRemoteDataSource>(
    () => ClinicDashboardRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicDashboardRepository>(
    () => ClinicDashboardRepository(sl()),
  );
  sl.registerLazySingleton<ClinicDoctorsRemoteDataSource>(
    () => ClinicDoctorsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicDoctorsRepository>(
    () => ClinicDoctorsRepository(sl()),
  );
  sl.registerLazySingleton<ClinicAppointmentsRemoteDataSource>(
    () => ClinicAppointmentsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicAppointmentsRepository>(
    () => ClinicAppointmentsRepository(sl()),
  );
  sl.registerLazySingleton<ClinicNotificationsRemoteDataSource>(
    () => ClinicNotificationsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicNotificationsRepository>(
    () => ClinicNotificationsRepository(sl()),
  );
  sl.registerLazySingleton<FcmTokenSyncService>(
    () => FcmTokenSyncService(sl()),
  );
  sl.registerLazySingleton<ClinicReportsRemoteDataSource>(
    () => ClinicReportsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicReportsRepository>(
    () => ClinicReportsRepository(sl()),
  );
  sl.registerLazySingleton<ClinicSettingsRemoteDataSource>(
    () => ClinicSettingsRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicSettingsRepository>(
    () => ClinicSettingsRepository(sl()),
  );
  sl.registerLazySingleton<ClinicServicesRemoteDataSource>(
    () => ClinicServicesRemoteDataSource(sl()),
  );
  sl.registerLazySingleton<ClinicServicesRepository>(
    () => ClinicServicesRepository(sl()),
  );

  sl.registerFactory<OnboardingCubit>(OnboardingCubit.new);
  sl.registerFactory<AuthCubit>(() => AuthCubit(sl(), sl()));
  sl.registerFactory<HomeCubit>(() => HomeCubit(sl()));
  sl.registerFactory<DoctorsCubit>(() => DoctorsCubit(sl()));
  sl.registerFactoryParam<AddDoctorCubit, ClinicDoctorModel?, void>(
    (doctor, _) => AddDoctorCubit(sl(), initialDoctor: doctor),
  );
  sl.registerFactory<NotificationsCubit>(() => NotificationsCubit(sl()));
  sl.registerFactory<AppointmentsCubit>(() => AppointmentsCubit(sl()));
  sl.registerFactoryParam<ServicesCubit, AccountType, void>(
    (accountType, _) => ServicesCubit(accountType, sl()),
  );
  sl.registerFactoryParam<ReportsCubit, AccountType, void>(
    (accountType, _) => ReportsCubit(accountType, sl()),
  );
  sl.registerFactory<SettingsCubit>(() => SettingsCubit(sl()));
  sl.registerFactory<CreateAdCubit>(CreateAdCubit.new);
}
