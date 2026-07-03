# Backend Notes

## Feature

Clinic Login

## Database Changes

- Add API-token persistence/revocation support for clinic authentication.
- Define how the public `clinic_id` value (for example `C-001`) maps to the numeric `clinics.id`.
- Profile-completion state and missing required fields are not stored explicitly. Define the required fields or add suitable persistence.
- `doctors_count`, `appointments_count`, `revenue`, and `rating` are derived values and must be calculated by the API.

## New APIs

### Clinic Login

- Endpoint: `/api/clinic/login`
- Method: `POST`
- Request:

```json
{
  "identifier": "info@nukhba-clinic.com",
  "password": "password"
}
```

- Response: Use the unified API response contract. Success `data` contains `clinic`, `needs_completion`, `missing_fields`, and a string `token`.
- Errors: `422` validation error, `401` invalid credentials, `403` inactive/rejected clinic, business error for pending approval, `500` server error.

### Clinic Social Login

- Endpoint: `/api/clinic/social-login`
- Method: `POST`
- Request: `provider` (`google`, `apple`, or `guest`) plus production provider credentials when applicable.
- Response: Same authenticated clinic payload as Clinic Login.

## Validation

- `identifier`: required string; resolve case-insensitively against `email` or `license_number`.
- `password`: required string.
- Return validation errors under the unified `error` field.

## Permissions

- Only active, approved clinics may receive an authenticated application token.
- Pending clinics must receive their registration status without dashboard access.
- Rejected or inactive clinics must not receive a token.

## Notifications

None for login.

## Filament

None for login.

## Storage

- Return public absolute URLs for `logo` and `cover`, or document the common media base URL.

## Other Requirements

- Token is a plain string in the response contract.
- Define token expiry and revocation behavior.
- Normalize `created_at` to the agreed API date format.

---

## Feature

Clinic Registration, Password Recovery, and OTP Verification

## Database Changes

- Add `email_verified_at` to clinics if clinic email verification is required.
- Store hashed, expiring, single-use OTPs for clinic password recovery. The current `password_reset_tokens` table is keyed only by email and does not support license-number lookup or OTP metadata.
- Define storage for clinic registration review history, rejection reason, reviewer, and review timestamps. The current clinic `status` field stores only the latest state.

## New APIs

### Submit Clinic Registration

- Endpoint: `/api/clinic/register`
- Method: `POST`
- Request: `name`, `license_number`, `email`, `password`, `password_confirmation`, `type` (`clinic`, `lab`, or `both`).
- Response: Unified contract with the created clinic summary and `status: pending`.
- Errors: validation `422`, business error, server error.

### Request Password Reset OTP

- Endpoint: `/api/clinic/forgot-password`
- Method: `POST`
- Request: `identifier` containing clinic email or license number.
- Response: Unified contract containing `identifier`, `delivery_method`, and `expires_in`.
- Errors: validation `422`, not found `404`, server error.

### Verify Password Reset OTP

- Endpoint: `/api/clinic/verify-otp`
- Method: `POST`
- Request: `identifier`, `otp`, `purpose` (`registration` or `password_reset`).
- Response: Unified contract containing `verified` and a short-lived `reset_token`.
- Errors: validation `422`, invalid/expired OTP business error, server error.

### Resend Password Reset OTP

- Endpoint: `/api/clinic/resend-otp`
- Method: `POST`
- Request: `identifier`, `purpose` (`registration` or `password_reset`).
- Response: Unified contract containing `identifier` and `expires_in`.
- Errors: validation `422`, throttling business error, not found `404`, server error.

### Reset Clinic Password

- The Flutter reset-password screen and mock flow are implemented.
- Required endpoint: `POST /api/clinic/reset-password`.
- Request: `reset_token`, `password`, `password_confirmation`.

## Validation

- Registration email and license number must be unique.
- Password confirmation must match and backend password-strength rules must be defined.
- OTP must be four digits, expire after the returned duration, and be single-use.
- Apply resend and verification-attempt rate limits.

