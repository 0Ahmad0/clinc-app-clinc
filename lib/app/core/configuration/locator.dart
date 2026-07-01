import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

import '../../../modules/auth/data/remote/auth_remote_data_source.dart';
import '../../../modules/auth/data/data_sources/clinic_login_data_source.dart';
import '../../../modules/auth/data/mock/clinic_login_mock_data_source.dart';
import '../../../modules/auth/data/data_sources/clinic_auth_data_source.dart';
import '../../../modules/auth/data/mock/clinic_auth_mock_data_source.dart';
import '../../../modules/auth/domain/repositories/clinic_auth_repository.dart';
import '../../../modules/auth/domain/repositories/clinic_login_repository.dart';
import '../../../modules/auth/domain/repositories/auth_repository.dart';
import '../../../modules/add_doctor/data/add_doctor_data_source.dart';
import '../../../modules/add_doctor/data/add_doctor_mock_data_source.dart';
import '../../../modules/add_doctor/domain/add_doctor_repository.dart';
import '../../../modules/appointments/data/appointments_data_source.dart';
import '../../../modules/appointments/data/appointments_mock_data_source.dart';
import '../../../modules/appointments/domain/appointments_repository.dart';
import '../../../modules/complete_profile/data/complete_profile_data_source.dart';
import '../../../modules/complete_profile/data/complete_profile_mock_data_source.dart';
import '../../../modules/complete_profile/domain/complete_profile_repository.dart';
import '../../../modules/dashboard/data/dashboard_data_source.dart';
import '../../../modules/dashboard/data/dashboard_mock_data_source.dart';
import '../../../modules/dashboard/domain/dashboard_repository.dart';
import '../../../modules/doctors/data/doctors_data_source.dart';
import '../../../modules/doctors/data/doctors_mock_data_source.dart';
import '../../../modules/doctors/domain/doctors_repository.dart';
import '../../../modules/notifications/data/notifications_data_source.dart';
import '../../../modules/notifications/data/notifications_mock_data_source.dart';
import '../../../modules/notifications/domain/notifications_repository.dart';
import '../../../modules/pending_approval/data/pending_approval_data_source.dart';
import '../../../modules/pending_approval/data/pending_approval_mock_data_source.dart';
import '../../../modules/pending_approval/domain/pending_approval_repository.dart';
import '../../../modules/reports/data/reports_data_source.dart';
import '../../../modules/reports/data/reports_mock_data_source.dart';
import '../../../modules/reports/domain/reports_repository.dart';
import '../../../modules/services/data/services_data_source.dart';
import '../../../modules/services/data/services_mock_data_source.dart';
import '../../../modules/services/domain/services_repository.dart';
import '../../../modules/settings/data/settings_data_source.dart';
import '../../../modules/settings/data/settings_mock_data_source.dart';
import '../../../modules/settings/domain/settings_repository.dart';
import '../../domain/services/api_service.dart';
import '../../domain/services/api_services_imp.dart';

final GetIt locator = GetIt.instance;

void setupLocator() {
  // Core Services
  locator.registerLazySingleton<Dio>(() => Dio());
  locator.registerLazySingleton<ApiServices>(() => ApiServicesImp(locator()));
  locator.registerLazySingleton<SettingsDataSource>(SettingsMockDataSource.new);
  locator.registerLazySingleton<SettingsRepository>(
    () => SettingsRepository(locator()),
  );
  locator.registerLazySingleton<AddDoctorDataSource>(
    AddDoctorMockDataSource.new,
  );
  locator.registerLazySingleton<AddDoctorRepository>(
    () => AddDoctorRepository(locator()),
  );
  locator.registerLazySingleton<AppointmentsDataSource>(
    AppointmentsMockDataSource.new,
  );
  locator.registerLazySingleton<AppointmentsRepository>(
    () => AppointmentsRepository(locator()),
  );
  locator.registerLazySingleton<ClinicLoginDataSource>(
    ClinicLoginMockDataSource.new,
  );
  locator.registerLazySingleton<ClinicLoginRepository>(
    () => ClinicLoginRepository(locator()),
  );
  locator.registerLazySingleton<ClinicAuthDataSource>(
    ClinicAuthMockDataSource.new,
  );
  locator.registerLazySingleton<ClinicAuthRepository>(
    () => ClinicAuthRepository(locator()),
  );
  locator.registerLazySingleton<CompleteProfileDataSource>(
    CompleteProfileMockDataSource.new,
  );
  locator.registerLazySingleton<CompleteProfileRepository>(
    () => CompleteProfileRepository(locator()),
  );
  locator.registerLazySingleton<DashboardDataSource>(
    DashboardMockDataSource.new,
  );
  locator.registerLazySingleton<DashboardRepository>(
    () => DashboardRepository(locator()),
  );
  locator.registerLazySingleton<DoctorsDataSource>(DoctorsMockDataSource.new);
  locator.registerLazySingleton<DoctorsRepository>(
    () => DoctorsRepository(locator()),
  );
  locator.registerLazySingleton<NotificationsDataSource>(
    NotificationsMockDataSource.new,
  );
  locator.registerLazySingleton<NotificationsRepository>(
    () => NotificationsRepository(locator()),
  );
  locator.registerLazySingleton<PendingApprovalDataSource>(
    PendingApprovalMockDataSource.new,
  );
  locator.registerLazySingleton<PendingApprovalRepository>(
    () => PendingApprovalRepository(locator()),
  );
  locator.registerLazySingleton<ReportsDataSource>(ReportsMockDataSource.new);
  locator.registerLazySingleton<ReportsRepository>(
    () => ReportsRepository(locator()),
  );
  locator.registerLazySingleton<ServicesDataSource>(ServicesMockDataSource.new);
  locator.registerLazySingleton<ServicesRepository>(
    () => ServicesRepository(locator()),
  );
  // Auth & User Modules
  locator.registerLazySingleton<AuthRepository>(
    () => AuthRepository(AuthRemoteDataSource(locator())),
  );
}
