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
  - `POST /api/clinic/device-token`
  - `GET /api/clinic/notifications`
  - `POST /api/clinic/notifications/{notification}/read`
  - `POST /api/clinic/notifications/mark-all-read`
  - `GET /api/clinic/notifications/unread-count`
  - `DELETE /api/clinic/notifications/{notification}`
  - `DELETE /api/clinic/notifications`
  - `GET /api/clinic/services/lab-sections`
  - `GET /api/clinic/services/lab-tests`
  - `GET /api/clinic/services/enabled-lab-tests`
  - `POST /api/clinic/services/lab-tests/{labTest}`
  - `PUT /api/clinic/services/lab-tests/{labTest}`
  - `DELETE /api/clinic/services/lab-tests/{labTest}`
  - `GET /api/clinic/services/specializations`
  - `GET /api/clinic/services/enabled-specializations`
  - `POST /api/clinic/services/specializations/{specialization}`
  - `PUT /api/clinic/services/specializations/{specialization}`
  - `DELETE /api/clinic/services/specializations/{specialization}`
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
- Services APIs are now available and integrated in Flutter.

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

## Completed: Clinic Notifications Integration
- Date: 2026-07-24.
- Integrated notifications list/read/mark all/unread count/delete/clear and device token data layer.
- Added notification models, remote data source, repository, Cubit pagination, and Freezed state.
- Registered Notifications dependencies in GetIt.
- Files added/modified:
  - `lib/features/notifications/data/clinic_notifications_remote_data_source.dart`
  - `lib/features/notifications/data/models/clinic_notification_model.dart`
  - `lib/features/notifications/domain/clinic_notifications_repository.dart`
  - `lib/features/notifications/presentation/cubit/notifications_cubit.dart`
  - `lib/features/notifications/presentation/cubit/notifications_state.dart`
  - `lib/features/notifications/presentation/pages/notifications_page.dart`
  - `lib/features/notifications/presentation/pages/notifications_view.dart`
  - `lib/features/notifications/presentation/widgets/notification_card.dart`
  - `lib/features/notifications/presentation/widgets/notification_group.dart`
  - `lib/features/notifications/presentation/widgets/notifications_header.dart`
  - `lib/features/notifications/presentation/widgets/notifications_tabs.dart`
  - `lib/core/di/service_locator.dart`
  - `lib/core/utils/app_url.dart`
  - `BACKEND_NOTES.md`
  - `PROJECT_HANDOFF.md`

## Completed: Clinic Services Integration
- Date: 2026-07-24.
- Integrated lab sections, available/enabled lab tests, available/enabled service specializations, enable/update/remove lab tests, and enable specializations.
- Added services models, remote data source, repository, Cubit pagination/search/debounced price sync, and Freezed state.
- Registered Services dependencies in GetIt.
- Files added/modified:
  - `lib/features/services/data/clinic_services_remote_data_source.dart`
  - `lib/features/services/data/models/clinic_service_model.dart`
  - `lib/features/services/domain/clinic_services_repository.dart`
  - `lib/features/services/presentation/cubit/services_cubit.dart`
  - `lib/features/services/presentation/cubit/services_state.dart`
  - `lib/features/services/presentation/pages/services_page.dart`
  - `lib/features/services/presentation/pages/services_view.dart`
  - `lib/features/services/presentation/services_l10n.dart`
  - `lib/features/services/presentation/widgets/service_test_card.dart`
  - `lib/features/services/presentation/widgets/services_add_sheet.dart`
  - `lib/features/services/presentation/widgets/services_catalog_grid.dart`
  - `lib/features/services/presentation/widgets/services_detail_list.dart`
  - `lib/features/services/presentation/widgets/services_header.dart`
  - `lib/features/services/presentation/widgets/services_tab_switcher.dart`
  - `lib/core/di/service_locator.dart`
  - `lib/core/utils/app_url.dart`
  - `PROJECT_HANDOFF.md`

## Verification Notes
- `flutter pub get`: passed.
- `dart run build_runner build`: passed.
- `flutter analyze`: passed with no issues.
- `flutter build apk --debug`: passed.
- `git diff --check`: passed.
- `flutter test`: passed.