## Permissions

- Registration endpoints are public.
- OTP verification and password reset must be limited to the clinic tied to the issued token.
- Newly registered clinics remain blocked from authenticated clinic features until approved.
- Registration OTP verification confirms contact ownership, then the clinic remains in pending approval.

## Notifications

- Notify admins when a clinic registration request is submitted.
- Send password recovery OTP to the registered clinic email.

## Filament

- Add registration request listing, details, approve, and reject actions.

## Storage

None.

## Other Requirements

- Do not reveal whether an email/license exists if account-enumeration protection is required; define the chosen security behavior.
- Define OTP and reset-token expiry durations.

---

## Feature

Complete Clinic Profile

## Database Changes

- Add an `insurances` table managed by admin.
- Add a clinic-insurance pivot table with unique `clinic_id` and `insurance_id`.
- Add a clinic working-hours table containing `clinic_id`, `day`, `from`, `to`, and `is_active`. The existing `doctor_schedules` table cannot represent clinic hours.
- Define a persisted profile-completion state or calculate it consistently from required clinic fields.

## New APIs

### List Insurances

- Endpoint: `/api/insurances`
- Method: `GET`
- Response: Unified contract with `data.insurances`, each containing `id` and `name`.

### Complete Clinic Profile

- Endpoint: `/api/clinic/complete-profile`
- Method: `POST`
- Content-Type: `multipart/form-data`
- Request: `phone`, `logo`, `cover`, `insurance_ids[]`, and JSON `schedule`.
- Schedule item: `day`, `is_active`, `from`, `to`.
- Response: Unified contract containing updated clinic data, `needs_completion`, and `missing_fields`.
- Errors: validation `422`, unauthorized `401`, forbidden `403`, server error `500`.

## Validation

- `phone`: required valid clinic phone number.
- `logo` and `cover`: required images; define allowed MIME types and maximum sizes.
- `insurance_ids`: array of existing active insurance IDs.
- `schedule`: must contain all seven unique weekdays; active days require `from < to`.

## Permissions

- Only the authenticated clinic may complete its own profile.
- Define whether completion is allowed before or only after admin approval.

## Notifications

None.

## Filament

- Add insurance CRUD with active/inactive status.

## Storage

- Store clinic logo and cover under stable clinic-specific paths.
- Return public absolute media URLs in API responses.
- Replace old media safely when the clinic updates images later.

## Other Requirements

- API weekday values are lowercase English names (`saturday` through `friday`).
- API times use 24-hour `HH:mm` format.
- Define whether selecting at least one insurance is optional or required.

---

## Feature

Clinic Dashboard

## Database Changes

- Clinic working hours are required to calculate `is_open`; see Complete Clinic Profile notes.
- Add patient profile image support if appointment cards must display patient photos.
- Appointments need an explicit clinic/service relationship. Currently clinic ownership is inferred through `doctor_id`, and lab appointments still require a doctor.
- Define the consultation/service title and icon source for each appointment; these fields are not stored on the current appointment record.

## New APIs

### Clinic Dashboard

- Endpoint: `/api/clinic/dashboard`
- Method: `GET`
- Response: Unified contract with:
  - `clinic`: `clinic_id`, `name`, `logo`, `is_open`, `today_working_hours`.
  - `stats`: `doctors_count`, `patients_count`, `today_appointments_count`, `daily_income`, `currency`.
  - `today_appointments`: appointment ID, patient name/image, consultation name/icon, time, and status.
  - `meta`: effective `date` and `timezone`.
- Errors: unauthorized `401`, forbidden `403`, server error `500`.

## Validation

- Dashboard date must be evaluated using the clinic's configured timezone.
- Daily income must include only payment statuses defined as financially settled.

## Permissions

- Only the authenticated clinic may access its dashboard.
- Pending, rejected, or inactive clinics must not access dashboard data.

