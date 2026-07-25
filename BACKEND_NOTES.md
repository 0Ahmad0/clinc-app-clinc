# Clinic App Backend Notes

## Source Of Truth
- This file is the local backend contract reference for the current Clinic Flutter app project.
- Do not invent endpoints, request fields, response models, auth/token behavior, upload contracts, or pagination metadata.
- If this file does not document a Clinic endpoint, treat that endpoint as unavailable for Flutter integration.
- If this file conflicts with current backend code, current backend code is the source of truth.

## Unified API Contract
- Success responses follow the backend unified contract:
  - `status: "success"`
  - `message`
  - `data`
  - optional `meta`
- Error responses follow the backend unified contract:
  - `status: "error"`
  - `message`
  - `error`
- Validation errors must be field-keyed.
- Business errors must use structured error objects.
- Unauthorized response:
  - `status: "error"`
  - `message: "Unauthenticated"`
  - `error: null`

## Existing Clinic APIs

### Clinic Register
- Endpoint: `POST /api/clinic/register`
- Status: available.
- Request fields:
  - `name`: required string, max 255.
  - `license_number`: required string, max 255, unique in `clinics`.
  - `email`: required email, max 255, unique in `clinics`.
  - `password`: required string, min 8.
  - `type`: required enum: `clinic`, `lab`, `both`.
- Response model:
  - `ClinicResource`
- Response data fields currently include:
  - `clinic_id`
  - `name`
  - `location`
  - `doctors_count`
  - `appointments_count`
  - `revenue`
  - `rating`
  - `status`
  - `email`
  - `phone`
  - `type`
  - `logo`
  - `cover`
  - `description`
  - `lat`
  - `lng`
  - `is_active`
  - `created_at`
- Business behavior:
  - Creates a clinic with `status: pending`.
  - Request goes to admin approval workflow.

### Clinic Login
- Endpoint: `POST /api/clinic/login`
- Status: available.
- Request fields:
  - `email`: required string, max 255.
  - `password`: required string.
  - `device_name`: nullable string, max 255.
- Backend behavior:
  - The `email` field accepts either clinic email or license number.
  - Pending, rejected, and inactive clinics receive error responses.
- Response model:
  - `ClinicLoginResource`
- Response data fields:
  - `clinic`: `ClinicResource`
  - `token`
  - `token_type`
  - `expires_at`
  - `needs_completion`
  - `missing_fields`

### Clinic Me
- Endpoint: `GET /api/clinic/me`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: none.
- Response model:
  - `ClinicProfileResource`
- Response data fields:
  - `clinic`: `ClinicResource`
  - `needs_completion`
  - `missing_fields`

### Clinic Logout
- Endpoint: `POST /api/clinic/logout`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: none.
- Response model:
  - `ClinicLogoutResource`
- Response data fields:
  - `logged_out`

### Clinic Forgot Password
- Endpoint: `POST /api/clinic/forgot-password`
- Status: available.
- Request fields:
  - `email`: required email, max 255, exists in `clinics.email`.
- Response model:
  - `ClinicOtpStatusResource`
- Response data fields:
  - `identifier`
  - `purpose`
  - `expires_in`

### Clinic Verify OTP
- Endpoint: `POST /api/clinic/verify-otp`
- Status: available.
- Request fields:
  - `identifier`: required string.
  - `otp`: required string.
  - `purpose`: required enum: `clinic_password_reset`.
- Response model:
  - `ClinicOtpVerificationResource`
- Response data fields:
  - `reset_token`
  - `expires_in`

### Clinic Resend OTP
- Endpoint: `POST /api/clinic/resend-otp`
- Status: available.
- Request fields:
  - `identifier`: required string.
  - `purpose`: required enum: `clinic_password_reset`.
- Response model:
  - `ClinicOtpStatusResource`
- Response data fields:
  - `identifier`
  - `purpose`
  - `expires_in`