## Completed: Notifications Counters Stability Fix
- Date: 2026-07-24.
- Kept user on profile screen after save and made clinic name updates visible immediately in settings/home.
- Fixed notification tab counters drifting after read/delete/mark-all by separating total/read/unread counters in notifications state and syncing them with tab-specific pagination totals plus unread-count endpoint.
- No backend API contract changes were required.
- Files added/modified:
  - `lib/features/notifications/presentation/cubit/notifications_cubit.dart`
  - `lib/features/notifications/presentation/cubit/notifications_state.dart`
  - `lib/features/notifications/presentation/cubit/notifications_cubit.freezed.dart`
  - `lib/features/notifications/presentation/widgets/notifications_tabs.dart`
  - `lib/features/settings/presentation/cubit/settings_cubit.dart`
  - `lib/features/settings/presentation/widgets/settings_main_header.dart`
  - `lib/features/home/presentation/widgets/home_top_section.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Home Clinic Name Live Refresh Fix
- Date: 2026-07-24.
- Fixed stale clinic name on Home after profile updates by notifying app listeners whenever cached clinic data changes.
- Files added/modified:
  - `lib/core/services/storage_service.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Settings Profile Save Toast
- Date: 2026-07-24.
- Added success toast feedback after profile update completes successfully.
- Files added/modified:
  - `lib/features/settings/presentation/cubit/settings_cubit.dart`
  - `lib/features/settings/presentation/cubit/settings_state.dart`
  - `lib/features/settings/presentation/cubit/settings_cubit.freezed.dart`
  - `lib/features/settings/presentation/pages/settings_page.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Notifications Open Without Full Reload
- Date: 2026-07-24.
- Updated notifications open flow to avoid full list refresh on card tap.
- `open()` now marks notification as read and updates list/counters locally.
- `loadInitial()` remains for first page load and pull-to-refresh.
- Files added/modified:
  - `lib/features/notifications/presentation/cubit/notifications_cubit.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Account Type Routing Fix
- Date: 2026-07-24.
- Services page now derives the real clinic account type (`clinic`/`lab`/`both`) from cached clinic data instead of defaulting to `both`.
- Prevents invalid lab-services calls for clinic-only accounts and keeps services tab/data aligned with backend permissions.
- Files added/modified:
  - `lib/features/services/presentation/pages/services_page.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Tabs Always Visible
- Date: 2026-07-24.
- Kept both services tabs visible (`lab` and `specialty`) for UI consistency.
- Role-restricted tab remains visible but disabled instead of being hidden.
- Files added/modified:
  - `lib/features/services/presentation/widgets/services_tab_switcher.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Tabs Click + Specialty Data Visibility Fix
- Date: 2026-07-24.
- Made both services tabs clickable, including role-restricted flows (backend now returns the explicit permission error which is shown as toast).
- Added services-page failure toast handling to surface backend errors clearly.
- Updated specialties catalog to show enabled specialties when present, otherwise show available specialties list so non-empty API data is visible.
- Files added/modified:
  - `lib/features/services/presentation/cubit/services_cubit.dart`
  - `lib/features/services/presentation/pages/services_view.dart`
  - `lib/features/services/presentation/widgets/services_tab_switcher.dart`
  - `lib/features/services/presentation/widgets/services_catalog_grid.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Custom Dio API Logger
- Date: 2026-07-24.
- Replaced noisy inline Dio logs with a reusable custom interceptor/logger.
- Added structured request/response/error logs with request ID, duration, endpoint, status code, pagination summary, validation errors, and sensitive-data masking.
- Added optional full-response pretty logging toggle through `logFullApiResponse`.
- Disabled duplicate logs by removing existing `LogInterceptor` and old inline interceptor before registering the new one.
- Files added/modified:
  - `lib/core/network/interceptors/api_logger_interceptor.dart`
  - `lib/core/network/utils/api_log_formatter.dart`
  - `lib/core/network/utils/api_log_sanitizer.dart`
  - `lib/core/domain/services/api_services_imp.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Raw Body Logging View