## Notifications

None.

## Filament

None.

## Storage

- Return an absolute public URL for clinic logo and patient images.

## Other Requirements

- Define whether `patients_count` means unique all-time patients or patients within a reporting period.
- Define whether daily income includes cash appointments, deposits, refunds, discounts, and insurance settlements.
- Normalize appointment statuses between the database (`confirmed`, `cancelled`) and Flutter's shared status contract.

---

## Feature

Clinic Doctors List

## Database Changes

- Add a nullable doctor profile-image path. The current `doctors` table has no image field.
- Current specialization seed data has empty Arabic names and null English names; valid localized names are required before exposing filters.
- Define public doctor IDs (for example `D-001`) if numeric database IDs must not be exposed.

## New APIs

### List Clinic Doctors

- Endpoint: `/api/clinic/doctors`
- Method: `GET`
- Query: optional `search`, optional `specialization_id`, and pagination parameters.
- Response: Unified contract with:
  - `data.doctors`: doctor ID, Arabic/English names, one specialization, image URL, availability, experience years, consultation fee, and currency.
  - `data.specializations`: specializations available among the authenticated clinic's doctors.
  - Pagination values under `meta`.
- Errors: validation `422`, unauthorized `401`, forbidden `403`, server error `500`.

## Validation

- `search`: optional trimmed string with a defined maximum length.
- `specialization_id`: optional existing active specialization ID.
- Validate and cap pagination size.

## Permissions

- Return only doctors belonging to the authenticated clinic.
- Pending, rejected, or inactive clinics must not access the list.

## Notifications

None.

## Filament

- Ensure specialization Arabic/English names and icons are populated and manageable.

## Storage

- Store doctor profile images and return absolute public URLs.

## Other Requirements

- Search must match Arabic name, English name, and specialization name.
- Each doctor has exactly one specialization through `doctors.specialization_id`.
- Define whether `is_available` is the persisted `is_active` value or a computed state based on schedule and current time.

---

## Feature

Clinic Notifications

## Database Changes

- Add notification `type`, `icon`, and nullable `related_id`/`related_type` fields. The current table stores only title, body, and read state.
- Consider UUID/public notification IDs if numeric database IDs must not be exposed.

## New APIs

### List Notifications

- Endpoint: `/api/clinic/notifications`
- Method: `GET`
- Query: `page`, optional `is_read` (`0` or `1`).
- Response: Unified contract with notification list under `data` and pagination under `meta`.

### Mark Notification as Read

- Endpoint: `/api/clinic/notifications/{notification}/read`
- Method: `PUT`

### Mark All Notifications as Read

- Endpoint: `/api/clinic/notifications/read-all`
- Method: `PUT`

### Delete Notification

- Endpoint: `/api/clinic/notifications/{notification}`
- Method: `DELETE`

### Delete All Notifications

- Endpoint: `/api/clinic/notifications`
- Method: `DELETE`

- All action responses use the unified contract with an empty `data` object.
- Errors: unauthorized `401`, forbidden `403`, not found `404`, server error `500`.

## Validation

- `is_read` accepts only `0` or `1`.
- Validate and cap pagination size.

## Permissions

- Clinics may list, read, or delete only notifications belonging to their authenticated clinic.

## Notifications

- Define notification types and the events that create clinic notifications.
- Define whether deletion is permanent or per-recipient soft deletion.

## Filament

- Define whether admins can send a notification to one clinic, selected clinics, or all clinics.

## Storage

None.

## Other Requirements

- Notification timestamps must be ISO 8601 and use a documented timezone.
- List pagination metadata must include `current_page`, `from`, `to`, `per_page`, and `total`.

---

## Feature

Clinic Services

## Database Changes

