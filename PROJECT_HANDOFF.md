# Project Handoff Summary

> Official living handoff for future development chats. Update this file after
> completed work and keep the section order defined in `AGENTS.md`.

# Project Overview

* Project name: `clinc_app_clinc`
* Applications: Flutter User App, Flutter Clinic App, Laravel Backend, Filament Admin Dashboard.
* Current focus: Flutter Clinic App.
* Technologies: Flutter, Dart, GetX, GetIt, Dio, GetStorage, Easy Localization.
* Current architecture: Feature modules with View, Controller, Model/DTO, DataSource, Repository, dependency registration.
* Current development strategy: Build one feature at a time using API-shaped MockDataSources; replace them later with RemoteDataSources without UI changes.

# Development Rules

* Follow the existing architecture and naming exactly.
* Never redesign, rename, or reorganize the project unless explicitly requested.
* Work feature-by-feature only.
* Use MockDataSource until the backend is ready.
* Mock responses must match the future Laravel contract.
* UI must never access or hardcode data directly.
* Repository pattern is mandatory.
* Use `BaseModel<T>` for single items and `BaseModel<BaseModels<T>>` for lists.
* Lists use `GeneralLoading`: initial, loading, success, failure, empty.
* Use pagination metadata: `current_page`, `from`, `to`, `per_page`, `total`.
* Keep per-item loading states separate using item-ID sets.
* Do not implement Laravel or alter the database.
* Record missing backend requirements in `BACKEND_NOTES.md`.
* Do not modify unrelated files.
* Do not continue to another feature unless requested.
* Preserve previous work unless changes are explicitly requested.
* Keep responses concise and implementation-focused.
* Minimize reasoning, repetition, output, and token usage.

# API Contract

* Success: `status: "success"`, human-readable `message`, `data`, `meta`.
* Validation Error: `status: "error"`, `"Validation failed"`, field-keyed error arrays.
* Business Error: `status: "error"`, business `message`, structured `error`.
* Unauthorized: `status: "error"`, `"Unauthenticated"`, `error: null`.
* Server Error: `status: "error"`, `"Something went wrong"`, `error: null`.
* `BaseModel.status` uses `"success"`/`"error"` strings.

# Backend Notes

## Clinic Login

* Token persistence, expiry, revocation, and authentication infrastructure.
* Public clinic ID mapping.
* Profile-completion state and missing-fields rules.
* Derived doctors, appointments, revenue, and rating values.
* `POST /api/clinic/login`.
* Only active approved clinics may receive tokens.
* Social login endpoint and Google/Apple credential verification.

## Registration, OTP, Password Recovery

* Clinic email verification and secure expiring single-use OTP storage.
* Registration review history, rejection reason, reviewer, and timestamps.
* Registration, forgot-password, verify/resend OTP, and reset-password APIs.
* Password rules, throttling, and anti-enumeration behavior.
* Admin notification for new registrations.
* Reset-password Flutter screen and mock flow are implemented; backend endpoint remains required.

## Complete Clinic Profile

* Insurance table and clinic-insurance pivot.
* Clinic working-hours table.
* Persisted/calculated profile-completion state.
* Insurance listing and multipart profile-completion APIs.
* Logo/cover storage rules and absolute URLs.
* Filament insurance management.

## Dashboard

* Clinic schedule required for open/closed calculation.
* Patient image support.
* Explicit clinic/service relationship for appointments, including lab appointments.
* Consultation title/icon source.
* Dashboard aggregate API and calculation rules for patients and revenue.
* Normalize appointment statuses and timezone behavior.

## Doctors List

* Doctor profile-image column/storage.
* Valid Arabic/English specialization seed data.
* Public doctor IDs if required.
* Paginated doctor list with search and specialization filtering.
* Define persisted versus computed availability.

## Notifications

* Notification type, icon, related ID/type, and optional public ID.
* Paginated list, mark-one/all-read, delete-one/all APIs.
* Notification settings read/update APIs.
* Clinic ownership enforcement.
* Admin notification sending rules.
* Unread-count synchronization and timestamp timezone.

## Pending Approval

* Non-guessable registration reference/token.
* Registration status API supporting pending, approved, and rejected.
* Approval/rejection notifications.
* Support contact configuration.
* Filament approval/rejection must update status and reason atomically.