- Date: 2026-07-24.
- API logger now prints request/response/error body as-is in dedicated body sections.
- Files added/modified:
  - `lib/core/network/utils/api_log_formatter.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Important Current Blocker
- No current Services blocker.
- Do not implement any future feature endpoint unless it is documented in `BACKEND_NOTES.md` or verified directly in current backend code.

## Completed: Services Tabs Availability-Hide Restore
- Date: 2026-07-24.
- Restored tab visibility behavior to show only service kinds allowed by account type; unavailable kinds are hidden.
- If only one kind is available, the tab switcher is hidden.
- Files added/modified:
  - `lib/features/services/presentation/widgets/services_tab_switcher.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Reports Card Border Crash Fix
- Date: 2026-07-24.
- Fixed Flutter paint assertion caused by mixing non-uniform border colors with `borderRadius` in reports entry card.
- Replaced directional mixed-color border decoration with a uniform border plus a clipped start accent strip.
- Files added/modified:
  - `lib/features/reports/presentation/widgets/report_entry_card.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Numeric/String Parsing Compatibility Fix
- Date: 2026-07-24.
- Fixed services parsing failures (`Unable to process data`) caused by backend returning numeric identifiers as strings in services payloads.
- Added robust `fromJson` converters for services IDs/prices/boolean flags to support string and numeric forms without crashing.
- Files added/modified:
  - `lib/features/services/data/models/clinic_service_model.dart`
  - `lib/features/services/data/models/clinic_service_model.g.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Lab Sections Add/Remove Flow Restore
- Date: 2026-07-24.
- Restored lab-services UX so the catalog shows only added lab section types.
- Bottom sheet lab section tap now toggles add/remove, and opening an added section still loads tests with enable/disable and pricing.
- Added automatic sync of added lab sections from enabled lab tests returned by backend.
- Files added/modified:
  - `lib/features/services/presentation/cubit/services_cubit.dart`
  - `lib/features/services/presentation/cubit/services_state.dart`
  - `lib/features/services/presentation/cubit/services_cubit.freezed.dart`
  - `lib/features/services/presentation/widgets/services_catalog_grid.dart`
  - `lib/features/services/presentation/widgets/services_add_sheet.dart`
  - `lib/features/services/presentation/pages/services_view.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Reports Date Format + File Open
- Date: 2026-07-24.
- Formatted generated report date display to `yyyy-MM-dd h:mm am/pm`.
- Added report card tap-to-open behavior when `file_url` is present.
- Added `localhost` file URL fallback to current backend host for device access.
- Added `url_launcher` dependency for opening report links externally.
- Files added/modified:
  - `lib/features/reports/data/models/clinic_report_model.dart`
  - `lib/features/reports/presentation/widgets/report_entry_card.dart`
  - `pubspec.yaml`
  - `pubspec.lock`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Clinic Doctor Add/Edit/Details Integration
- Date: 2026-07-25.
- Integrated doctor details through `GET /api/clinic/doctors/{doctor}`.
- Integrated add doctor through `POST /api/clinic/doctors`.
- Integrated edit doctor through `PUT /api/clinic/doctors/{doctor}`.
- Add/edit now submits documented fields including `schedules.*.day/from/to/is_active`.
- Add/edit uses backend specializations from `GET /api/clinic/specializations`.
- Doctor image picker now uses the shared media bottom sheet and sends `image` as multipart when selected.
- Qualification picker now accepts PDF files and sends `qualification_files[]` as multipart when selected.
- Removing a newly selected image/file before save is supported locally.
- Removing already-uploaded server assets is not implemented because no remove-field contract is documented.
- Files added/modified:
  - `lib/features/doctors/data/clinic_doctors_remote_data_source.dart`
  - `lib/features/doctors/domain/clinic_doctors_repository.dart`
  - `lib/features/doctors/domain/doctor_summary.dart`
  - `lib/features/doctors/presentation/cubit/add_doctor_cubit.dart`
  - `lib/features/doctors/presentation/cubit/add_doctor_state.dart`
  - `lib/features/doctors/presentation/cubit/add_doctor_cubit.freezed.dart`
  - `lib/features/doctors/presentation/cubit/doctors_cubit.dart`
  - `lib/features/doctors/presentation/cubit/doctors_state.dart`
  - `lib/features/doctors/presentation/cubit/doctors_state.freezed.dart`
  - `lib/features/doctors/presentation/pages/add_doctor_page.dart`
  - `lib/features/doctors/presentation/pages/add_doctor_view.dart`
  - `lib/features/doctors/presentation/pages/doctor_profile_page.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_button.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_basic_section.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_header.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_professional_section.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_qualifications_section.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_save_bar.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_specialty_picker.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_text_field.dart`
  - `lib/features/doctors/presentation/widgets/doctor_profile_header.dart`
  - `lib/features/doctors/presentation/widgets/doctor_profile_schedule.dart`
  - `lib/features/doctors/presentation/widgets/doctors_list.dart`
  - `lib/config/routes/app_router.dart`
  - `lib/core/di/service_locator.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Appointments Counters Fix
