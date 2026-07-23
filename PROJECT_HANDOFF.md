# Clinic App Project Handoff

## Project Scope
- Current project: redesigned Clinic Flutter app.
- Current goal: connect the redesigned Clinic app UI to the existing Laravel backend while preserving the current UI design.
- User App is already completed.
- Admin dashboard is already completed.
- Do not apply User App integration assumptions to this project unless explicitly requested.

## Documentation Rules
- Treat `BACKEND_NOTES.md` in this project as the local API contract reference for Clinic Flutter integration.
- The original backend documentation may be inspected when needed, but do not edit files under `/Users/mac/VS Code/clinic-back` from this Flutter project.
- If local documentation conflicts with current backend code, current backend code is the source of truth.
- Never invent endpoints, request fields, response models, auth/token behavior, upload contracts, or pagination metadata.
- If a required endpoint or response contract is missing or inconsistent, stop implementation and generate a Backend API Prompt only.

## Token Usage Rule
- Use the minimum possible tokens in every response.
- Do not repeat architecture, rules, or completed context already documented here.
- Do not explain obvious steps.
- Do not restate the task.
- Return only:
  - audit findings
  - missing backend prompt
  - implementation result
  - blockers
  - validation result
- Prefer short bullets.
- Avoid long summaries.
- When a feature name is provided, start directly.
- Read `PROJECT_HANDOFF.md` and `BACKEND_NOTES.md` silently before acting.
- Do not ask for information already available in the project or documentation.

## Current Flutter Implementation Status
- Redesigned Clinic UI screens exist for auth, home, doctors, appointments, notifications, services, reports, and settings.
- Existing feature Cubits: `AuthCubit`, `DoctorsCubit`, `AddDoctorCubit`, `AppointmentsCubit`, `NotificationsCubit`, `ServicesCubit`, `ReportsCubit`, and `SettingsCubit`.
- Current Cubits manage presentation/local state only and do not call repositories.
- Current feature states use Equatable; backend-integrated feature states must be converted to Freezed.
- Current Clinic feature data layer is missing: no Clinic feature repositories or remote data sources exist yet.
- Current connected API in Flutter is only app settings (`GET /api/app/settings`) through the shared app settings data source.
- Clinic feature URL constants may exist in `AppUrl`, but constants are not backend contracts.
- Most Clinic screens currently use static/mock/local catalog data.

## Current Backend Availability
- Current documented/verified Clinic backend APIs:
  - `POST /api/clinic/register`
  - `POST /api/clinic/login`
  - `GET /api/clinic/me`
  - `POST /api/clinic/logout`
  - `POST /api/clinic/forgot-password`
  - `POST /api/clinic/verify-otp`
  - `POST /api/clinic/resend-otp`
  - `POST /api/clinic/reset-password`
  - `GET /api/clinic/dashboard`
  - `GET /api/clinic/doctors`
  - `GET /api/clinic/doctors/{doctor}`
  - `POST /api/clinic/doctors`
  - `PUT /api/clinic/doctors/{doctor}`
  - `PATCH /api/clinic/doctors/{doctor}/availability`
  - `GET /api/clinic/specializations`
  - `GET /api/clinic/appointments`
  - `GET /api/clinic/appointments/{appointment}`
  - `POST /api/clinic/appointments/{appointment}/accept`
  - `POST /api/clinic/appointments/{appointment}/reject`
  - `POST /api/clinic/appointments/{appointment}/finish`
  - `POST /api/clinic/appointments/{appointment}/result`
  - `GET /api/clinic/reports/summary`
  - `POST /api/clinic/reports/export`
  - `GET /api/clinic/reports/generated`
  - `GET /api/clinic/reports/generated/{report}/download`
  - `GET /api/clinic/profile`
  - `PUT /api/clinic/profile`
  - `POST /api/clinic/change-password`
  - `GET /api/clinic/notification-settings`
  - `PUT /api/clinic/notification-settings`
- Clinic register request fields: `name`, `license_number`, `email`, `password`, `type`.
- Clinic register `type` values: `clinic`, `lab`, `both`.
- Clinic login request fields: `email`, `password`, optional `device_name`; the backend accepts email or license number through the `email` field.
- Clinic login response returns `clinic`, `token`, `token_type`, `expires_at`, `needs_completion`, and `missing_fields`.
- Clinic forgot password request field: `email`.
- Clinic verify/resend OTP request fields: `identifier`, `purpose`, and `otp` for verify only.
- Clinic reset password request fields: `reset_token`, `password`, `password_confirmation`.
- Clinic dashboard request query fields: optional `date`.
- Clinic protected endpoints use the `clinic.auth` middleware.
- Clinic dashboard response returns clinic info, stats, nearest 5 appointments, and unread notifications count.
- Missing operational APIs: notifications list/actions and services.