## Reports

* Reports/export-jobs table with status, file, summary, timestamps, and failures.
* Paginated list, report-generation, report-download, and report-share APIs.
* PDF/Excel protected storage and retention.
* Queue large reports and notify on completion/failure.
* Define calculations for weekly, monthly, yearly appointments, clinic, revenue, and doctor reports.

## Settings

* Clinic profile read API.
* Notification settings read/update APIs.
* Data export and clear-cache APIs.
* Support contact configuration and external contact URLs.

## Services

* Central admin-managed lab-test catalog.
* Clinic-category, clinic-test, and clinic-specialization pivots.
* Clinic-specific test price and enabled state.
* Clarify the future role of the existing `services` table.
* Paginated section listing, section addition, and test-update APIs.
* Enforce account type and doctor-specialization requirements.
* Filament management for categories, tests, specializations, translations, and icons.

# Completed Features

## Clinic Login

* Status: Completed with MockDataSource.
* Important files: `lib/modules/auth/`, `lib/app/services/storage_service.dart`.
* Remaining work: Laravel endpoint and real token.

## Registration, OTP, Forgot Password

* Status: Completed with API-shaped mock flows, account-type selection, email/license validation, registration OTP, password reset OTP, resend, and reset-password screen.
* Important files: `lib/modules/auth/`.
* Remaining work: Backend endpoints, secure OTP/reset-token storage, and admin review workflow.

## Complete Profile

* Status: Completed.
* Important files: `lib/modules/complete_profile/`.
* Remaining work: Backend persistence, insurance, media, and schedules.

## Dashboard

* Status: Completed.
* Important files: `lib/modules/dashboard/`.
* Remaining work: Real aggregate endpoint.

## Doctors List

* Status: Completed with search, specialization filtering, pagination, and states.
* Important files: `lib/modules/doctors/`.
* Remaining work: Real backend APIs.

## Add Doctor

* Status: Completed with API-shaped MockDataSource, multipart RemoteDataSource, repository, validation, loading/error handling, qualification files, and weekly schedule.
* Important files: `lib/modules/add_doctor/`, `lib/modules/doctors/data/doctors_mock_data_source.dart`.
* Remaining work: Laravel endpoint and backend media/schedule persistence.

## Doctor Details and Edit Doctor

* Status: Completed with `BaseModel<DoctorDetailsModel>`, repository-backed detail loading, shared mock persistence, multipart remote update, reactive detail refresh, and forced list refresh after add/edit.
* Important files: `lib/modules/doctors/`, `lib/modules/add_doctor/`, `test/doctor_system_test.dart`.
* Remaining work: Laravel details/update endpoints and backend persistence.

## Appointments List

* Status: Completed with search, status filters, refresh, pagination, and initial/loading/success/failure/empty states.
* Important files: `lib/modules/appointments/`.
* Remaining work: Real list API and normalized backend appointment relationships/statuses.

## Appointment Details and Actions

* Status: Completed with patient identity/image/contact, type, specialization, separate date/time, status, rejection reason/notes, approve/reject/complete actions, lab PDF upload after approval, shared mock persistence, and list refresh after mutations.
* Important files: `lib/modules/appointments/`, `test/appointment_flow_test.dart`.
* Remaining work: Real status/result APIs and protected result-file storage.

## Settings View

* Status: Completed with repository-backed mock clinic profile loading, notification settings synchronization, export data, clear cache, persisted preferences, language/theme restoration, independent avatar/cover Camera/Gallery selection, an interactive Google Maps location picker with address and coordinates, immutable license display, admin-approval profile update requests, support reports with predefined/custom subjects, descriptions and image attachments, working contact/support actions, Change Password mock flow, About/Privacy/Contact/Help screens, and full local-session logout using `Get.offAll`.
* Important files: `lib/modules/settings/views/`, `lib/modules/settings/controllers/settings_controller.dart`.
* Remaining work: Real profile/settings/export/cache APIs, real profile review API/admin workflow, real Change Password API, and production support/legal content.

## Auth and Runtime Flow Validation