- Date: 2026-07-25.
- Appointments header counters now use backend pagination totals from lightweight `per_page=1` requests for all/pending/accepted/completed.
- Appointment filter chip counters now calculate visible counts from the currently loaded list items by status, so non-selected filters no longer show hardcoded zero.
- No backend changes required.
- Files added/modified:
  - `lib/features/appointments/presentation/cubit/appointments_cubit.dart`
  - `lib/features/appointments/presentation/cubit/appointments_state.dart`
  - `lib/features/appointments/presentation/cubit/appointments_state.freezed.dart`
  - `lib/features/appointments/presentation/widgets/appointments_header.dart`
  - `lib/features/appointments/presentation/widgets/appointments_tabs.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Accepted Appointment Finish/Result Actions
- Date: 2026-07-25.
- Accepted normal appointments show one action: finish appointment via existing `finish` flow.
- Accepted lab/result-required appointments show two separate actions:
  - finish appointment via existing `finish` flow.
  - upload result via existing `result` flow.
- Uploading a result no longer replaces the explicit finish action.
- No backend changes required.
- Files added/modified:
  - `lib/features/appointments/presentation/pages/appointment_detail_view.dart`
  - `lib/features/appointments/presentation/widgets/appointment_actions.dart`
  - `lib/features/appointments/presentation/widgets/appointment_card.dart`
  - `lib/features/appointments/presentation/widgets/appointment_finish_sheet.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Appointment Detail Result/Notes Display
- Date: 2026-07-25.
- Appointment details now display backend `notes` when present.
- Appointment details now display an open-result-file action when backend `result_file` is present.
- Result file URLs use the same localhost-to-backend-host fallback used by reports.
- Appointment actions now update the currently opened detail item from the action response before reloading the list.
- No backend changes required if `ClinicAppointmentResource` already returns `notes` and `result_file`.
- Files added/modified:
  - `lib/features/appointments/data/models/clinic_appointment_model.dart`
  - `lib/features/appointments/presentation/cubit/appointments_cubit.dart`
  - `lib/features/appointments/presentation/pages/appointment_detail_view.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Home Quick Actions Navigation
- Date: 2026-07-25.
- Home Services quick action now navigates to `/services`.
- Home Reports quick action now navigates to `/reports`.
- No backend changes required.
- Files added/modified:
  - `lib/features/home/presentation/widgets/home_top_section.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Appointment Card Date-Time Display
- Date: 2026-07-25.
- Appointment cards now display both backend `date` and `time`.
- Time is formatted as `h:mm am/pm` when backend sends `HH:mm`, `HH:mm:ss`, or AM/PM time.
- No backend changes required.
- Files added/modified:
  - `lib/features/appointments/data/models/clinic_appointment_model.dart`
  - `lib/features/appointments/presentation/widgets/appointment_card.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Notifications Counters Pagination Pattern
- Date: 2026-07-25.
- Notifications header now uses full backend totals from lightweight `per_page=1` calls for all/unread/read.
- Notifications tab counters now use the same full backend totals, so selecting a tab does not reset other counters to zero while the filtered page loads.
- No backend changes required.
- Files added/modified:
  - `lib/features/notifications/presentation/cubit/notifications_cubit.dart`
  - `lib/features/notifications/presentation/widgets/notifications_header.dart`
  - `lib/features/notifications/presentation/widgets/notifications_tabs.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Notifications Duplicate Page 2 Fix
