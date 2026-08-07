import 'package:flutter/widgets.dart';

/// 4px spacing scale. Never write raw padding/gap numbers in the UI.
class AppSpacing {
  const AppSpacing._();

  static const double xxs = 4;
  static const double xs = 8;
  static const double sm = 12;
  static const double md = 16;
  static const double lg = 24;
  static const double xl = 32;
  static const double xxl = 48;

  /// Screen horizontal margin (design: 22).
  static const double screen = 22;
}

/// Corner radii.
class AppRadius {
  const AppRadius._();

  static const double sm = 12;
  static const double field = 16;
  static const double button = 18;
  static const double card = 24;
  static const double sheet = 28;
  static const double art = 44;
  static const double pill = 999;
  static const double homeHeader = 34;
  static const double homeQuickAction = 20;
}

/// Named component sizes (hit targets, buttons, illustration art).
class AppSizes {
  const AppSizes._();

  static const double hitTarget = 44;
  static const double buttonHeight = 56;
  static const double buttonHeightSm = 52;
  static const double iconBox = 40;
  static const double logoSm = 42;

  // Home dashboard
  static const double homeHeaderHeight = 274;
  static const double homeTopHeight = 308;
  static const double homeHeaderAction = 38;
  static const double homeBrandBox = 56;
  static const double homeBrandLogo = 38;
  static const double homeQuickActionHeight = 60;
  static const double homeStatIcon = 34;
  static const double homeAppointmentAvatar = 46;
  static const double homeSectionMarkerWidth = 4;
  static const double homeSectionMarkerHeight = 18;
  static const double homeChartHeight = 54;
  static const double homeBottomClearance = 112;
  static const double homeHeaderCircleSmall = 260;
  static const double homeHeaderCircleLarge = 300;
  static const double homeHeaderCircleTop = 90;
  static const double homeHeaderCircleStart = 70;
  static const double homeHeaderCircleBottom = 110;
  static const double homeHeaderCircleEnd = 80;
  static const double homeStatusDot = 9;
  static const double homePatientCountText = 34;
  static const double homeMetricCountText = 26;
  static const double iconXs = 14;
  static const double iconSm = 18;
  static const double iconMd = 20;
  static const double iconLg = 24;

  // Doctors
  static const double doctorsHeaderIcon = 48;
  static const double doctorAvatar = 54;
  static const double availabilitySwitchWidth = 46;
  static const double availabilitySwitchHeight = 26;
  static const double availabilityKnob = 20;
  static const double doctorsFabBottom = 112;
  static const double searchBarHeight = 52;
  static const double doctorsHeaderCircle = 230;
  static const double doctorsHeaderCircleTop = 80;
  static const double doctorsHeaderCircleEnd = 60;
  static const double doctorsHeaderContent = 128;
  static const double filterChipIcon = 16;

  // Add doctor
  static const double addDoctorAvatar = 96;
  static const double addDoctorAvatarBadge = 32;
  static const double addDoctorFieldHeight = 50;
  static const double addDoctorSectionIcon = 38;
  static const double addDoctorUploadHeight = 112;

  // Ads
  static const double adCoverHeight = 180;
  static const double adSuccessBadge = 96;

  // Bottom sheets
  static const double sheetHandleWidth = 44;
  static const double sheetHandleHeight = 5;

  // Appointments
  static const double appointmentAvatar = 50;
  static const double appointmentDetailAvatar = 86;
  static const double detailRowIcon = 34;

  // Services
  static const double servicesGridIcon = 50;
  static const double servicesCardMinHeight = 150;
  static const double servicesAddCircle = 52;
  static const double servicesCodeChipWidth = 44;

  // Reports
  static const double reportsStatIcon = 38;
  static const double reportsChartHeight = 150;
  static const double reportsBarWidthWeek = 9;
  static const double reportsBarWidthMonth = 16;
  static const double reportsEntryIcon = 44;
  static const double reportsProgressBar = 8;
  static const double reportsLegendDot = 8;

  // Settings
  static const double settingsAvatar = 88;
  static const double settingsAvatarBadge = 30;
  static const double settingsProfileAvatar = 92;
  static const double settingsCoverHeight = 175;
  static const double settingsPasswordHero = 72;
  static const double settingsLogo = 44;

  // Auth hero artwork
  static const double authPendingBadge = 150;
  static const double authPendingShape = 122;
  static const double authPendingRing = 150;
  static const double authPendingIcon = 52;

  // Onboarding illustration
  static const double onboardingArt = 330;
  static const double onboardingCircle = 216;
  static const double chipIconBox = 30;
  static const double dotHeight = 10;
  static const double dotActiveWidth = 34;
}

/// Ready-made [SizedBox] gaps.
class AppGaps {
  const AppGaps._();

  static const w6 = SizedBox(width: AppSpacing.xxs);
  static const w8 = SizedBox(width: AppSpacing.xs);
  static const w12 = SizedBox(width: AppSpacing.sm);
  static const h8 = SizedBox(height: AppSpacing.xs);
  static const h12 = SizedBox(height: AppSpacing.sm);
  static const h16 = SizedBox(height: AppSpacing.md);
  static const h24 = SizedBox(height: AppSpacing.lg);
}

/// Page-level paddings.
class AppInsets {
  const AppInsets._();

  static const screenH = EdgeInsetsDirectional.symmetric(
    horizontal: AppSpacing.lg,
  );
}
