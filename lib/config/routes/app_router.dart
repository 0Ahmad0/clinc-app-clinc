import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/pages/auth_page.dart';
import '../../features/home/presentation/pages/home_page.dart';
import '../../features/doctors/domain/doctor_summary.dart';
import '../../features/doctors/presentation/pages/add_doctor_page.dart';
import '../../features/doctors/presentation/pages/doctor_profile_page.dart';
import '../../features/appointments/presentation/pages/appointments_page.dart';
import '../../features/doctors/presentation/pages/doctors_page.dart';
import '../../features/notifications/presentation/pages/notifications_page.dart';
import '../../features/onboarding/presentation/pages/onboarding_page.dart';
import '../../features/reports/presentation/pages/reports_page.dart';
import '../../features/services/presentation/pages/services_page.dart';
import '../../features/settings/presentation/pages/settings_page.dart';
import 'app_routes.dart';

/// App router. Routes are declared here and reference [AppRoutes] constants.
class AppRouter {
  const AppRouter._();

  static final GoRouter router = GoRouter(
    initialLocation: AppRoutes.onboarding,
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
        builder: (context, state) => const AddDoctorPage(),
      ),
      GoRoute(
        path: AppRoutes.doctorProfile,
        builder: (context, state) {
          final doctor = state.extra as DoctorSummary?;
          if (doctor == null) return const DoctorsPage();
          return DoctorProfilePage(doctor: doctor);
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
    ],
  );
}