- Date: 2026-07-25.
- Fixed notifications pagination meta normalization to read backend `current_page/per_page` as well as `currentPage/perPage`.
- This prevents Flutter from resetting `currentPage` to 1 after loading page 2 and requesting page 2 again at the list bottom.
- No backend changes required.
- Files added/modified:
  - `lib/features/notifications/data/clinic_notifications_remote_data_source.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Reports Export Toast Message Fix
- Date: 2026-07-25.
- Reports export success toast now displays the backend response `message`.
- The report `file_url` is no longer used as the toast message.
- No backend changes required.
- Files added/modified:
  - `lib/features/reports/presentation/cubit/reports_cubit.dart`
  - `lib/features/reports/presentation/cubit/reports_state.dart`
  - `lib/features/reports/presentation/cubit/reports_cubit.freezed.dart`
  - `lib/features/reports/presentation/pages/reports_view.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Reports Generated Time Display Helper
- Date: 2026-07-25.
- Added report generated-time display helper in `ClinicGeneratedReportModelX`.
- Reports generated today show time only.
- Reports generated yesterday show yesterday label plus time.
- Older reports show date plus time.
- No backend changes required.
- Files added/modified:
  - `lib/features/reports/data/models/clinic_report_model.dart`
  - `lib/features/reports/presentation/widgets/report_entry_card.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Enabled Specializations Display Fix
- Date: 2026-07-25.
- Services specialties grid now displays only enabled specializations.
- Available/all specializations remain visible only inside the add bottom sheet.
- No backend changes required.
- Files added/modified:
  - `lib/features/services/presentation/widgets/services_catalog_grid.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Specialization Icon/Color Rendering
- Date: 2026-07-25.
- Added shared specialization visual helper for icon key, image URL/path, and hex color rendering.
- Supported icon keys in Flutter: `stethoscope`, `heart`, `heart-pulse`, `eye`, `tooth`, `skin`, `ear`, `stomach`, `brain`, `female`, `bone`, `baby-face`, `kidney`, `hospital`, `general`, `dermatology`, `cardiology`, `ophthalmology`, `orthopedics`, `pediatrics`, `dentistry`.
- Added `color` parsing for doctor specializations and service specializations.
- Services specialty cards and add sheet now use backend `icon` and `color`.
- Doctors filters, add/edit doctor specialty picker, and doctor cards now use backend specialization visual data when available.
- Unknown/null icon falls back to hospital icon; null/invalid color falls back to existing primary color.
- Files added/modified:
  - `lib/shared/widgets/specialization_visual.dart`
  - `lib/features/doctors/data/models/clinic_doctor_model.dart`
  - `lib/features/doctors/data/models/clinic_doctor_model.freezed.dart`
  - `lib/features/doctors/data/models/clinic_doctor_model.g.dart`
  - `lib/features/doctors/data/models/clinic_specialization_model.dart`
  - `lib/features/doctors/data/models/clinic_specialization_model.freezed.dart`
  - `lib/features/doctors/data/models/clinic_specialization_model.g.dart`
  - `lib/features/doctors/presentation/widgets/add_doctor_specialty_picker.dart`
  - `lib/features/doctors/presentation/widgets/doctor_card.dart`
  - `lib/features/doctors/presentation/widgets/doctors_filter_chips.dart`
  - `lib/features/doctors/presentation/widgets/doctors_list.dart`
  - `lib/features/services/data/models/clinic_service_model.dart`
  - `lib/features/services/data/models/clinic_service_model.freezed.dart`
  - `lib/features/services/data/models/clinic_service_model.g.dart`
  - `lib/features/services/presentation/services_l10n.dart`
  - `lib/features/services/presentation/widgets/service_card.dart`
  - `lib/features/services/presentation/widgets/services_add_sheet.dart`
  - `lib/features/services/presentation/widgets/services_catalog_grid.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Add Specialization Sheet Scroll/Color Fix
- Date: 2026-07-25.
- Shared bottom sheet shell now constrains height and scrolls large content to prevent vertical overflow.
- Add-specialization bottom sheet tiles now apply specialization color to tile tint, border, and icon.
- No backend changes required.
- Files added/modified:
  - `lib/shared/widgets/app_bottom_sheet.dart`
  - `lib/features/services/presentation/widgets/services_add_sheet.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Specialization Remove From Add Sheet