### Clinic Reset Password
- Endpoint: `POST /api/clinic/reset-password`
- Status: available.
- Request fields:
  - `reset_token`: required string.
  - `password`: required string, min 8, confirmed.
  - `password_confirmation`: required string.
- Response model:
  - `ClinicPasswordResetResource`
- Response data fields:
  - `reset`
- Business behavior:
  - Old clinic auth tokens are revoked after successful password reset.

### Clinic Dashboard
- Endpoint: `GET /api/clinic/dashboard`
- Status: available.
- Authorization: `clinic.auth`.
- Request query fields:
  - `date`: nullable date, defaults to today.
- Response model:
  - `ClinicDashboardResource`
- Response data fields:
  - `clinic`: `ClinicDashboardClinicResource`
    - `clinic_id`
    - `name`
    - `logo`
    - `cover`
    - `status`
    - `is_active`
    - `is_open`
    - `working_hours_text`
  - `stats`: `ClinicDashboardStatsResource`
    - `patients_count`
    - `doctors_count`
    - `daily_income`
    - `today_appointments_count`
    - `pending_appointments_count`
    - `completed_appointments_count`
    - `rejected_appointments_count`
  - `appointments`: list of `ClinicDashboardAppointmentResource`
    - `appointment_id`
    - `patient_name`
    - `service_name`
    - `type`
    - `time`
    - `date`
    - `status`
    - `doctor_name`
    - `specialization_name`
    - `icon`
  - `notifications`
    - `unread_count`
- Business behavior:
  - Returns data only for authenticated clinic.
  - Returns nearest 5 appointments for today or requested date.
  - No pagination.

### Clinic Doctors List
- Endpoint: `GET /api/clinic/doctors`
- Status: available.
- Authorization: `clinic.auth`.
- Query fields: `page`, `per_page`, `search`, `specialization_id`, `is_active`.
- Response: `ClinicDoctorCollectionResource` with `data.data` and `data.meta`.

### Clinic Doctor Details
- Endpoint: `GET /api/clinic/doctors/{doctor}`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `ClinicDoctorResource`.

### Clinic Add Doctor
- Endpoint: `POST /api/clinic/doctors`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `name_ar`, `name_en`, `specialization_id`, `gender`, `phone`, `email`, `license_number`, `experience_years`, `consultation_fee`, `bio`, `image`, `qualification_files`, `is_active`, `schedules`.
- Response: `ClinicDoctorResource`.

### Clinic Update Doctor
- Endpoint: `PUT /api/clinic/doctors/{doctor}`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: same as add doctor.
- Response: `ClinicDoctorResource`.

### Clinic Doctor Availability
- Endpoint: `PATCH /api/clinic/doctors/{doctor}/availability`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `is_active`.
- Response: `ClinicDoctorResource`.

### Clinic Specializations
- Endpoint: `GET /api/clinic/specializations`
- Status: available.
- Authorization: `clinic.auth`.
- Response: list of `ClinicSpecializationResource`.

### Clinic Appointments List
- Endpoint: `GET /api/clinic/appointments`
- Status: available.
- Authorization: `clinic.auth`.
- Query fields: `page`, `per_page`, `status`, `type`, `date`, `search`.
- Response: `ClinicAppointmentCollectionResource` with `data.data` and `data.meta`.

### Clinic Appointment Details
- Endpoint: `GET /api/clinic/appointments/{appointment}`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `ClinicAppointmentResource`.

### Clinic Appointment Accept
- Endpoint: `POST /api/clinic/appointments/{appointment}/accept`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: none.
- Response: `ClinicAppointmentResource`.

### Clinic Appointment Reject
- Endpoint: `POST /api/clinic/appointments/{appointment}/reject`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `reason_id`, `reason`, `notes`.
- Response: `ClinicAppointmentResource`.

### Clinic Appointment Finish
- Endpoint: `POST /api/clinic/appointments/{appointment}/finish`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `notes`.
- Response: `ClinicAppointmentResource`.