- Add a central admin-managed lab-test catalog. Current `lab_tests` rows belong directly to a clinic and cannot represent reusable test types.
- Add a clinic lab-category pivot so a category can be added once per clinic.
- Add a clinic lab-test pivot containing clinic-specific `price` and `is_enabled`.
- Add a clinic-specialization pivot with a unique clinic/specialization pair.
- Populate valid Arabic/English specialization names; current seed data contains empty names.
- Define whether the existing `services` table remains for additional clinic-defined services or is replaced by the catalog/pivot design.

## New APIs

### List Service Sections

- Endpoint: `/api/clinic/services`
- Method: `GET`
- Query: `type` (`lab` or `medical`), `page`.
- Response: Unified paginated contract containing lab categories with tests or medical specializations.
- Each section includes `is_added`; medical specializations include `has_doctor`.

### Add Service Section

- Endpoint: `/api/clinic/services/sections`
- Method: `POST`
- Request: `type`, `section_id`.
- Prevent adding the same section more than once.

### Update Clinic Lab Test

- Endpoint: `/api/clinic/services/lab-tests/{test}`
- Method: `PUT`
- Request: `section_id`, `is_enabled`, `price`.
- Response: Unified contract containing the updated category and tests.

## Validation

- Account type controls allowed service types: `clinic` medical only, `lab` laboratory only, `both` both.
- Enabling a lab test requires a price greater than zero.
- A lab test must belong to a category already added by the clinic.
- Adding a medical specialization requires at least one active clinic doctor with that specialization.

## Permissions

- Clinics may manage only their own enabled categories, tests, prices, and specializations.
- Only active admin-managed categories, tests, and specializations may be selected.

## Notifications

None.

## Filament

- Manage lab categories with localized names and icons.
- Manage reusable test types within each lab category.
- Manage localized medical specializations and icons.

## Storage

- Return absolute URLs if service icons are stored as media; otherwise document supported icon keys.

## Other Requirements

- List pagination metadata must include `current_page`, `from`, `to`, `per_page`, and `total`.
- Define behavior when the last doctor of an enabled specialization is removed or deactivated.
- Define unread-count synchronization for the notification badge.

---

## Feature

Clinic Registration Approval Status

## Database Changes

- Add a non-guessable public registration reference/token for each clinic registration request.
- Registration review history, rejection reason, reviewer, and timestamps remain required as noted under Clinic Registration.

## New APIs

### Check Clinic Registration Status

- Endpoint: `/api/clinic/registration-status`
- Method: `GET`
- Query: `registration_reference`.
- Response: Unified contract with `status` (`pending`, `approved`, or `rejected`), `needs_completion`, and nullable `rejection_reason` inside `data`.
- Errors: validation `422`, not found `404`, rate limit `429`, server error `500`.

## Validation

- `registration_reference` is required and must be a valid non-expired reference.
- Rate-limit manual status checks.

## Permissions

- The reference must grant access only to the related registration status and must not expose clinic-private data.

## Notifications

- Notify the clinic by email and configured channels when its request is approved or rejected.

## Filament

- Approval and rejection actions must update the registration status and rejection reason atomically.

## Storage

None.

## Other Requirements

- Clinic registration and pending-login responses must return the registration reference.
- Provide support contact data or a support URL through configuration/API for the pending screen.
- Onboarding completion is device-local and requires no backend changes.

---

## Feature

Clinic Reports

## Database Changes

- Add a clinic reports table containing clinic ID, report type, range, format, generation status, file path, summary payload, requested/generated timestamps, and failure reason.
- Current database has no persisted report or export-job records.

## New APIs

### List Clinic Reports

- Endpoint: `/api/clinic/reports`
- Method: `GET`
- Query: `page`, optional `type`.
- Response: Unified contract with reports under `data` and pagination under `meta`.

### Generate Clinic Report

- Endpoint: `/api/clinic/reports`
- Method: `POST`
- Request: `type` (`appointments`, `clinic`, `revenue`, `doctors`), `range` (`week`, `month`, `year`), `format` (`pdf`, `excel`).
- Response: Unified contract containing report ID, type, range, format, generated date, summary, and file URL.
- Errors: validation `422`, unauthorized `401`, forbidden `403`, generation business error, server error `500`.

