import 'package:clinc_app_clinc/modules/appointments/views/appointments_view.dart';
import 'package:clinc_app_clinc/modules/appointments/bindings/appointments_binding.dart';
import 'package:clinc_app_clinc/modules/services/views/services_view.dart';
import 'package:clinc_app_clinc/modules/services/bindings/services_binding.dart';
import 'package:clinc_app_clinc/modules/doctors/views/doctors_view.dart';
import 'package:clinc_app_clinc/modules/doctors/bindings/doctors_binding.dart';
import 'package:clinc_app_clinc/modules/dashboard/views/dashboard_view.dart';
import 'package:clinc_app_clinc/modules/dashboard/bindings/dashboard_binding.dart';
import 'package:clinc_app_clinc/modules/home/views/home_view.dart';
import 'package:clinc_app_clinc/modules/home/bindings/home_binding.dart';
import 'package:clinc_app_clinc/modules/auth/views/otp_view.dart';
import 'package:clinc_app_clinc/modules/auth/bindings/otp_binding.dart';
import 'package:clinc_app_clinc/modules/auth/views/register_view.dart';
import 'package:clinc_app_clinc/modules/auth/bindings/register_binding.dart';
import 'package:clinc_app_clinc/modules/auth/views/login_view.dart';
import 'package:clinc_app_clinc/modules/auth/bindings/login_binding.dart';
import 'package:clinc_app_clinc/modules/onboarding/views/onboarding_view.dart';
import 'package:clinc_app_clinc/modules/onboarding/bindings/onboarding_binding.dart';
import 'package:clinc_app_clinc/modules/welcome/views/welcome_view.dart';
import 'package:clinc_app_clinc/modules/welcome/bindings/welcome_binding.dart';
import 'package:clinc_app_clinc/modules/splash/views/splash_view.dart';
import 'package:clinc_app_clinc/modules/splash/bindings/splash_binding.dart';
import 'package:get/get.dart';
import '../../modules/add_doctor/bindings/add_doctor_binding.dart';
import '../../modules/add_doctor/views/add_doctor_view.dart';
import '../../modules/appointments/bindings/appointment_details_binding.dart';
import '../../modules/appointments/views/appointment_details_view.dart';
import '../../modules/auth/bindings/forgot_password_binding.dart';
import '../../modules/auth/views/forgot_password_view.dart';
import '../../modules/complete_profile/bindings/complete_profile_binding.dart';
import '../../modules/complete_profile/views/complete_profile_view.dart';
import '../../modules/main_layout/bindings/main_layout_binding.dart';
import '../../modules/main_layout/views/main_layout_view.dart';
import '../../modules/pending_approval/bindings/pending_approval_binding.dart';
import '../../modules/pending_approval/views/pending_approval_view.dart';
import '../../modules/reports/bindings/reports_binding.dart';
import '../../modules/reports/views/reports_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.reports,
      page: () => const ReportsView(),
      binding: ReportsBinding(),
    ),
    GetPage(
      name: AppRoutes.appointmentsDetails,
      page: () => const AppointmentDetailsView(),
      binding: AppointmentDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.appointments,
      page: () => const AppointmentsView(),
      binding: AppointmentsBinding(),
    ),
    GetPage(
      name: AppRoutes.services,
      page: () => const ServicesView(),
      binding: ServicesBinding(),
    ),
    GetPage(
      name: AppRoutes.addDoctor,
      page: () => const AddDoctorView(),
      binding: AddDoctorBinding(),
    ),
    GetPage(
      name: AppRoutes.doctors,
      page: () => const DoctorsView(),
      binding: DoctorsBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.mainLayout,
      page: () => const MainLayoutView(),
      binding: MainLayoutBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.completeProfile,
      page: () => const CompleteProfileView(),
      binding: CompleteProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.pendingApproval,
      page: () => const PendingApprovalView(),
      binding: PendingApprovalBinding(),
    ),
    GetPage(
      name: AppRoutes.otp,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),

    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingView(),
      binding: OnboardingBinding(),
    ),
    GetPage(
      name: AppRoutes.welcome,
      page: () => const WelcomeView(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.initial,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
  ];
}