## Clean Architecture Rules
- Required flow for all backend-integrated Clinic features:
  - Cubit
  - Repository
  - RemoteDataSource
  - ApiServices
- Cubits must depend on repositories only.
- Cubits must never call RemoteDataSource or ApiServices directly.
- RemoteDataSource must only communicate with ApiServices and return BaseModel.
- Repository must wrap exceptions and return ApiResponse.
- Use GetIt constructor injection.

## Data/Response Rules
- List responses:
  - `BaseModel<BaseModels<T>>`
- Single object responses:
  - `BaseModel<T>`
- Repository success:
  - `ApiResponse.success(response)`
- Repository failure:
  - `ApiResponse.failure(NetworkExceptions.getException(error))`

## Dependency Injection Rules
- Before feature integration, register required dependencies through GetIt.
- Required registrations:
  - Dio
  - ApiServices
  - RemoteDataSources
  - Repositories
  - Cubits
- Use constructor injection, for example:

```dart
locator.registerLazySingleton<FeatureRepository>(
  () => FeatureRepository(
    FeatureRemoteDataSource(locator()),
  ),
);

locator.registerFactory<FeatureCubit>(
  () => FeatureCubit(
    locator<FeatureRepository>(),
  ),
);
```

## State Rules
- Backend-integrated feature states must use Freezed.
- Generate `*.freezed.dart` files with build_runner.
- Use `NetworkExceptions` in failure states.
- Do not use Equatable for newly backend-integrated feature states.

## Pagination Rules
- Use existing `lib/core/data/pagination/pagination_state.dart`.
- Pagination logic belongs inside Cubit only.
- Paginated Cubits own:
  - `PaginationState<T>`
  - repository
  - filters
  - search query
  - debounce timer
  - refresh/load-more logic
  - loading/error states
- Required methods:
  - `loadInitial()`
  - `refresh()`
  - `loadMore()`
- Search must be debounced, using 450ms for search fields unless a feature explicitly requires otherwise.
- Filter/search changes reset pagination and load page 1.
- Widgets must not calculate pages, append lists manually, call repositories, or handle API exceptions.
- Use `PaginationState.setPage()` to replace page 1 data and append later pages.

## Features Requiring Pagination
- Doctors: doctors list, search, specialty filter.
- Appointments: appointments list and status filtering.
- Notifications: notification list and read/unread filtering.
- Reports: generated reports list and period/type filtering.
- Services: lab tests/services lists and section/specialty filtering.

## UI Rules
- Keep the current UI design unchanged.
- Replace mock/static data only with Cubit-driven backend data.
- Use BlocProvider, BlocBuilder, BlocSelector, and BlocListener where appropriate.

## Feature Integration Workflow Rules
- Treat this workflow as the fixed process for every Clinic app feature.
- When the user says `ابدأ Auth`, `ابدأ Doctors`, or starts any other Clinic feature, apply these rules directly without asking for the rules again.
- Before implementing any feature, read this file, `BACKEND_NOTES.md`, current backend code, and the previously provided database structure when needed.
- Audit the current Flutter feature first:
  - existing screens
  - existing Cubit/state
  - required models
  - existing static/mock data
  - existing and missing APIs
- Compare required data/actions with `BACKEND_NOTES.md` and current backend code.
- Do not reuse User APIs for Clinic APIs unless explicitly documented as Clinic-compatible.
- If all required APIs exist, implement Flutter integration completely using the mandatory architecture and keep UI unchanged.
- If any required API is missing, do not implement fake Flutter integration for that missing part.
- For missing APIs, return a `BACKEND API PROMPT` and stop.
- The `BACKEND API PROMPT` must include:
  - feature name
  - routes and HTTP methods
  - controllers
  - request validation fields
  - resources/transformers
  - models and relations
  - database tables involved
  - missing migrations if any
  - permissions/authorization rules
  - response JSON expected by Flutter
  - pagination response for list endpoints
  - filters/search requirements
  - notes about the existing Laravel style
- After completing any implemented feature, update this file inside the Flutter project with:
  - what was completed
  - files modified
  - APIs used
  - APIs still missing
  - next step
- Never modify `/Users/mac/VS Code/clinic-back/PROJECT_HANDOFF.md` or other backend documentation files from this Flutter project unless explicitly requested.