## Validation

- Validate report type, range, and export format enums.
- Limit duplicate report-generation requests and define a generation rate limit.

## Permissions

- Clinics may list and generate only their own reports.
- Report file downloads must use authorized or expiring signed URLs.

## Notifications

- Notify the clinic when an asynchronous report becomes ready or generation fails.

## Filament

- Optional report-job monitoring with clinic, status, requested time, completion time, and failure reason.

## Storage

- Store generated PDF and Excel files outside publicly guessable paths.
- Define retention and automatic deletion policy for generated report files.

## Other Requirements

- Generate large reports through a queue.
- Define precise calculations and included statuses for appointment, clinic, revenue, and doctor reports.
- List pagination metadata must include `current_page`, `from`, `to`, `per_page`, and `total`.

---

## Feature

Add Clinic Doctor

## Database Changes

- Add doctor profile-image storage if the existing doctors table does not support it.
- Add qualification-file persistence linked to the doctor.
- Use the existing doctor schedules table for the submitted seven-day schedule.

## New APIs

### Add Clinic Doctor

- Endpoint: `/api/clinic/doctors`
- Method: `POST`
- Content-Type: `multipart/form-data`
- Request: localized names, `specialization_id`, consultation fee, license number, experience years, biography, phone, email, availability, optional image, qualification PDFs, and JSON schedule.
- Response: `BaseModel<AddedDoctorModel>` containing `doctor_id`, `name_ar`, and `name_en`.

### Get Clinic Doctor Details

- Endpoint: `/api/clinic/doctors/{doctor}`
- Method: `GET`
- Response: `BaseModel<DoctorDetailsModel>` containing identity, specialization, image, availability, experience, fee, currency, phone, license number, email, biography, qualification files, and weekly schedule.

### Update Clinic Doctor

- Endpoint: `/api/clinic/doctors/{doctor}`
- Method: `PUT` (multipart clients may submit `POST` with `_method=PUT`).
- Request: Same fields and multipart rules as Add Clinic Doctor.
- Response: `BaseModel<AddedDoctorModel>` containing the updated doctor identity.

## Validation

- Require unique medical license number and email.
- Validate that the specialization is active and available to the clinic.
- Validate image/PDF MIME types and file-size limits.
- Require all seven unique weekdays; active days require valid `from < to` times.

## Permissions

- Only an authenticated, active, approved clinic may add its own doctors.

## Storage

- Store doctor images and qualification files under stable doctor-specific paths.
- Return absolute media URLs in subsequent doctor responses.

## Other Requirements

- Define whether adding a doctor automatically enables its specialization for the clinic.

---

## Feature

Clinic Appointments List

## Database Changes

- Add an explicit clinic relationship to appointments, including lab appointments that may not have a doctor.
- Add or normalize the service/type source used for consultation, service, and lab-test titles.

## New APIs

### List Clinic Appointments

- Endpoint: `/api/clinic/appointments`
- Method: `GET`
- Query: `page`, optional `search`, optional `status` (`pending`, `approved`, `completed`, or `rejected`).
- Response: `BaseModel<BaseModels<AppointmentModel>>` with appointment ID, patient name/phone/image, title, type, specialization, date/time, status, rejection data, optional result file, and pagination metadata.

### Update Appointment Status

- Endpoint: `/api/clinic/appointments/{appointment}/status`
- Method: `PUT`
- Request: `status`, optional `reject_reason`, optional `reject_note`.
- Response: `BaseModel<AppointmentModel>` containing the updated appointment.

### Upload Lab Result

- Endpoint: `/api/clinic/appointments/{appointment}/result`
- Method: `POST`
- Content-Type: `multipart/form-data`
- Request: PDF under `result`.
- Response: `BaseModel<AppointmentModel>` containing the protected result URL.

## Validation