### Clinic Appointment Result Upload
- Endpoint: `POST /api/clinic/appointments/{appointment}/result`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `result_file` PDF.
- Response: `ClinicAppointmentResource`.

### Clinic Reports Summary
- Endpoint: `GET /api/clinic/reports/summary`
- Status: available.
- Authorization: `clinic.auth`.
- Query fields: `period`, `type`, `date`.
- `period` values: `week`, `month`, `year`.
- `type` values: `appointments`, `clinic`, `revenue`, `doctors`.
- Response: `ClinicReportSummaryResource`.

### Clinic Reports Export
- Endpoint: `POST /api/clinic/reports/export`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `period`, `type`, `format`, `date`.
- `format` values: `pdf`, `xlsx`.
- Response: `ClinicGeneratedReportResource`.

### Clinic Generated Reports List
- Endpoint: `GET /api/clinic/reports/generated`
- Status: available.
- Authorization: `clinic.auth`.
- Query fields: `page`, `per_page`, `period`, `type`.
- Response: `ClinicGeneratedReportCollectionResource` with `data.data` and `data.meta`.

### Clinic Generated Report Download
- Endpoint: `GET /api/clinic/reports/generated/{report}/download`
- Status: available.
- Authorization: `clinic.auth`.
- Response: binary file download.

### Clinic Settings Profile
- Endpoint: `GET /api/clinic/profile`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `ClinicSettingsProfileResource`.

### Clinic Settings Update Profile
- Endpoint: `PUT /api/clinic/profile`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `name`, `email`, `phone`, `location`, `description`, `website`, `lat`, `lng`, `logo`, `cover`, `working_hours`.
- `license_number` is not editable.
- Response: `ClinicSettingsProfileUpdateResource`.

### Clinic Change Password
- Endpoint: `POST /api/clinic/change-password`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `current_password`, `password`, `password_confirmation`.
- Response: `ClinicPasswordChangeResource`.

### Clinic Notification Settings
- Endpoint: `GET /api/clinic/notification-settings`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `ClinicNotificationSettingsResource`.

### Clinic Update Notification Settings
- Endpoint: `PUT /api/clinic/notification-settings`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `app_notifications`, `email_notifications`, `sms_notifications`.
- Response: `ClinicNotificationSettingsResource`.

### Clinic Device Token
- Endpoint: `POST /api/clinic/device-token`
- Status: available.
- Authorization: `clinic.auth`.
- Request fields: `token`, `platform`, `device_id`, `app_version`, `locale`.
- Response: `UserDeviceResource`.

### Clinic Notifications List
- Endpoint: `GET /api/clinic/notifications`
- Status: available.
- Authorization: `clinic.auth`.
- Query fields: `page`, `per_page`, `is_read`.
- Response: `NotificationCollection` with `data.items` and top-level `meta`.

### Clinic Notification Read
- Endpoint: `POST /api/clinic/notifications/{notification}/read`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `NotificationResource`.

### Clinic Notifications Mark All Read
- Endpoint: `POST /api/clinic/notifications/mark-all-read`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `MarkAllNotificationsReadResource`.

### Clinic Notifications Unread Count
- Endpoint: `GET /api/clinic/notifications/unread-count`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `UnreadCountResource`.

### Clinic Notification Delete
- Endpoint: `DELETE /api/clinic/notifications/{notification}`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `ClinicNotificationDeletionResource`.

### Clinic Notifications Clear
- Endpoint: `DELETE /api/clinic/notifications`
- Status: available.
- Authorization: `clinic.auth`.
- Response: `ClinicNotificationsClearResource`.

## Missing Clinic APIs
- None for the documented Clinic Services contract below.

## Required Clinic Services API Contract

### Clinic Lab Sections
- Endpoint: `GET /api/clinic/services/lab-sections`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `lab`, `both`.
- Query fields: none.
- Response resource: `ClinicLabSectionResource`.
- Response data shape:
  - `section_id`
  - `slug`
  - `name`
  - `name_ar`
  - `name_en`
  - `description`
  - `icon`
  - `color`
  - `is_active`

