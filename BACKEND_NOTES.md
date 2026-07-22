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

## Missing Clinic APIs
- Clinic profile/details endpoint: MISSING BACKEND ENDPOINT.
- Clinic profile update endpoint: MISSING BACKEND ENDPOINT.
- Clinic password change endpoint: MISSING BACKEND ENDPOINT.
- Clinic notification preferences endpoint: MISSING BACKEND ENDPOINT.
- Clinic appointments list endpoint: MISSING BACKEND ENDPOINT.
- Clinic appointment details endpoint: MISSING BACKEND ENDPOINT.
- Clinic appointment accept endpoint: MISSING BACKEND ENDPOINT.
- Clinic appointment reject endpoint: MISSING BACKEND ENDPOINT.
- Clinic appointment finish endpoint: MISSING BACKEND ENDPOINT.
- Clinic upload lab result endpoint: MISSING BACKEND ENDPOINT.
- Clinic notifications list endpoint: MISSING BACKEND ENDPOINT.
- Clinic notification read endpoint: MISSING BACKEND ENDPOINT.
- Clinic notifications mark all read endpoint: MISSING BACKEND ENDPOINT.
- Clinic notifications delete endpoint: MISSING BACKEND ENDPOINT.
- Clinic device token registration endpoint: MISSING BACKEND ENDPOINT.
- Clinic lab sections endpoint: MISSING BACKEND ENDPOINT.
- Clinic lab tests endpoint: MISSING BACKEND ENDPOINT.
- Clinic service enable/disable endpoint: MISSING BACKEND ENDPOINT.
- Clinic service price update endpoint: MISSING BACKEND ENDPOINT.
- Clinic reports summary endpoint: MISSING BACKEND ENDPOINT.
- Clinic reports export endpoint: MISSING BACKEND ENDPOINT.
- Clinic generated reports list endpoint: MISSING BACKEND ENDPOINT.

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