- Search must match only appointments belonging to the authenticated clinic.
- Normalize appointment status and type values to the Flutter contract.

## Permissions

- Clinics may list only their own appointments.
- Pending, rejected, inactive, or unauthenticated clinics must not access appointment data.

## Storage

- Return protected or expiring URLs for uploaded lab-result files.

## Other Requirements

- Pagination metadata must include `current_page`, `from`, `to`, `per_page`, and `total`.
- Evaluate and return appointment timestamps using the agreed clinic timezone.

---

## Feature

Clinic Settings

## Database Changes

- Store clinic notification settings per clinic: app, email, SMS, appointment reminders, and promotional notifications.
- Define whether data exports are persisted export jobs or generated on demand.
- Add configurable support contact values for email, phone, and WhatsApp.

## New APIs

### Change Clinic Password

- Endpoint: `/api/clinic/change-password`
- Method: `PUT`
- Request: `current_password`, `password`, and `password_confirmation`.
- Response: Unified success contract with no sensitive password data.

### Get Clinic Profile

- Endpoint: `/api/clinic/profile`
- Method: `GET`
- Response: Approved clinic profile containing cover, profile image, name, address, Google Maps URL/coordinates, immutable license number, email, and phone.

### Submit Clinic Profile Update

- Endpoint: `/api/clinic/profile/update-request`
- Method: `POST`
- Content-Type: `multipart/form-data`
- Request: editable profile fields, optional cover/profile images, and Google Maps URL/coordinates. The license number must not be accepted as editable input.
- Response: Unified contract containing the submitted request with `status: pending`.

### Submit Support Report

- Endpoint: `/api/clinic/support-requests`
- Method: `POST`
- Content-Type: `multipart/form-data`
- Request: predefined or custom `subject`, required `description`, and optional `images[]`.
- Response: Unified contract containing the support request ID and `status: pending`.

### Update Notification Settings

- Endpoint: `/api/clinic/notification-settings`
- Method: `PUT`
- Request: `app_notifications`, `email_notifications`, `sms_notifications`, `appointment_reminders`, and `promotional_notifications`.
- Response: Unified contract containing the updated settings.

### Get Notification Settings

- Endpoint: `/api/clinic/notification-settings`
- Method: `GET`
- Response: Unified contract containing boolean notification settings.

### Export Clinic Data

- Endpoint: `/api/clinic/settings/export`
- Method: `GET`
- Response: Unified contract containing `file_url` and `generated_at`.

### Clear Clinic App Cache

- Endpoint: `/api/clinic/settings/cache`
- Method: `DELETE`
- Response: Unified contract containing `cleared: true`.

## Validation

- Verify the current password before applying the update.
- Enforce the backend password-strength policy and confirmation match.
- Notification setting values must be booleans.
- If `app_notifications` is false, reminder/promotional sub-settings should be normalized consistently.
- Revoke other clinic sessions/tokens if required by the security policy.
- Profile update requests must preserve the currently approved profile until an admin approves the request.
- Prevent multiple conflicting pending requests or define replacement/versioning behavior.

## Permissions

- Only the authenticated clinic may change its own password.
- Only the authenticated clinic may read/update notification settings and export or clear cache for its account.
- Only the authenticated clinic may submit its profile update request.
- Only the authenticated clinic may submit and access its own support reports.

## Other Requirements

- Add support contact configuration if contacts are admin-managed.
- Data export files must be protected and expire according to retention policy.
- The Flutter app currently uses API-shaped MockDataSource responses for these settings flows.

- Configure support email and phone values instead of hardcoding them for production.
- Publish approved Help, About, and Privacy Policy content.
- Configure valid Google Maps SDK API keys for Android and iOS deployment environments.
- Add an admin review flow that approves or rejects profile changes atomically and records reviewer, reason, and timestamps.
- Add an admin support inbox with request subject, description, attachments, clinic identity, status, assignee, and timestamps.