### Clinic Available Lab Tests
- Endpoint: `GET /api/clinic/services/lab-tests`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `lab`, `both`.
- Query fields:
  - `page`: nullable integer min 1.
  - `per_page`: nullable integer min 1 max 100.
  - `search`: nullable string max 255.
  - `section_id`: nullable exists lab section/category id.
  - `section_slug`: nullable string.
- Response resource: `ClinicAvailableLabTestCollectionResource`.
- Response data shape:
  - `data`: list of `ClinicAvailableLabTestResource`.
  - `meta.currentPage`
  - `meta.perPage`
  - `meta.total`
  - `meta.hasMore`
- `ClinicAvailableLabTestResource` fields:
  - `lab_test_id`
  - `code`
  - `name`
  - `name_ar`
  - `name_en`
  - `description`
  - `section_id`
  - `section_slug`
  - `section_name`
  - `section_icon`
  - `section_color`
  - `default_price`
  - `is_active`

### Clinic Enabled Lab Tests
- Endpoint: `GET /api/clinic/services/enabled-lab-tests`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `lab`, `both`.
- Query fields:
  - `page`: nullable integer min 1.
  - `per_page`: nullable integer min 1 max 100.
  - `search`: nullable string max 255.
  - `section_id`: nullable exists lab section/category id.
  - `is_active`: nullable boolean.
- Response resource: `ClinicEnabledLabTestCollectionResource`.
- Response data shape:
  - `data`: list of `ClinicEnabledLabTestResource`.
  - `meta.currentPage`
  - `meta.perPage`
  - `meta.total`
  - `meta.hasMore`
- `ClinicEnabledLabTestResource` fields:
  - `clinic_lab_test_id`
  - `lab_test_id`
  - `code`
  - `name`
  - `name_ar`
  - `name_en`
  - `section_id`
  - `section_slug`
  - `section_name`
  - `section_icon`
  - `section_color`
  - `price`
  - `default_price`
  - `is_active`

### Clinic Enable/Update Lab Test
- Endpoint: `POST /api/clinic/services/lab-tests/{labTest}`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `lab`, `both`.
- Request fields:
  - `price`: required numeric min 0.
  - `is_active`: required boolean.
- Response resource: `ClinicEnabledLabTestResource`.

### Clinic Update Enabled Lab Test
- Endpoint: `PUT /api/clinic/services/lab-tests/{labTest}`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `lab`, `both`.
- Request fields:
  - `price`: required numeric min 0.
  - `is_active`: required boolean.
- Response resource: `ClinicEnabledLabTestResource`.

### Clinic Remove Lab Test
- Endpoint: `DELETE /api/clinic/services/lab-tests/{labTest}`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `lab`, `both`.
- Request fields: none.
- Response resource: `ClinicServiceRemovalResource`.
- Response data fields:
  - `removed`

### Flutter Lab Section Detail Integration Note
- Status: implemented on 2026-07-25.
- No backend changes required.
- Flutter uses:
  - `GET /api/clinic/services/lab-sections` for lab section cards.
  - `GET /api/clinic/services/enabled-lab-tests` to derive visible enabled section IDs.
  - `GET /api/clinic/services/lab-tests?section_id=...` for the tapped section detail list.
  - `POST|PUT|DELETE /api/clinic/services/lab-tests/{labTest}` for enable/update/remove.
- Detail count uses paginated `meta.total` when present.

### Clinic Available Service Specializations
- Endpoint: `GET /api/clinic/services/specializations`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `clinic`, `both`.
- Query fields:
  - `page`: nullable integer min 1.
  - `per_page`: nullable integer min 1 max 100.
  - `search`: nullable string max 255.