## Completed: Clinic Auth Integration
- Date: 2026-07-22.
- Implemented Flutter Auth integration for the available Clinic Auth APIs only.
- Added Auth data models for clinic, login/profile payload, logout, OTP status, OTP verification, and password reset.
- Added `ClinicAuthRemoteDataSource` and `ClinicAuthRepository`.
- Registered Dio, ApiServices, Auth remote data source, Auth repository, and AuthCubit in GetIt.
- Converted Auth state to Freezed and generated `auth_state.freezed.dart`.
- Connected login, register, forgot-password, me, logout, verify OTP, resend OTP, and reset password through `AuthCubit`.
- Login stores the returned clinic token through `StorageService.setAccessToken`, caches clinic data, clears guest mode, and stores profile-completion state.
- Register caches the returned clinic and moves the UI to the pending layer.
- Pending, rejected, inactive, validation, and auth errors are surfaced through `NetworkExceptions` from repository failures.
- Auth UI design was preserved; login/register/forgot fields now submit through Cubit.
- Clinic guest login remains disabled because there is no documented Clinic guest endpoint.

## Auth Files Modified/Added
- `lib/features/auth/data/clinic_auth_remote_data_source.dart`
- `lib/features/auth/data/models/clinic_model.dart`
- `lib/features/auth/data/models/clinic_login_model.dart`
- `lib/features/auth/data/models/clinic_logout_model.dart`
- `lib/features/auth/data/models/clinic_otp_status_model.dart`
- `lib/features/auth/data/models/clinic_otp_verification_model.dart`
- `lib/features/auth/data/models/clinic_password_reset_model.dart`
- `lib/features/auth/domain/clinic_auth_repository.dart`
- `lib/features/auth/presentation/cubit/auth_cubit.dart`
- `lib/features/auth/presentation/cubit/auth_state.dart`
- `lib/features/auth/presentation/pages/auth_view.dart`
- `lib/features/auth/presentation/widgets/login_layer.dart`
- `lib/features/auth/presentation/widgets/signup_layer.dart`
- `lib/features/auth/presentation/widgets/forgot_layer.dart`
- `lib/core/di/service_locator.dart`
- `lib/core/utils/app_url.dart`
- `pubspec.yaml`
- `pubspec.lock`
- `BACKEND_NOTES.md`
- `PROJECT_HANDOFF.md`

## Completed: Clinic Home Integration
- Date: 2026-07-23.
- Integrated `GET /api/clinic/dashboard`.
- Added Home dashboard models, remote data source, repository, Cubit, and Freezed state.
- Registered Home dependencies in GetIt.
- Home loads dashboard on page open and supports pull-to-refresh.
- Home UI remains same; static values are fallback until API data arrives.
- Files added/modified:
  - `lib/features/home/data/clinic_dashboard_remote_data_source.dart`
  - `lib/features/home/data/models/clinic_dashboard_model.dart`
  - `lib/features/home/domain/clinic_dashboard_repository.dart`
  - `lib/features/home/presentation/cubit/home_cubit.dart`
  - `lib/features/home/presentation/cubit/home_state.dart`
  - `lib/features/home/presentation/pages/home_page.dart`
  - `lib/features/home/presentation/pages/home_view.dart`
  - `lib/features/home/presentation/widgets/home_top_section.dart`
  - `lib/features/home/presentation/widgets/home_stats_section.dart`
  - `lib/features/home/presentation/widgets/home_appointments_section.dart`
  - `lib/core/di/service_locator.dart`
  - `BACKEND_NOTES.md`
  - `PROJECT_HANDOFF.md`

## Completed: Clinic Doctors Integration
- Date: 2026-07-23.
- Integrated doctors list/search/filter/pagination, specializations, and availability.
- Added doctors models, remote data source, repository, Cubit pagination, and Freezed state.
- Registered Doctors dependencies in GetIt.
- Files added/modified:
  - `lib/features/doctors/data/clinic_doctors_remote_data_source.dart`
  - `lib/features/doctors/data/models/clinic_doctor_model.dart`
  - `lib/features/doctors/data/models/clinic_specialization_model.dart`
  - `lib/features/doctors/domain/clinic_doctors_repository.dart`
  - `lib/features/doctors/presentation/cubit/doctors_cubit.dart`
  - `lib/features/doctors/presentation/cubit/doctors_state.dart`
  - `lib/features/doctors/presentation/pages/doctors_page.dart`
  - `lib/features/doctors/presentation/pages/doctors_view.dart`
  - `lib/features/doctors/presentation/widgets/doctors_list.dart`
  - `lib/features/doctors/presentation/widgets/doctor_card.dart`
  - `lib/features/doctors/presentation/widgets/doctors_filter_chips.dart`
  - `lib/features/doctors/presentation/widgets/doctors_header.dart`
  - `lib/core/di/service_locator.dart`
  - `lib/core/domain/services/api_service.dart`
  - `lib/core/domain/services/api_services_imp.dart`
  - `lib/core/utils/app_url.dart`
  - `BACKEND_NOTES.md`
  - `PROJECT_HANDOFF.md`