- Date: 2026-07-25.
- Add-specialization bottom sheet now toggles enabled specializations.
- Tapping an already-added specialization calls existing remove-specialization API and removes it from the enabled grid.
- No backend changes required.
- Files added/modified:
  - `lib/features/services/presentation/cubit/services_cubit.dart`
  - `lib/features/services/presentation/widgets/services_add_sheet.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Services Lab Section Detail Link Fix
- Date: 2026-07-25.
- Enabled lab tests now sync their `section_id` values into the visible lab sections list after loading from the backend.
- Tapping a lab section card opens the existing detail page and loads that section's available tests plus enabled prices/states.
- Lab detail header count now uses pagination total when available.
- No backend changes required.
- Files added/modified:
  - `lib/features/services/presentation/cubit/services_cubit.dart`
  - `lib/features/services/presentation/pages/services_view.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Lab Services Icon/Color Rendering
- Date: 2026-07-25.
- Lab sections and lab tests now use the same polymorphic `icon` and hex `color` parser used by specializations.
- Lab section cards and add sheet render backend icon/color with existing slug fallback.
- Lab test detail cards read `section_icon`/`section_color`, render the icon inside the code chip, and use section color fallback.
- Added lab icon keys: `lab`, `laboratory`, `analysis`, `analyses`, `test`, `tests`, `test-tube`, `blood`, `dna`, `marriage`, `pre-marriage`, `hormones`, `vitamins`.
- No backend changes required beyond the documented `icon`/`color` response fields.
- Files added/modified:
  - `lib/features/services/data/models/clinic_service_model.dart`
  - `lib/features/services/data/models/clinic_service_model.freezed.dart`
  - `lib/features/services/data/models/clinic_service_model.g.dart`
  - `lib/features/services/presentation/services_l10n.dart`
  - `lib/features/services/presentation/widgets/service_test_card.dart`
  - `lib/features/services/presentation/widgets/services_add_sheet.dart`
  - `lib/features/services/presentation/widgets/services_catalog_grid.dart`
  - `lib/shared/widgets/specialization_visual.dart`
  - `PROJECT_HANDOFF.md`
  - `BACKEND_NOTES.md`

## Completed: Lab Detail Pagination Rebuild Fix
- Date: 2026-07-25.
- Services state now increments a lightweight `version` after internal pagination list updates so Bloc rebuilds when `PaginationState` changes.
- Lab detail list reads available tests from the latest Cubit state and displays all returned `lab-tests` even when `enabled-lab-tests` is empty.
- Enabled lab tests remain the source for active status and clinic price overrides.
- No backend changes required.
- Files added/modified:
  - `lib/features/services/presentation/cubit/services_cubit.dart`
  - `lib/features/services/presentation/cubit/services_state.dart`
  - `lib/features/services/presentation/cubit/services_cubit.freezed.dart`
  - `lib/features/services/presentation/widgets/services_detail_list.dart`
  - `PROJECT_HANDOFF.md`

## Completed: Lab Section Counter Preservation Fix
- Date: 2026-07-25.
- Lab section card counters are now stored per `section_id` in `ServicesState`.
- Opening one lab section updates only that section's counter and no longer zeroes counters for other visible lab sections.
- No backend changes required.
- Files added/modified:
  - `lib/features/services/presentation/cubit/services_cubit.dart`
  - `lib/features/services/presentation/cubit/services_state.dart`
  - `lib/features/services/presentation/cubit/services_cubit.freezed.dart`
  - `lib/features/services/presentation/widgets/services_catalog_grid.dart`
  - `PROJECT_HANDOFF.md`