* Status: Completed with form-backed login, Google/Apple/Guest mock login, registration-to-OTP-to-pending flow, OTP reset routing, reset-password mock flow, auth validation/states, and auth route bindings.
* Important files: `lib/modules/auth/`, `test/auth_flow_test.dart`.
* Validation: `flutter analyze lib/modules/auth test/auth_flow_test.dart` has no issues and `flutter test` passes.

## Main Layout

* Status: Completed.
* Important files: `lib/modules/main_layout/`, `StorageService`.
* Remaining work: Backend-backed profile-completion bootstrap.

## Notifications

* Status: Completed with filters, pagination, read/delete operations, and per-item loading.
* Important files: `lib/modules/notifications/`.
* Remaining work: Real APIs and unread badge.

## Onboarding

* Status: Completed with persisted local state.
* Important files: `lib/modules/onboarding/`, `lib/modules/splash/`.
* Remaining work: None.

## Pending Approval

* Status: Completed with pending/approved/rejected handling.
* Important files: `lib/modules/pending_approval/`.
* Remaining work: Real registration reference, API, and support contact.

## Reports

* Status: Completed with weekly/monthly/yearly PDF/Excel generation, paginated history, fixed empty-state generation, and mock download/share actions.
* Important files: `lib/modules/reports/`, `test/reports_module_test.dart`.
* Remaining work: Backend generation, queues, protected files, download URLs, and share URLs.

## Services

* Status: Completed with account-type tabs, paginated sections, category addition, test pricing/activation, and doctor requirement.
* Important files: `lib/modules/services/`.
* Remaining work: Backend catalog and pivots.

## Merge Integration Validation

* Status: Completed with merged UI/controller compatibility fixes, generated localization repair, asset transformer correction, splash animation bounds fix, analyzer validation without compile errors, all tests passing, and verified Android debug APK build.

# Remaining Features

* None for current mock-app scope.

# Current Database Notes

* Existing entities: clinics, doctors, doctor schedules, specializations, sub-specializations, services, lab-test categories, lab tests, patients, appointments, payments, reviews, notifications, users, regions, areas, password-reset tokens.
* Relationships: doctors belong to clinics and one specialization; doctor schedules belong to doctors; appointments belong to doctors and patients; payments belong to appointments; lab tests belong to clinics and categories; notifications may belong to clinics/users.
* Missing: clinic schedules, insurance entities/pivot, clinic-specialization pivot, reusable lab-test catalog and clinic-test pivot, doctor image, patient image, report/export tables, registration review/reference fields, notification type/icon/related fields, explicit appointment clinic/service relationship, persisted profile-completion state.

# Mock API Status

* `POST /api/clinic/login`
* `POST /api/clinic/register`
* `POST /api/clinic/forgot-password`
* `POST /api/clinic/verify-otp`
* `POST /api/clinic/resend-otp`
* `POST /api/clinic/reset-password`
* `POST /api/clinic/social-login`
* `GET /api/clinic/registration-status`
* `GET /api/insurances`
* `POST /api/clinic/complete-profile`
* `GET /api/clinic/dashboard`
* `GET /api/clinic/doctors`
* `POST /api/clinic/doctors`
* `GET /api/clinic/doctors/{id}`
* `PUT /api/clinic/doctors/{id}`
* `GET /api/clinic/appointments`
* `PUT /api/clinic/appointments/{id}/status`
* `POST /api/clinic/appointments/{id}/result`
* `PUT /api/clinic/change-password`
* `GET /api/clinic/profile`
* `POST /api/clinic/profile/update-request`
* `POST /api/clinic/support-requests`
* `GET /api/clinic/notifications`
* `GET /api/clinic/notification-settings`
* `PUT /api/clinic/notification-settings`
* `PUT /api/clinic/notifications/{id}/read`
* `PUT /api/clinic/notifications/read-all`
* `DELETE /api/clinic/notifications/{id}`
* `DELETE /api/clinic/notifications`
* `GET /api/clinic/reports`
* `POST /api/clinic/reports`
* `POST /api/clinic/reports/{id}/download`
* `POST /api/clinic/reports/{id}/share`
* `GET /api/clinic/settings/export`
* `DELETE /api/clinic/settings/cache`
* `GET /api/clinic/services`
* `POST /api/clinic/services/sections`
* `PUT /api/clinic/services/lab-tests/{id}`

# Next Task

None.