- Response resource: `ClinicAvailableServiceSpecializationCollectionResource`.
- Response data shape:
  - `data`: list of `ClinicAvailableServiceSpecializationResource`.
  - `meta.currentPage`
  - `meta.perPage`
  - `meta.total`
  - `meta.hasMore`
- `ClinicAvailableServiceSpecializationResource` fields:
  - `specialization_id`
  - `slug`
  - `name`
  - `name_ar`
  - `name_en`
  - `description`
  - `icon`
  - `is_active`

### Clinic Enabled Service Specializations
- Endpoint: `GET /api/clinic/services/enabled-specializations`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `clinic`, `both`.
- Query fields:
  - `page`: nullable integer min 1.
  - `per_page`: nullable integer min 1 max 100.
  - `search`: nullable string max 255.
  - `is_active`: nullable boolean.
- Response resource: `ClinicEnabledServiceSpecializationCollectionResource`.
- Response data shape:
  - `data`: list of `ClinicEnabledServiceSpecializationResource`.
  - `meta.currentPage`
  - `meta.perPage`
  - `meta.total`
  - `meta.hasMore`
- `ClinicEnabledServiceSpecializationResource` fields:
  - `clinic_specialization_id`
  - `specialization_id`
  - `slug`
  - `name`
  - `name_ar`
  - `name_en`
  - `icon`
  - `is_active`

### Clinic Enable/Update Service Specialization
- Endpoint: `POST /api/clinic/services/specializations/{specialization}`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `clinic`, `both`.
- Request fields:
  - `is_active`: required boolean.
- Response resource: `ClinicEnabledServiceSpecializationResource`.

### Clinic Update Enabled Service Specialization
- Endpoint: `PUT /api/clinic/services/specializations/{specialization}`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `clinic`, `both`.
- Request fields:
  - `is_active`: required boolean.
- Response resource: `ClinicEnabledServiceSpecializationResource`.

### Clinic Remove Service Specialization
- Endpoint: `DELETE /api/clinic/services/specializations/{specialization}`
- Status: available.
- Authorization: `clinic.auth`.
- Clinic types allowed: `clinic`, `both`.
- Request fields: none.
- Response resource: `ClinicServiceRemovalResource`.
- Response data fields:
  - `removed`

## Pagination Contract
- Do not assume pagination metadata for missing Clinic endpoints.
- When a Clinic list endpoint is added, Flutter expects list responses to be parsed as `BaseModel<BaseModels<T>>`.
- Pagination metadata must be explicit in the backend contract before implementation.
- Flutter pagination expects:
  - `currentPage`
  - `perPage`
  - `total`
  - `hasMore` or enough meta to derive it.

## Flutter Integration Rule
- Flutter may only integrate endpoints listed as available in this file or verified directly from current backend code.
- For every missing endpoint above, stop and report the missing backend contract before implementing the Flutter feature.
- Do not reuse User APIs for Clinic APIs unless explicitly documented here as Clinic-compatible.
- If a Clinic endpoint is missing, produce a `BACKEND API PROMPT` for the backend developer/Codex instead of wiring Flutter to a fake or guessed endpoint.
- The backend prompt must define routes, methods, controllers, validation requests, resources, models/relations, authorization, response JSON, pagination metadata, filters/search, and migrations if needed.

## Flutter Consumption Notes
- No new backend endpoints were required for the notifications counters fix.
- For notifications counters in Flutter:
  - unread count source: `GET /api/clinic/notifications/unread-count`.
  - tab totals source: paginated list meta from `GET /api/clinic/notifications` with current `is_read` filter.
- No new backend endpoints were required for home clinic-name live refresh; Flutter now reacts to local clinic cache updates after profile save.
- No new backend endpoints were required for profile-save success toast; this is Flutter presentation feedback only.
- No new backend endpoints were required to remove notifications full reload on open; Flutter now performs local list/counter updates after `mark-read`.
- No new backend endpoints were required for services account-type routing fix; Flutter now maps cached clinic `type` to allowed services kind before loading services APIs.
- No new backend endpoints were required for custom Dio API logging; this enhancement is Flutter-side diagnostics/log formatting only.
- No new backend endpoints were required for raw body log display; this is logger presentation behavior only.
- No new backend endpoints were required for services-tab visibility update; this is Flutter UI behavior only.
- No new backend endpoints were required for services tab click/data visibility behavior; Flutter now surfaces backend permission errors and shows available specialties when no enabled specialties exist.

