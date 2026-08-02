import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/doctors/data/models/clinic_doctor_model.dart';
import '../../features/doctors/domain/doctor_specialty.dart';
import '../../features/doctors/domain/doctor_summary.dart';
import '../../features/doctors/presentation/pages/add_doctor_page.dart';
import '../../features/doctors/presentation/pages/doctor_profile_page.dart';
import '../../features/ads/presentation/pages/create_ad_page.dart';
import '../../features/appointments/presentation/pages/appointments_page.dart';
import '../../features/doctors/presentation/pages/doctors_page.dart';
import '../../features/legal/presentation/pages/about_page.dart';
import '../../features/legal/presentation/pages/contact_page.dart';
import '../../features/legal/presentation/pages/privacy_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import '../../core/services/storage_service.dart';
import 'app_routes.dart';

/// App router. Routes are declared here and reference [AppRoutes] constants.
class AppRouter {
  const AppRouter._();

  static final rootNavigatorKey = GlobalKey<NavigatorState>();
  static final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  static final GoRouter router = GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: StorageService.instance.getAccessToken().isNotEmpty
        ? AppRoutes.home
        : AppRoutes.onboarding,
    routes: [
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingPage(),
      ),
      GoRoute(
        path: AppRoutes.auth,
        builder: (context, state) => const AuthPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: AppRoutes.doctors,
        builder: (context, state) => const DoctorsPage(),
      ),
      GoRoute(
        path: AppRoutes.addDoctor,
        builder: (context, state) =>
            AddDoctorPage(initialDoctor: state.extra as ClinicDoctorModel?),
      ),
      GoRoute(
        path: AppRoutes.doctorProfile,
        builder: (context, state) {
          final extra = state.extra;
          final clinicDoctor = extra is ClinicDoctorModel ? extra : null;
          final doctor = extra is DoctorSummary
              ? extra
              : clinicDoctor == null
              ? null
              : _doctorSummary(clinicDoctor);
          if (doctor == null) return const DoctorsPage();
          return DoctorProfilePage(doctor: doctor, initialDoctor: clinicDoctor);
        },
      ),
      GoRoute(
        path: AppRoutes.notifications,
        builder: (context, state) => const NotificationsPage(),
      ),
      GoRoute(
        path: AppRoutes.appointments,
        builder: (context, state) => const AppointmentsPage(),
      ),
      GoRoute(
        path: AppRoutes.services,
        builder: (context, state) => const ServicesPage(),
      ),
      GoRoute(
        path: AppRoutes.reports,
        builder: (context, state) => const ReportsPage(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsPage(),
      ),
      GoRoute(
        path: AppRoutes.createAd,
        builder: (context, state) => const CreateAdPage(),
      ),
      GoRoute(
        path: AppRoutes.about,
        builder: (context, state) => const AboutPage(),
      ),
      GoRoute(
        path: AppRoutes.privacy,
        builder: (context, state) => const PrivacyPage(),
      ),
      GoRoute(
        path: AppRoutes.contact,
        builder: (context, state) => const ContactPage(),
      ),
    ],
  );

  static DoctorSummary _doctorSummary(ClinicDoctorModel doctor) {
    final name = doctor.name ?? doctor.nameAr ?? doctor.nameEn ?? '-';
    return DoctorSummary(
      id: int.tryParse(doctor.doctorId ?? '') ?? 0,
      name: name,
      initials: name.characters.isEmpty ? '-' : name.characters.first,
      specialty: DoctorSpecialty.all,
      specialtyName: doctor.specializationName ?? '-',
      experienceYears: doctor.experienceYears,
      fee: doctor.consultationFee.round(),
      imageUrl: doctor.imageUrl,
      rating: doctor.rating.toDouble(),
      patients: doctor.patientsCount,
      doctorId: doctor.doctorId,
    );
  }
}