## Completed: Clinic Appointments Integration
- Date: 2026-07-23.
- Integrated appointments list/detail/pagination/filter by status and actions.
- Added appointments models, remote data source, repository, Cubit pagination, and Freezed state.
- Registered Appointments dependencies in GetIt.
- Files added/modified:
  - `lib/features/appointments/data/clinic_appointments_remote_data_source.dart`
  - `lib/features/appointments/data/models/clinic_appointment_model.dart`
  - `lib/features/appointments/domain/clinic_appointments_repository.dart`
  - `lib/features/appointments/presentation/cubit/appointments_cubit.dart`
  - `lib/features/appointments/presentation/cubit/appointments_state.dart`
  - `lib/features/appointments/presentation/pages/appointments_page.dart`
  - `lib/features/appointments/presentation/pages/appointments_view.dart`
  - `lib/features/appointments/presentation/pages/appointments_list_view.dart`
  - `lib/features/appointments/presentation/pages/appointment_detail_view.dart`
  - `lib/features/appointments/presentation/widgets/appointment_card.dart`
  - `lib/features/appointments/presentation/widgets/appointment_actions.dart`
  - `lib/features/appointments/presentation/widgets/appointment_detail_header.dart`
  - `lib/features/appointments/presentation/widgets/appointments_header.dart`
  - `lib/features/appointments/presentation/widgets/appointments_tabs.dart`
  - `lib/core/di/service_locator.dart`
  - `lib/core/utils/app_url.dart`
  - `BACKEND_NOTES.md`
  - `PROJECT_HANDOFF.md`

## Completed: Clinic Reports Integration
- Date: 2026-07-23.
- Integrated reports summary, export, generated list, and pagination.
- Added reports models, remote data source, repository, Cubit pagination, and Freezed state.
- Registered Reports dependencies in GetIt.
- Files added/modified:
  - `lib/features/reports/data/clinic_reports_remote_data_source.dart`
  - `lib/features/reports/data/models/clinic_report_model.dart`
  - `lib/features/reports/domain/clinic_reports_repository.dart`
  - `lib/features/reports/domain/report_period.dart`
  - `lib/features/reports/domain/report_type.dart`
  - `lib/features/reports/presentation/cubit/reports_cubit.dart`
  - `lib/features/reports/presentation/cubit/reports_state.dart`
  - `lib/features/reports/presentation/pages/reports_page.dart`
  - `lib/features/reports/presentation/pages/reports_view.dart`
  - `lib/features/reports/presentation/widgets/reports_export_buttons.dart`
  - `lib/features/reports/presentation/widgets/reports_list.dart`
  - `lib/features/reports/presentation/widgets/report_entry_card.dart`
  - `lib/core/di/service_locator.dart`
  - `lib/core/utils/app_url.dart`
  - `BACKEND_NOTES.md`
  - `PROJECT_HANDOFF.md`

## Completed: Clinic Settings Integration
- Date: 2026-07-23.
- Integrated profile, profile update with optional logo/cover upload, change password, and notification settings.
- Added settings models, remote data source, repository, Cubit integration, and Freezed state.
- Registered Settings dependencies in GetIt.
- Files added/modified:
  - `lib/features/settings/data/clinic_settings_remote_data_source.dart`
  - `lib/features/settings/data/models/clinic_settings_model.dart`
  - `lib/features/settings/domain/clinic_settings_repository.dart`
  - `lib/features/settings/presentation/cubit/settings_cubit.dart`
  - `lib/features/settings/presentation/cubit/settings_state.dart`
  - `lib/features/settings/presentation/pages/settings_page.dart`
  - `lib/features/settings/presentation/pages/settings_main_view.dart`
  - `lib/features/settings/presentation/pages/settings_profile_view.dart`
  - `lib/features/settings/presentation/pages/settings_password_view.dart`
  - `lib/features/settings/presentation/widgets/settings_profile_cover.dart`
  - `lib/features/settings/presentation/widgets/settings_profile_field.dart`
  - `lib/core/di/service_locator.dart`
  - `lib/core/domain/services/api_services_imp.dart`
  - `lib/core/utils/app_url.dart`
  - `BACKEND_NOTES.md`
  - `PROJECT_HANDOFF.md`

## Verification Notes
- `flutter pub get`: passed.
- `dart run build_runner build`: passed.
- `flutter analyze`: passed with no issues.
- `flutter build apk --debug`: passed.
- `git diff --check`: passed.
- `flutter test`: failed in an existing Doctors UI viewport test due RenderFlex overflows in `doctor_card.dart` and `doctors_header.dart`; Auth cubit test passed.

## Important Current Blocker
- Protected Clinic authentication is now available.
- Do not implement Clinic operational feature integration until each required feature endpoint is documented in `BACKEND_NOTES.md` or verified directly in current backend code.