- No new backend endpoints were required for restoring services-tab hide behavior by account type; this is Flutter UI visibility logic only.
- No new backend endpoints were required for reports entry-card border crash fix; this is Flutter rendering/decorations logic only.
- No new backend endpoints were required for services numeric/string parsing compatibility fix; this is Flutter model decoding resilience for existing payload shapes.
- No new backend endpoints were required for restoring lab sections add/remove UX; Flutter now manages selected lab sections locally and syncs initial selection from enabled lab tests data.
- No new backend endpoints were required for reports date format and report file open behavior; this is Flutter presentation/link-opening logic over existing `file_url` and `generated_at` fields.
- No new backend endpoints were required for Clinic doctor add/edit/details; Flutter now consumes existing `GET /api/clinic/doctors/{doctor}`, `POST /api/clinic/doctors`, `PUT /api/clinic/doctors/{doctor}`, and `GET /api/clinic/specializations`.
- Flutter doctor add/edit sends documented scalar fields, `schedules.*.day/from/to/is_active`, optional multipart `image`, and optional multipart `qualification_files[]` when selected.
- Backend should verify create/update still accept multipart `PUT` and `POST` payloads, keep `image` and `qualification_files` optional, validate `image` as image, and validate `qualification_files.*` as PDF/file.
- Removing newly selected local image/files before save is Flutter-only. Removing already-uploaded server assets needs an explicit backend request contract if required later.
- No new backend endpoints were required for appointments counters fix; Flutter reads pagination `meta.total` from existing `GET /api/clinic/appointments` calls and calculates visible filter-chip counts from loaded list items.
- No new backend endpoints were required for accepted appointment action split; Flutter now keeps `finish` and `result` as separate actions for lab/result-required appointments.
- No new backend endpoints were required for appointment detail result/notes display; Flutter reads existing `notes` and `result_file` fields from `ClinicAppointmentResource`.
- No new backend endpoints were required for home quick actions navigation; this is Flutter routing only.
- No new backend endpoints were required for appointment card date-time display; Flutter formats existing `date` and `time` fields.
- No new backend endpoints were required for notifications counters pagination pattern; Flutter reads full totals from existing paginated notifications meta and keeps tab counters stable when filtered pages load.
- No new backend endpoints were required for notifications duplicate page 2 fix; Flutter now normalizes existing `current_page/per_page` pagination meta correctly.
- No new backend endpoints were required for reports export toast message fix; Flutter now displays the existing response `message` instead of `data.file_url`.
- No new backend endpoints were required for reports generated-time display helper; Flutter formats existing `generated_at` locally.
- No new backend endpoints were required for services enabled specializations display fix; Flutter now renders only `enabled-specializations` in the main grid and keeps available specializations in the add sheet.
- No new backend endpoints were required for specialization icon/color rendering; Flutter now reads existing `icon` and new `color` fields and supports icon keys or image URL/path values.
- Flutter supported specialization icon keys: `stethoscope`, `heart`, `heart-pulse`, `eye`, `tooth`, `skin`, `ear`, `stomach`, `brain`, `female`, `bone`, `baby-face`, `kidney`, `hospital`, `general`, `dermatology`, `cardiology`, `ophthalmology`, `orthopedics`, `pediatrics`, `dentistry`.
- No new backend endpoints were required for services add-specialization sheet scroll/color fix; this is Flutter layout and presentation only.
- No new backend endpoints were required for services specialization remove from add sheet; Flutter uses existing `DELETE /api/clinic/services/specializations/{specialization}`.
