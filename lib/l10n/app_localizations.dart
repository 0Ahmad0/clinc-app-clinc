import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @appBrand.
  ///
  /// In en, this message translates to:
  /// **'Eyadaty'**
  String get appBrand;

  /// No description provided for @onboardingSkip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get onboardingStart;

  /// No description provided for @onb1Kicker.
  ///
  /// In en, this message translates to:
  /// **'FOR CLINICS'**
  String get onb1Kicker;

  /// No description provided for @onb1Title.
  ///
  /// In en, this message translates to:
  /// **'Manage appointments smartly'**
  String get onb1Title;

  /// No description provided for @onb1Desc.
  ///
  /// In en, this message translates to:
  /// **'Organize patient schedules, cut waiting time, and boost your clinic\'s efficiency in one tap.'**
  String get onb1Desc;

  /// No description provided for @onb1ChipTitle.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get onb1ChipTitle;

  /// No description provided for @onb1ChipSub.
  ///
  /// In en, this message translates to:
  /// **'Dr. Sara — 4:30 pm'**
  String get onb1ChipSub;

  /// No description provided for @onb2Kicker.
  ///
  /// In en, this message translates to:
  /// **'FOR PATIENTS'**
  String get onb2Kicker;

  /// No description provided for @onb2Title.
  ///
  /// In en, this message translates to:
  /// **'Book your visit in seconds'**
  String get onb2Title;

  /// No description provided for @onb2Desc.
  ///
  /// In en, this message translates to:
  /// **'Pick the right doctor and time, and confirm your booking easily — all in one place.'**
  String get onb2Desc;

  /// No description provided for @onb2ChipTitle.
  ///
  /// In en, this message translates to:
  /// **'Instant booking'**
  String get onb2ChipTitle;

  /// No description provided for @onb2ChipSub.
  ///
  /// In en, this message translates to:
  /// **'Earliest slot today'**
  String get onb2ChipSub;

  /// No description provided for @onb3Kicker.
  ///
  /// In en, this message translates to:
  /// **'YOUR HEALTH FILE'**
  String get onb3Kicker;

  /// No description provided for @onb3Title.
  ///
  /// In en, this message translates to:
  /// **'Your medical file, anywhere'**
  String get onb3Title;

  /// No description provided for @onb3Desc.
  ///
  /// In en, this message translates to:
  /// **'Reports, prescriptions and lab results stored safely and available anytime.'**
  String get onb3Desc;

  /// No description provided for @onb3ChipTitle.
  ///
  /// In en, this message translates to:
  /// **'Securely stored'**
  String get onb3ChipTitle;

  /// No description provided for @onb3ChipSub.
  ///
  /// In en, this message translates to:
  /// **'Fully encrypted'**
  String get onb3ChipSub;

  /// No description provided for @authLoginTitle.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authLoginTitle;

  /// No description provided for @authLoginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome back, we wish you a productive day'**
  String get authLoginSubtitle;

  /// No description provided for @authIdentifierHint.
  ///
  /// In en, this message translates to:
  /// **'Email or license number'**
  String get authIdentifierHint;

  /// No description provided for @authPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordHint;

  /// No description provided for @authForgotLink.
  ///
  /// In en, this message translates to:
  /// **'Forgot your password?'**
  String get authForgotLink;

  /// No description provided for @authLoginCta.
  ///
  /// In en, this message translates to:
  /// **'Log in'**
  String get authLoginCta;

  /// No description provided for @authGuestCta.
  ///
  /// In en, this message translates to:
  /// **'Browse as guest'**
  String get authGuestCta;

  /// No description provided for @authNoAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authNoAccount;

  /// No description provided for @authCreateAccount.
  ///
  /// In en, this message translates to:
  /// **'Create new account'**
  String get authCreateAccount;

  /// No description provided for @authSignupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get authSignupTitle;

  /// No description provided for @authSignupSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Create your medical facility account'**
  String get authSignupSubtitle;

  /// No description provided for @authAccountTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Account type'**
  String get authAccountTypeLabel;

  /// No description provided for @authTypeClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic'**
  String get authTypeClinic;

  /// No description provided for @authTypeClinicSub.
  ///
  /// In en, this message translates to:
  /// **'Medical clinic'**
  String get authTypeClinicSub;

  /// No description provided for @authTypeLab.
  ///
  /// In en, this message translates to:
  /// **'Lab'**
  String get authTypeLab;

  /// No description provided for @authTypeLabSub.
  ///
  /// In en, this message translates to:
  /// **'Medical lab'**
  String get authTypeLabSub;

  /// No description provided for @authTypeBoth.
  ///
  /// In en, this message translates to:
  /// **'Clinic + Lab'**
  String get authTypeBoth;

  /// No description provided for @authTypeBothSub.
  ///
  /// In en, this message translates to:
  /// **'Full facility'**
  String get authTypeBothSub;

  /// No description provided for @authFacilityClinic.
  ///
  /// In en, this message translates to:
  /// **'Clinic information'**
  String get authFacilityClinic;

  /// No description provided for @authFacilityLab.
  ///
  /// In en, this message translates to:
  /// **'Lab information'**
  String get authFacilityLab;

  /// No description provided for @authFacilityBoth.
  ///
  /// In en, this message translates to:
  /// **'Facility information'**
  String get authFacilityBoth;

  /// No description provided for @authFacilityHintClinic.
  ///
  /// In en, this message translates to:
  /// **'e.g. Al-Shifa Clinic'**
  String get authFacilityHintClinic;

  /// No description provided for @authFacilityHintLab.
  ///
  /// In en, this message translates to:
  /// **'e.g. Al-Amal Lab'**
  String get authFacilityHintLab;

  /// No description provided for @authFacilityHintBoth.
  ///
  /// In en, this message translates to:
  /// **'e.g. Al-Shifa Medical Complex'**
  String get authFacilityHintBoth;

  /// No description provided for @authLicenseHint.
  ///
  /// In en, this message translates to:
  /// **'Approved license number'**
  String get authLicenseHint;

  /// No description provided for @authEmailHint.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailHint;

  /// No description provided for @authConfirmPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get authConfirmPasswordHint;

  /// No description provided for @authSignupCta.
  ///
  /// In en, this message translates to:
  /// **'Submit for review'**
  String get authSignupCta;

  /// No description provided for @authTermsPrefix.
  ///
  /// In en, this message translates to:
  /// **'By signing up you agree to '**
  String get authTermsPrefix;

  /// No description provided for @authTermsLink.
  ///
  /// In en, this message translates to:
  /// **'the Terms & Conditions'**
  String get authTermsLink;

  /// No description provided for @authTermsSuffix.
  ///
  /// In en, this message translates to:
  /// **' and the Privacy Policy'**
  String get authTermsSuffix;

  /// No description provided for @authHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authHaveAccount;

  /// No description provided for @authSignin.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignin;

  /// No description provided for @authForgotTitle.
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotTitle;

  /// No description provided for @authForgotDesc.
  ///
  /// In en, this message translates to:
  /// **'Don\'t worry! It happens. Enter the email or license number linked to your account.'**
  String get authForgotDesc;

  /// No description provided for @authForgotInfo.
  ///
  /// In en, this message translates to:
  /// **'We\'ll send a password reset link to your email or phone number'**
  String get authForgotInfo;

  /// No description provided for @authForgotFieldHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. info@clinic.com'**
  String get authForgotFieldHint;

  /// No description provided for @authForgotCta.
  ///
  /// In en, this message translates to:
  /// **'Send verification code'**
  String get authForgotCta;

  /// No description provided for @authBackToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to sign in'**
  String get authBackToLogin;

  /// No description provided for @authOtpTitle.
  ///
  /// In en, this message translates to:
  /// **'Verification code'**
  String get authOtpTitle;

  /// No description provided for @authOtpDesc.
  ///
  /// In en, this message translates to:
  /// **'We sent a {count}-digit code to your email'**
  String authOtpDesc(int count);

  /// No description provided for @authOtpCta.
  ///
  /// In en, this message translates to:
  /// **'Confirm code'**
  String get authOtpCta;

  /// No description provided for @authOtpNoCode.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t get the code?'**
  String get authOtpNoCode;

  /// No description provided for @authOtpResend.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get authOtpResend;

  /// No description provided for @authOtpResendIn.
  ///
  /// In en, this message translates to:
  /// **'Resend in {seconds}s'**
  String authOtpResendIn(int seconds);

  /// No description provided for @authOtpResent.
  ///
  /// In en, this message translates to:
  /// **'We sent you a new code'**
  String get authOtpResent;

  /// No description provided for @authResetTitle.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authResetTitle;

  /// No description provided for @authResetDesc.
  ///
  /// In en, this message translates to:
  /// **'It must differ from your previous password and be at least {count} characters'**
  String authResetDesc(int count);

  /// No description provided for @authResetNewHint.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authResetNewHint;

  /// No description provided for @authResetCta.
  ///
  /// In en, this message translates to:
  /// **'Save password'**
  String get authResetCta;

  /// No description provided for @authResetDone.
  ///
  /// In en, this message translates to:
  /// **'Your password has been updated'**
  String get authResetDone;

  /// No description provided for @authPendingTitle.
  ///
  /// In en, this message translates to:
  /// **'Your request is under review'**
  String get authPendingTitle;

  /// No description provided for @authPendingDesc.
  ///
  /// In en, this message translates to:
  /// **'Your facility registration request has been sent to the platform admin. You\'ll be notified once your account is approved — usually within 24 hours.'**
  String get authPendingDesc;

  /// No description provided for @authStep1Title.
  ///
  /// In en, this message translates to:
  /// **'Request sent'**
  String get authStep1Title;

  /// No description provided for @authStep1Sub.
  ///
  /// In en, this message translates to:
  /// **'Your request reached the admin'**
  String get authStep1Sub;

  /// No description provided for @authStep2Title.
  ///
  /// In en, this message translates to:
  /// **'Review & verification'**
  String get authStep2Title;

  /// No description provided for @authStep2Sub.
  ///
  /// In en, this message translates to:
  /// **'Verifying the license number'**
  String get authStep2Sub;

  /// No description provided for @authStep3Title.
  ///
  /// In en, this message translates to:
  /// **'Account activation'**
  String get authStep3Title;

  /// No description provided for @authStep3Sub.
  ///
  /// In en, this message translates to:
  /// **'You\'ll get a confirmation message'**
  String get authStep3Sub;

  /// No description provided for @validationRequired.
  ///
  /// In en, this message translates to:
  /// **'This field is required'**
  String get validationRequired;

  /// No description provided for @validationEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address'**
  String get validationEmail;

  /// No description provided for @validationPasswordLength.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 8 characters'**
  String get validationPasswordLength;

  /// No description provided for @validationPasswordMismatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get validationPasswordMismatch;

  /// No description provided for @homeDashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get homeDashboard;

  /// No description provided for @homeClinicName.
  ///
  /// In en, this message translates to:
  /// **'Al-Shifa Clinic'**
  String get homeClinicName;

  /// No description provided for @homeDate.
  ///
  /// In en, this message translates to:
  /// **'Saturday, July 18'**
  String get homeDate;

  /// No description provided for @homeOpenStatus.
  ///
  /// In en, this message translates to:
  /// **'Clinic open — 8:00 am to 8:00 pm'**
  String get homeOpenStatus;

  /// No description provided for @homeNewAppointment.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get homeNewAppointment;

  /// No description provided for @homeDoctors.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get homeDoctors;

  /// No description provided for @homeServices.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get homeServices;

  /// No description provided for @homeReports.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get homeReports;

  /// No description provided for @homeStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinic statistics'**
  String get homeStatsTitle;

  /// No description provided for @homePatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get homePatients;

  /// No description provided for @homePatientsCount.
  ///
  /// In en, this message translates to:
  /// **'248'**
  String get homePatientsCount;

  /// No description provided for @homeWeeklyGrowth.
  ///
  /// In en, this message translates to:
  /// **'+18 this week ↑'**
  String get homeWeeklyGrowth;

  /// No description provided for @homeDoctorsCount.
  ///
  /// In en, this message translates to:
  /// **'12'**
  String get homeDoctorsCount;

  /// No description provided for @homeDoctorsGrowth.
  ///
  /// In en, this message translates to:
  /// **'+2 this month'**
  String get homeDoctorsGrowth;

  /// No description provided for @homeIncomeCount.
  ///
  /// In en, this message translates to:
  /// **'3450'**
  String get homeIncomeCount;

  /// No description provided for @homeCurrency.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get homeCurrency;

  /// No description provided for @homeDailyIncome.
  ///
  /// In en, this message translates to:
  /// **'Daily income'**
  String get homeDailyIncome;

  /// No description provided for @homeAppointmentsCount.
  ///
  /// In en, this message translates to:
  /// **'8'**
  String get homeAppointmentsCount;

  /// No description provided for @homeTodayAppointments.
  ///
  /// In en, this message translates to:
  /// **'Today\'s appointments'**
  String get homeTodayAppointments;

  /// No description provided for @homeUpcomingCount.
  ///
  /// In en, this message translates to:
  /// **'5 upcoming'**
  String get homeUpcomingCount;

  /// No description provided for @homeViewAll.
  ///
  /// In en, this message translates to:
  /// **'View all'**
  String get homeViewAll;

  /// No description provided for @homeNavHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get homeNavHome;

  /// No description provided for @homeNavCalendar.
  ///
  /// In en, this message translates to:
  /// **'Calendar'**
  String get homeNavCalendar;

  /// No description provided for @homeAppointment1Name.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Mohammed Al-Sayed'**
  String get homeAppointment1Name;

  /// No description provided for @homeAppointment1Service.
  ///
  /// In en, this message translates to:
  /// **'Cardiology consultation'**
  String get homeAppointment1Service;

  /// No description provided for @homeAppointment1Time.
  ///
  /// In en, this message translates to:
  /// **'9:00 am'**
  String get homeAppointment1Time;

  /// No description provided for @homeAppointment2Name.
  ///
  /// In en, this message translates to:
  /// **'Fatimah Ali Al-Zahrani'**
  String get homeAppointment2Name;

  /// No description provided for @homeAppointment2Service.
  ///
  /// In en, this message translates to:
  /// **'Complete blood test'**
  String get homeAppointment2Service;

  /// No description provided for @homeAppointment2Time.
  ///
  /// In en, this message translates to:
  /// **'10:30 am'**
  String get homeAppointment2Time;

  /// No description provided for @homeAppointment3Name.
  ///
  /// In en, this message translates to:
  /// **'Mohammed Abdullah Al-Ghamdi'**
  String get homeAppointment3Name;

  /// No description provided for @homeAppointment3Service.
  ///
  /// In en, this message translates to:
  /// **'Eye examination'**
  String get homeAppointment3Service;

  /// No description provided for @homeAppointment3Time.
  ///
  /// In en, this message translates to:
  /// **'12:00 pm'**
  String get homeAppointment3Time;

  /// No description provided for @homeAppointment4Name.
  ///
  /// In en, this message translates to:
  /// **'Noura Salman Al-Qahtani'**
  String get homeAppointment4Name;

  /// No description provided for @homeAppointment4Service.
  ///
  /// In en, this message translates to:
  /// **'General consultation'**
  String get homeAppointment4Service;

  /// No description provided for @homeAppointment4Time.
  ///
  /// In en, this message translates to:
  /// **'2:00 pm'**
  String get homeAppointment4Time;

  /// No description provided for @homeAppointment5Name.
  ///
  /// In en, this message translates to:
  /// **'Abdulrahman Khaled Al-Otaibi'**
  String get homeAppointment5Name;

  /// No description provided for @homeAppointment5Service.
  ///
  /// In en, this message translates to:
  /// **'X-ray'**
  String get homeAppointment5Service;

  /// No description provided for @homeAppointment5Time.
  ///
  /// In en, this message translates to:
  /// **'4:00 pm'**
  String get homeAppointment5Time;

  /// No description provided for @homeAppointmentUpcoming.
  ///
  /// In en, this message translates to:
  /// **'Upcoming'**
  String get homeAppointmentUpcoming;

  /// No description provided for @homeAppointmentDone.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get homeAppointmentDone;

  /// No description provided for @homeAppointmentCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get homeAppointmentCancelled;

  /// No description provided for @doctorsTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctors'**
  String get doctorsTitle;

  /// No description provided for @doctorsHeaderLine.
  ///
  /// In en, this message translates to:
  /// **'{total} doctors • {available} available'**
  String doctorsHeaderLine(String total, String available);

  /// No description provided for @doctorsTotal.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get doctorsTotal;

  /// No description provided for @doctorsUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get doctorsUnavailable;

  /// No description provided for @doctorsSearchHint.
  ///
  /// In en, this message translates to:
  /// **'Search by doctor or specialty...'**
  String get doctorsSearchHint;

  /// No description provided for @doctorsAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get doctorsAll;

  /// No description provided for @specialtyCardiology.
  ///
  /// In en, this message translates to:
  /// **'Cardiology'**
  String get specialtyCardiology;

  /// No description provided for @specialtyDermatology.
  ///
  /// In en, this message translates to:
  /// **'Dermatology & cosmetics'**
  String get specialtyDermatology;

  /// No description provided for @specialtyPediatrics.
  ///
  /// In en, this message translates to:
  /// **'Pediatrics'**
  String get specialtyPediatrics;

  /// No description provided for @specialtyOphthalmology.
  ///
  /// In en, this message translates to:
  /// **'Ophthalmology'**
  String get specialtyOphthalmology;

  /// No description provided for @specialtyDentistry.
  ///
  /// In en, this message translates to:
  /// **'Dentistry'**
  String get specialtyDentistry;

  /// No description provided for @doctor1Name.
  ///
  /// In en, this message translates to:
  /// **'Dr. Ahmed Mohammed Ali'**
  String get doctor1Name;

  /// No description provided for @doctor2Name.
  ///
  /// In en, this message translates to:
  /// **'Dr. Sarah Hassan'**
  String get doctor2Name;

  /// No description provided for @doctor3Name.
  ///
  /// In en, this message translates to:
  /// **'Dr. Khaled Al-Omari'**
  String get doctor3Name;

  /// No description provided for @doctor4Name.
  ///
  /// In en, this message translates to:
  /// **'Dr. Laila Youssef'**
  String get doctor4Name;

  /// No description provided for @doctor5Name.
  ///
  /// In en, this message translates to:
  /// **'Dr. Mohammed Al-Harbi'**
  String get doctor5Name;

  /// No description provided for @doctorAvailable.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get doctorAvailable;

  /// No description provided for @doctorUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get doctorUnavailable;

  /// No description provided for @doctorExperience.
  ///
  /// In en, this message translates to:
  /// **'{years} years'**
  String doctorExperience(String years);

  /// No description provided for @doctorFee.
  ///
  /// In en, this message translates to:
  /// **'SAR {amount}'**
  String doctorFee(String amount);

  /// No description provided for @doctorsNoResults.
  ///
  /// In en, this message translates to:
  /// **'No matching results'**
  String get doctorsNoResults;

  /// No description provided for @doctorsAdd.
  ///
  /// In en, this message translates to:
  /// **'Add doctor'**
  String get doctorsAdd;

  /// No description provided for @specialtyOrthopedics.
  ///
  /// In en, this message translates to:
  /// **'Orthopedics'**
  String get specialtyOrthopedics;

  /// No description provided for @specialtyInternal.
  ///
  /// In en, this message translates to:
  /// **'Internal medicine'**
  String get specialtyInternal;

  /// No description provided for @doctorProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Doctor profile'**
  String get doctorProfileTitle;

  /// No description provided for @doctorProfileYearsExp.
  ///
  /// In en, this message translates to:
  /// **'Years exp.'**
  String get doctorProfileYearsExp;

  /// No description provided for @doctorProfilePatients.
  ///
  /// In en, this message translates to:
  /// **'Patients'**
  String get doctorProfilePatients;

  /// No description provided for @doctorProfileRating.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get doctorProfileRating;

  /// No description provided for @doctorProfileAvailTitle.
  ///
  /// In en, this message translates to:
  /// **'Availability'**
  String get doctorProfileAvailTitle;

  /// No description provided for @doctorProfileAvailOn.
  ///
  /// In en, this message translates to:
  /// **'Accepting new bookings now'**
  String get doctorProfileAvailOn;

  /// No description provided for @doctorProfileAvailOff.
  ///
  /// In en, this message translates to:
  /// **'Not accepting bookings'**
  String get doctorProfileAvailOff;

  /// No description provided for @doctorProfileAbout.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get doctorProfileAbout;

  /// No description provided for @doctorProfileAboutBody.
  ///
  /// In en, this message translates to:
  /// **'A seasoned consultant with fellowships and accredited certifications, delivering precise, patient-focused care.'**
  String get doctorProfileAboutBody;

  /// No description provided for @doctorProfileSchedule.
  ///
  /// In en, this message translates to:
  /// **'Working days'**
  String get doctorProfileSchedule;

  /// No description provided for @doctorProfileHours.
  ///
  /// In en, this message translates to:
  /// **'4:00 pm to 9:00 pm — 20 min per visit'**
  String get doctorProfileHours;

  /// No description provided for @doctorProfileServices.
  ///
  /// In en, this message translates to:
  /// **'Services & fees'**
  String get doctorProfileServices;

  /// No description provided for @doctorProfileService1.
  ///
  /// In en, this message translates to:
  /// **'Clinic visit'**
  String get doctorProfileService1;

  /// No description provided for @doctorProfileService2.
  ///
  /// In en, this message translates to:
  /// **'Follow-up consultation'**
  String get doctorProfileService2;

  /// No description provided for @doctorProfileService3.
  ///
  /// In en, this message translates to:
  /// **'ECG'**
  String get doctorProfileService3;

  /// No description provided for @doctorProfileBook.
  ///
  /// In en, this message translates to:
  /// **'Doctor appointments'**
  String get doctorProfileBook;

  /// No description provided for @addDoctorTitle.
  ///
  /// In en, this message translates to:
  /// **'Add new doctor'**
  String get addDoctorTitle;

  /// No description provided for @addDoctorSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter the doctor\'s full details'**
  String get addDoctorSubtitle;

  /// No description provided for @addDoctorBasicSection.
  ///
  /// In en, this message translates to:
  /// **'Basic information'**
  String get addDoctorBasicSection;

  /// No description provided for @addDoctorNameAr.
  ///
  /// In en, this message translates to:
  /// **'Name (Arabic)'**
  String get addDoctorNameAr;

  /// No description provided for @addDoctorNameEn.
  ///
  /// In en, this message translates to:
  /// **'Name (English)'**
  String get addDoctorNameEn;

  /// No description provided for @addDoctorSpecialtyPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Specialty'**
  String get addDoctorSpecialtyPlaceholder;

  /// No description provided for @addDoctorFee.
  ///
  /// In en, this message translates to:
  /// **'Consultation fee (SAR)'**
  String get addDoctorFee;

  /// No description provided for @addDoctorPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get addDoctorPhone;

  /// No description provided for @addDoctorEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get addDoctorEmail;

  /// No description provided for @addDoctorProSection.
  ///
  /// In en, this message translates to:
  /// **'Professional information'**
  String get addDoctorProSection;

  /// No description provided for @addDoctorLicense.
  ///
  /// In en, this message translates to:
  /// **'Medical license number'**
  String get addDoctorLicense;

  /// No description provided for @addDoctorExperienceHint.
  ///
  /// In en, this message translates to:
  /// **'Years of experience'**
  String get addDoctorExperienceHint;

  /// No description provided for @addDoctorBio.
  ///
  /// In en, this message translates to:
  /// **'About the doctor'**
  String get addDoctorBio;

  /// No description provided for @addDoctorQualSection.
  ///
  /// In en, this message translates to:
  /// **'Qualifications (PDF)'**
  String get addDoctorQualSection;

  /// No description provided for @addDoctorUploadTitle.
  ///
  /// In en, this message translates to:
  /// **'Upload files'**
  String get addDoctorUploadTitle;

  /// No description provided for @addDoctorUploadHint.
  ///
  /// In en, this message translates to:
  /// **'PDF only'**
  String get addDoctorUploadHint;

  /// No description provided for @addDoctorScheduleSection.
  ///
  /// In en, this message translates to:
  /// **'Weekly schedule'**
  String get addDoctorScheduleSection;

  /// No description provided for @addDoctorDayOff.
  ///
  /// In en, this message translates to:
  /// **'Day off'**
  String get addDoctorDayOff;

  /// No description provided for @addDoctorFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get addDoctorFrom;

  /// No description provided for @addDoctorTo.
  ///
  /// In en, this message translates to:
  /// **'To'**
  String get addDoctorTo;

  /// No description provided for @addDoctorDefaultStart.
  ///
  /// In en, this message translates to:
  /// **'9:00 am'**
  String get addDoctorDefaultStart;

  /// No description provided for @addDoctorDefaultEnd.
  ///
  /// In en, this message translates to:
  /// **'5:00 pm'**
  String get addDoctorDefaultEnd;

  /// No description provided for @addDoctorSave.
  ///
  /// In en, this message translates to:
  /// **'Save data'**
  String get addDoctorSave;

  /// No description provided for @weekdaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get weekdaySaturday;

  /// No description provided for @weekdaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get weekdaySunday;

  /// No description provided for @weekdayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get weekdayMonday;

  /// No description provided for @weekdayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get weekdayTuesday;

  /// No description provided for @weekdayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get weekdayWednesday;

  /// No description provided for @weekdayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get weekdayThursday;

  /// No description provided for @weekdayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get weekdayFriday;

  /// No description provided for @notifTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifTitle;

  /// No description provided for @notifUnreadLine.
  ///
  /// In en, this message translates to:
  /// **'{count} unread'**
  String notifUnreadLine(String count);

  /// No description provided for @notifAllRead.
  ///
  /// In en, this message translates to:
  /// **'All notifications read'**
  String get notifAllRead;

  /// No description provided for @notifTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get notifTabAll;

  /// No description provided for @notifTabUnread.
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get notifTabUnread;

  /// No description provided for @notifTabRead.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get notifTabRead;

  /// No description provided for @notifMarkAllRead.
  ///
  /// In en, this message translates to:
  /// **'Mark all as read'**
  String get notifMarkAllRead;

  /// No description provided for @notifClearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get notifClearAll;

  /// No description provided for @notifNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get notifNew;

  /// No description provided for @notifEmpty.
  ///
  /// In en, this message translates to:
  /// **'No notifications here'**
  String get notifEmpty;

  /// No description provided for @notifToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get notifToday;

  /// No description provided for @notifYesterday.
  ///
  /// In en, this message translates to:
  /// **'Yesterday'**
  String get notifYesterday;

  /// No description provided for @notifSampleDate.
  ///
  /// In en, this message translates to:
  /// **'16/07/2026'**
  String get notifSampleDate;

  /// No description provided for @notif1Title.
  ///
  /// In en, this message translates to:
  /// **'New appointment'**
  String get notif1Title;

  /// No description provided for @notif1Body.
  ///
  /// In en, this message translates to:
  /// **'A new appointment was booked with patient Ahmed Khaled at 3:00 pm'**
  String get notif1Body;

  /// No description provided for @notif2Title.
  ///
  /// In en, this message translates to:
  /// **'Lab results'**
  String get notif2Title;

  /// No description provided for @notif2Body.
  ///
  /// In en, this message translates to:
  /// **'Lab results for patient Sara Mohammed have been uploaded'**
  String get notif2Body;

  /// No description provided for @notif3Title.
  ///
  /// In en, this message translates to:
  /// **'Invoice paid'**
  String get notif3Title;

  /// No description provided for @notif3Body.
  ///
  /// In en, this message translates to:
  /// **'Invoice #1234 was paid for 150 SAR'**
  String get notif3Body;

  /// No description provided for @notif4Title.
  ///
  /// In en, this message translates to:
  /// **'New message'**
  String get notif4Title;

  /// No description provided for @notif4Body.
  ///
  /// In en, this message translates to:
  /// **'You have a new message from Dr. Mohammed Ali'**
  String get notif4Body;

  /// No description provided for @notif5Title.
  ///
  /// In en, this message translates to:
  /// **'Appointment reminder'**
  String get notif5Title;

  /// No description provided for @notif5Body.
  ///
  /// In en, this message translates to:
  /// **'Patient Fahad Al-Anazi has an appointment tomorrow at 11:00 am'**
  String get notif5Body;

  /// No description provided for @apptTitle.
  ///
  /// In en, this message translates to:
  /// **'Appointments'**
  String get apptTitle;

  /// No description provided for @apptHeaderLine.
  ///
  /// In en, this message translates to:
  /// **'{total} appointments • {pending} pending'**
  String apptHeaderLine(String total, String pending);

  /// No description provided for @apptStatConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get apptStatConfirmed;

  /// No description provided for @apptStatDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get apptStatDone;

  /// No description provided for @apptTabAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get apptTabAll;

  /// No description provided for @apptTabPending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get apptTabPending;

  /// No description provided for @apptTabConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get apptTabConfirmed;

  /// No description provided for @apptTabDone.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get apptTabDone;

  /// No description provided for @apptTabRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get apptTabRejected;

  /// No description provided for @apptStatusPending.
  ///
  /// In en, this message translates to:
  /// **'Under review'**
  String get apptStatusPending;

  /// No description provided for @apptStatusConfirmed.
  ///
  /// In en, this message translates to:
  /// **'Confirmed'**
  String get apptStatusConfirmed;

  /// No description provided for @apptStatusDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get apptStatusDone;

  /// No description provided for @apptStatusRejected.
  ///
  /// In en, this message translates to:
  /// **'Rejected'**
  String get apptStatusRejected;

  /// No description provided for @apptEmpty.
  ///
  /// In en, this message translates to:
  /// **'No appointments in this category'**
  String get apptEmpty;

  /// No description provided for @apptAccept.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get apptAccept;

  /// No description provided for @apptReject.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get apptReject;

  /// No description provided for @apptFinish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get apptFinish;

  /// No description provided for @apptFinishLab.
  ///
  /// In en, this message translates to:
  /// **'Finish & upload result'**
  String get apptFinishLab;

  /// No description provided for @apptRejectReasonPrefix.
  ///
  /// In en, this message translates to:
  /// **'Rejection reason'**
  String get apptRejectReasonPrefix;

  /// No description provided for @apptPatientSection.
  ///
  /// In en, this message translates to:
  /// **'Patient info'**
  String get apptPatientSection;

  /// No description provided for @apptDetailsSection.
  ///
  /// In en, this message translates to:
  /// **'Appointment details'**
  String get apptDetailsSection;

  /// No description provided for @apptActionsSection.
  ///
  /// In en, this message translates to:
  /// **'Actions'**
  String get apptActionsSection;

  /// No description provided for @apptRowName.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get apptRowName;

  /// No description provided for @apptRowPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get apptRowPhone;

  /// No description provided for @apptRowService.
  ///
  /// In en, this message translates to:
  /// **'Service'**
  String get apptRowService;

  /// No description provided for @apptRowDate.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get apptRowDate;

  /// No description provided for @apptRowTime.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get apptRowTime;

  /// No description provided for @apptSampleDate.
  ///
  /// In en, this message translates to:
  /// **'Saturday, 18 July 2026'**
  String get apptSampleDate;

  /// No description provided for @apptRejectTitle.
  ///
  /// In en, this message translates to:
  /// **'Rejection reason'**
  String get apptRejectTitle;

  /// No description provided for @apptRejectSub.
  ///
  /// In en, this message translates to:
  /// **'Required — shown to the patient'**
  String get apptRejectSub;

  /// No description provided for @apptReasonFull.
  ///
  /// In en, this message translates to:
  /// **'Schedule is full'**
  String get apptReasonFull;

  /// No description provided for @apptReasonScope.
  ///
  /// In en, this message translates to:
  /// **'Out of specialty scope'**
  String get apptReasonScope;

  /// No description provided for @apptReasonIncomplete.
  ///
  /// In en, this message translates to:
  /// **'Request data is incomplete'**
  String get apptReasonIncomplete;

  /// No description provided for @apptReasonOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get apptReasonOther;

  /// No description provided for @apptRejectNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Write the rejection reason...'**
  String get apptRejectNoteHint;

  /// No description provided for @apptRejectConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm rejection'**
  String get apptRejectConfirm;

  /// No description provided for @apptRejectToast.
  ///
  /// In en, this message translates to:
  /// **'Appointment rejected and patient notified'**
  String get apptRejectToast;

  /// No description provided for @apptFinishSubLab.
  ///
  /// In en, this message translates to:
  /// **'Attach the lab result PDF with your notes'**
  String get apptFinishSubLab;

  /// No description provided for @apptFinishSub.
  ///
  /// In en, this message translates to:
  /// **'Add your notes then confirm'**
  String get apptFinishSub;

  /// No description provided for @apptUploadTitle.
  ///
  /// In en, this message translates to:
  /// **'Tap to upload the lab result (PDF)'**
  String get apptUploadTitle;

  /// No description provided for @apptUploadHint.
  ///
  /// In en, this message translates to:
  /// **'Max 10 MB'**
  String get apptUploadHint;

  /// No description provided for @apptFileName.
  ///
  /// In en, this message translates to:
  /// **'lab-result.pdf'**
  String get apptFileName;

  /// No description provided for @apptFileAttached.
  ///
  /// In en, this message translates to:
  /// **'Attached ✓ — tap to change'**
  String get apptFileAttached;

  /// No description provided for @apptFinishNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Notes (optional)...'**
  String get apptFinishNoteHint;

  /// No description provided for @apptFinishConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm finish'**
  String get apptFinishConfirm;

  /// No description provided for @apptFinishConfirmLab.
  ///
  /// In en, this message translates to:
  /// **'Upload result & finish'**
  String get apptFinishConfirmLab;

  /// No description provided for @apptFinishToast.
  ///
  /// In en, this message translates to:
  /// **'Appointment finished successfully'**
  String get apptFinishToast;

  /// No description provided for @apptFinishToastLab.
  ///
  /// In en, this message translates to:
  /// **'Result uploaded and appointment finished'**
  String get apptFinishToastLab;

  /// No description provided for @appt1Name.
  ///
  /// In en, this message translates to:
  /// **'Ahmed Mohammed Ali'**
  String get appt1Name;

  /// No description provided for @appt1Service.
  ///
  /// In en, this message translates to:
  /// **'CBC blood test (lab)'**
  String get appt1Service;

  /// No description provided for @appt2Name.
  ///
  /// In en, this message translates to:
  /// **'Sara Youssef'**
  String get appt2Name;

  /// No description provided for @appt2Service.
  ///
  /// In en, this message translates to:
  /// **'Pediatrics - routine checkup'**
  String get appt2Service;

  /// No description provided for @appt3Name.
  ///
  /// In en, this message translates to:
  /// **'Mahmoud Abdul Rahman'**
  String get appt3Name;

  /// No description provided for @appt3Service.
  ///
  /// In en, this message translates to:
  /// **'X-Ray'**
  String get appt3Service;

  /// No description provided for @appt4Name.
  ///
  /// In en, this message translates to:
  /// **'Fatima Al-Zahrani'**
  String get appt4Name;

  /// No description provided for @appt4Service.
  ///
  /// In en, this message translates to:
  /// **'Cardiology consultation'**
  String get appt4Service;

  /// No description provided for @appt5Name.
  ///
  /// In en, this message translates to:
  /// **'Khalid Al-Otaibi'**
  String get appt5Name;

  /// No description provided for @appt5Service.
  ///
  /// In en, this message translates to:
  /// **'Hormone panel'**
  String get appt5Service;

  /// No description provided for @appt6Name.
  ///
  /// In en, this message translates to:
  /// **'Noura Al-Qahtani'**
  String get appt6Name;

  /// No description provided for @appt6Service.
  ///
  /// In en, this message translates to:
  /// **'Eye examination'**
  String get appt6Service;

  /// No description provided for @appt7Name.
  ///
  /// In en, this message translates to:
  /// **'Abdullah Al-Ghamdi'**
  String get appt7Name;

  /// No description provided for @appt7Service.
  ///
  /// In en, this message translates to:
  /// **'Vitamin D'**
  String get appt7Service;

  /// No description provided for @appt8Name.
  ///
  /// In en, this message translates to:
  /// **'Reem Al-Shehri'**
  String get appt8Name;

  /// No description provided for @appt8Service.
  ///
  /// In en, this message translates to:
  /// **'Dermatology consultation'**
  String get appt8Service;

  /// No description provided for @appt9Name.
  ///
  /// In en, this message translates to:
  /// **'Sultan Al-Dosari'**
  String get appt9Name;

  /// No description provided for @appt9Service.
  ///
  /// In en, this message translates to:
  /// **'ECG'**
  String get appt9Service;

  /// No description provided for @settingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// No description provided for @settingsClinicName.
  ///
  /// In en, this message translates to:
  /// **'Al-Shifa Clinic'**
  String get settingsClinicName;

  /// No description provided for @settingsClinicEmail.
  ///
  /// In en, this message translates to:
  /// **'info@alshifa-clinic.sa'**
  String get settingsClinicEmail;

  /// No description provided for @settingsGroupAccount.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get settingsGroupAccount;

  /// No description provided for @settingsGroupNotifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get settingsGroupNotifications;

  /// No description provided for @settingsGroupAppearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get settingsGroupAppearance;

  /// No description provided for @settingsGroupSupport.
  ///
  /// In en, this message translates to:
  /// **'Support'**
  String get settingsGroupSupport;

  /// No description provided for @settingsProfile.
  ///
  /// In en, this message translates to:
  /// **'Clinic profile'**
  String get settingsProfile;

  /// No description provided for @settingsProfileSub.
  ///
  /// In en, this message translates to:
  /// **'Facility info and cover image'**
  String get settingsProfileSub;

  /// No description provided for @settingsPassword.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get settingsPassword;

  /// No description provided for @settingsPasswordSub.
  ///
  /// In en, this message translates to:
  /// **'Change your password'**
  String get settingsPasswordSub;

  /// No description provided for @settingsNotifApp.
  ///
  /// In en, this message translates to:
  /// **'App notifications'**
  String get settingsNotifApp;

  /// No description provided for @settingsNotifEmail.
  ///
  /// In en, this message translates to:
  /// **'Email notifications'**
  String get settingsNotifEmail;

  /// No description provided for @settingsNotifSms.
  ///
  /// In en, this message translates to:
  /// **'SMS notifications'**
  String get settingsNotifSms;

  /// No description provided for @settingsLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsLanguage;

  /// No description provided for @settingsTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsTheme;

  /// No description provided for @settingsHelp.
  ///
  /// In en, this message translates to:
  /// **'Help & support'**
  String get settingsHelp;

  /// No description provided for @settingsHelpSub.
  ///
  /// In en, this message translates to:
  /// **'FAQ and contact the team'**
  String get settingsHelpSub;

  /// No description provided for @settingsPrivacy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get settingsPrivacy;

  /// No description provided for @settingsAbout.
  ///
  /// In en, this message translates to:
  /// **'About the app'**
  String get settingsAbout;

  /// No description provided for @settingsVersion.
  ///
  /// In en, this message translates to:
  /// **'Version 1.0.0'**
  String get settingsVersion;

  /// No description provided for @settingsLogout.
  ///
  /// In en, this message translates to:
  /// **'Log out'**
  String get settingsLogout;

  /// No description provided for @settingsThemeSystem.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get settingsThemeSystem;

  /// No description provided for @settingsThemeLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get settingsThemeLight;

  /// No description provided for @settingsThemeDark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get settingsThemeDark;

  /// No description provided for @settingsThemeSystemSub.
  ///
  /// In en, this message translates to:
  /// **'Follows device settings'**
  String get settingsThemeSystemSub;

  /// No description provided for @settingsThemeLightSub.
  ///
  /// In en, this message translates to:
  /// **'Always light'**
  String get settingsThemeLightSub;

  /// No description provided for @settingsThemeDarkSub.
  ///
  /// In en, this message translates to:
  /// **'Always dark'**
  String get settingsThemeDarkSub;

  /// No description provided for @settingsLangAr.
  ///
  /// In en, this message translates to:
  /// **'العربية'**
  String get settingsLangAr;

  /// No description provided for @settingsLangArSub.
  ///
  /// In en, this message translates to:
  /// **'Arabic'**
  String get settingsLangArSub;

  /// No description provided for @settingsLangEn.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLangEn;

  /// No description provided for @settingsLangEnSub.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get settingsLangEnSub;

  /// No description provided for @settingsProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Clinic profile'**
  String get settingsProfileTitle;

  /// No description provided for @settingsProfileSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get settingsProfileSave;

  /// No description provided for @settingsCoverHint.
  ///
  /// In en, this message translates to:
  /// **'Clinic cover image — tap to upload'**
  String get settingsCoverHint;

  /// No description provided for @settingsClinicInfo.
  ///
  /// In en, this message translates to:
  /// **'Clinic info'**
  String get settingsClinicInfo;

  /// No description provided for @settingsContactInfo.
  ///
  /// In en, this message translates to:
  /// **'Contact info'**
  String get settingsContactInfo;

  /// No description provided for @settingsFieldClinicName.
  ///
  /// In en, this message translates to:
  /// **'Clinic name'**
  String get settingsFieldClinicName;

  /// No description provided for @settingsFieldAddress.
  ///
  /// In en, this message translates to:
  /// **'Clinic address'**
  String get settingsFieldAddress;

  /// No description provided for @settingsFieldLicense.
  ///
  /// In en, this message translates to:
  /// **'License number'**
  String get settingsFieldLicense;

  /// No description provided for @settingsFieldEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get settingsFieldEmail;

  /// No description provided for @settingsFieldPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone number'**
  String get settingsFieldPhone;

  /// No description provided for @settingsFieldWebsite.
  ///
  /// In en, this message translates to:
  /// **'Website'**
  String get settingsFieldWebsite;

  /// No description provided for @settingsPasswordTitle.
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsPasswordTitle;

  /// No description provided for @settingsPasswordHero.
  ///
  /// In en, this message translates to:
  /// **'Your account security is our priority'**
  String get settingsPasswordHero;

  /// No description provided for @settingsPasswordHint.
  ///
  /// In en, this message translates to:
  /// **'The new password must be at least 8 characters and contain letters and numbers'**
  String get settingsPasswordHint;

  /// No description provided for @settingsPasswordCurrent.
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get settingsPasswordCurrent;

  /// No description provided for @settingsPasswordNew.
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get settingsPasswordNew;

  /// No description provided for @settingsPasswordConfirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm password'**
  String get settingsPasswordConfirm;

  /// No description provided for @passwordStrengthLabel.
  ///
  /// In en, this message translates to:
  /// **'Password strength:'**
  String get passwordStrengthLabel;

  /// No description provided for @passwordStrengthNone.
  ///
  /// In en, this message translates to:
  /// **'Enter a password'**
  String get passwordStrengthNone;

  /// No description provided for @passwordStrengthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get passwordStrengthWeak;

  /// No description provided for @passwordStrengthMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get passwordStrengthMedium;

  /// No description provided for @passwordStrengthStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get passwordStrengthStrong;

  /// No description provided for @settingsValueAddress.
  ///
  /// In en, this message translates to:
  /// **'King Fahd Road, Riyadh'**
  String get settingsValueAddress;

  /// No description provided for @settingsValueLicense.
  ///
  /// In en, this message translates to:
  /// **'MC-2024-1234'**
  String get settingsValueLicense;

  /// No description provided for @settingsValuePhone.
  ///
  /// In en, this message translates to:
  /// **'+966 11 234 5678'**
  String get settingsValuePhone;

  /// No description provided for @settingsValueWebsite.
  ///
  /// In en, this message translates to:
  /// **'www.alshifa-clinic.sa'**
  String get settingsValueWebsite;

  /// No description provided for @settingsImageSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get settingsImageSoonTitle;

  /// No description provided for @settingsImageSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'Image upload is coming soon'**
  String get settingsImageSoonMessage;

  /// No description provided for @settingsPasswordChanged.
  ///
  /// In en, this message translates to:
  /// **'Password changed successfully'**
  String get settingsPasswordChanged;

  /// No description provided for @mediaSourceTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose image source'**
  String get mediaSourceTitle;

  /// No description provided for @mediaSourceCamera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get mediaSourceCamera;

  /// No description provided for @mediaSourceCameraSub.
  ///
  /// In en, this message translates to:
  /// **'Take a new photo'**
  String get mediaSourceCameraSub;

  /// No description provided for @mediaSourceGallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get mediaSourceGallery;

  /// No description provided for @mediaSourceGallerySub.
  ///
  /// In en, this message translates to:
  /// **'Pick from saved photos'**
  String get mediaSourceGallerySub;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// No description provided for @servicesTitle.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get servicesTitle;

  /// No description provided for @servicesActiveLine.
  ///
  /// In en, this message translates to:
  /// **'{count} active services'**
  String servicesActiveLine(String count);

  /// No description provided for @servicesLabTab.
  ///
  /// In en, this message translates to:
  /// **'Lab tests'**
  String get servicesLabTab;

  /// No description provided for @servicesSpecialtyTab.
  ///
  /// In en, this message translates to:
  /// **'Medical specialties'**
  String get servicesSpecialtyTab;

  /// No description provided for @servicesLabStat.
  ///
  /// In en, this message translates to:
  /// **'Tests'**
  String get servicesLabStat;

  /// No description provided for @servicesSpecialtyStat.
  ///
  /// In en, this message translates to:
  /// **'Specialties'**
  String get servicesSpecialtyStat;

  /// No description provided for @servicesTestsAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} tests available'**
  String servicesTestsAvailable(String count);

  /// No description provided for @servicesSpecialtyLabel.
  ///
  /// In en, this message translates to:
  /// **'Medical specialty'**
  String get servicesSpecialtyLabel;

  /// No description provided for @servicesAddSection.
  ///
  /// In en, this message translates to:
  /// **'Add test section'**
  String get servicesAddSection;

  /// No description provided for @servicesAddSpecialty.
  ///
  /// In en, this message translates to:
  /// **'Add specialty'**
  String get servicesAddSpecialty;

  /// No description provided for @servicesAddSectionSub.
  ///
  /// In en, this message translates to:
  /// **'Choose a section to add and manage its test prices'**
  String get servicesAddSectionSub;

  /// No description provided for @servicesAddSpecialtyTitle.
  ///
  /// In en, this message translates to:
  /// **'Add medical specialty'**
  String get servicesAddSpecialtyTitle;

  /// No description provided for @servicesAddSpecialtySub.
  ///
  /// In en, this message translates to:
  /// **'Choose a specialty to add to your clinic'**
  String get servicesAddSpecialtySub;

  /// No description provided for @servicesAdded.
  ///
  /// In en, this message translates to:
  /// **'Added'**
  String get servicesAdded;

  /// No description provided for @servicesEnabled.
  ///
  /// In en, this message translates to:
  /// **'Enabled'**
  String get servicesEnabled;

  /// No description provided for @servicesDisabled.
  ///
  /// In en, this message translates to:
  /// **'Not enabled'**
  String get servicesDisabled;

  /// No description provided for @servicesCurrency.
  ///
  /// In en, this message translates to:
  /// **'SAR'**
  String get servicesCurrency;

  /// No description provided for @servicesPriceHint.
  ///
  /// In en, this message translates to:
  /// **'0'**
  String get servicesPriceHint;

  /// No description provided for @labSectionMarriage.
  ///
  /// In en, this message translates to:
  /// **'Marriage screening'**
  String get labSectionMarriage;

  /// No description provided for @labSectionHormones.
  ///
  /// In en, this message translates to:
  /// **'Hormones'**
  String get labSectionHormones;

  /// No description provided for @labSectionVitamins.
  ///
  /// In en, this message translates to:
  /// **'Vitamins'**
  String get labSectionVitamins;

  /// No description provided for @testScd.
  ///
  /// In en, this message translates to:
  /// **'Sickle cell anemia'**
  String get testScd;

  /// No description provided for @testThal.
  ///
  /// In en, this message translates to:
  /// **'Thalassemia'**
  String get testThal;

  /// No description provided for @testHbv.
  ///
  /// In en, this message translates to:
  /// **'Hepatitis B'**
  String get testHbv;

  /// No description provided for @testHcv.
  ///
  /// In en, this message translates to:
  /// **'Hepatitis C'**
  String get testHcv;

  /// No description provided for @testHiv.
  ///
  /// In en, this message translates to:
  /// **'HIV immunity test'**
  String get testHiv;

  /// No description provided for @testTsh.
  ///
  /// In en, this message translates to:
  /// **'Thyroid TSH'**
  String get testTsh;

  /// No description provided for @testTestosterone.
  ///
  /// In en, this message translates to:
  /// **'Testosterone'**
  String get testTestosterone;

  /// No description provided for @testVitaminD.
  ///
  /// In en, this message translates to:
  /// **'Vitamin D'**
  String get testVitaminD;

  /// No description provided for @testVitaminB12.
  ///
  /// In en, this message translates to:
  /// **'Vitamin B12'**
  String get testVitaminB12;

  /// No description provided for @serviceSubHereditary.
  ///
  /// In en, this message translates to:
  /// **'Hereditary blood disorder test'**
  String get serviceSubHereditary;

  /// No description provided for @serviceSubGenetic.
  ///
  /// In en, this message translates to:
  /// **'Genetic blood cell test'**
  String get serviceSubGenetic;

  /// No description provided for @serviceSubInfectious.
  ///
  /// In en, this message translates to:
  /// **'Infectious virus screening'**
  String get serviceSubInfectious;

  /// No description provided for @serviceSubThyroid.
  ///
  /// In en, this message translates to:
  /// **'Thyroid function'**
  String get serviceSubThyroid;

  /// No description provided for @serviceSubSexHormone.
  ///
  /// In en, this message translates to:
  /// **'Sex hormones'**
  String get serviceSubSexHormone;

  /// No description provided for @serviceSubVitaminD.
  ///
  /// In en, this message translates to:
  /// **'Vitamin D3 level'**
  String get serviceSubVitaminD;

  /// No description provided for @serviceSubVitaminB12.
  ///
  /// In en, this message translates to:
  /// **'Vitamin B12 level'**
  String get serviceSubVitaminB12;

  /// No description provided for @reportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get reportsTitle;

  /// No description provided for @reportsHeaderLine.
  ///
  /// In en, this message translates to:
  /// **'{total} total • {done} done'**
  String reportsHeaderLine(String total, String done);

  /// No description provided for @reportsPeriodWeek.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get reportsPeriodWeek;

  /// No description provided for @reportsPeriodMonth.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get reportsPeriodMonth;

  /// No description provided for @reportsChartTitleWeek.
  ///
  /// In en, this message translates to:
  /// **'Weekly performance'**
  String get reportsChartTitleWeek;

  /// No description provided for @reportsChartTitleMonth.
  ///
  /// In en, this message translates to:
  /// **'Monthly performance'**
  String get reportsChartTitleMonth;

  /// No description provided for @reportsChartSubWeek.
  ///
  /// In en, this message translates to:
  /// **'Appointment distribution across the week'**
  String get reportsChartSubWeek;

  /// No description provided for @reportsChartSubMonth.
  ///
  /// In en, this message translates to:
  /// **'Appointment distribution across the month'**
  String get reportsChartSubMonth;

  /// No description provided for @reportsTypeSection.
  ///
  /// In en, this message translates to:
  /// **'Report type'**
  String get reportsTypeSection;

  /// No description provided for @reportsTypeAppointments.
  ///
  /// In en, this message translates to:
  /// **'Appointments report'**
  String get reportsTypeAppointments;

  /// No description provided for @reportsTypeRevenue.
  ///
  /// In en, this message translates to:
  /// **'Revenue report'**
  String get reportsTypeRevenue;

  /// No description provided for @reportsTypeLabs.
  ///
  /// In en, this message translates to:
  /// **'Labs report'**
  String get reportsTypeLabs;

  /// No description provided for @reportsOutcomeDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get reportsOutcomeDone;

  /// No description provided for @reportsOutcomePending.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get reportsOutcomePending;

  /// No description provided for @reportsOutcomePendingLong.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get reportsOutcomePendingLong;

  /// No description provided for @reportsOutcomeCancelled.
  ///
  /// In en, this message translates to:
  /// **'Cancelled'**
  String get reportsOutcomeCancelled;

  /// No description provided for @reportsDaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get reportsDaySat;

  /// No description provided for @reportsDaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get reportsDaySun;

  /// No description provided for @reportsDayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get reportsDayMon;

  /// No description provided for @reportsDayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get reportsDayTue;

  /// No description provided for @reportsDayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get reportsDayWed;

  /// No description provided for @reportsDayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get reportsDayThu;

  /// No description provided for @reportsDayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get reportsDayFri;

  /// No description provided for @reportsWeek1.
  ///
  /// In en, this message translates to:
  /// **'Week 1'**
  String get reportsWeek1;

  /// No description provided for @reportsWeek2.
  ///
  /// In en, this message translates to:
  /// **'Week 2'**
  String get reportsWeek2;

  /// No description provided for @reportsWeek3.
  ///
  /// In en, this message translates to:
  /// **'Week 3'**
  String get reportsWeek3;

  /// No description provided for @reportsWeek4.
  ///
  /// In en, this message translates to:
  /// **'Week 4'**
  String get reportsWeek4;

  /// No description provided for @reportsExportPdf.
  ///
  /// In en, this message translates to:
  /// **'Export PDF'**
  String get reportsExportPdf;

  /// No description provided for @reportsExportCsv.
  ///
  /// In en, this message translates to:
  /// **'Export CSV'**
  String get reportsExportCsv;

  /// No description provided for @reportsExportSoonTitle.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get reportsExportSoonTitle;

  /// No description provided for @reportsExportSoonMessage.
  ///
  /// In en, this message translates to:
  /// **'Report export is coming soon'**
  String get reportsExportSoonMessage;

  /// No description provided for @reportsListTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports list'**
  String get reportsListTitle;

  /// No description provided for @reportsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} {label}'**
  String reportsCountLabel(String count, String label);

  /// No description provided for @reportsTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'{total} total'**
  String reportsTotalLabel(String total);

  /// No description provided for @report1Date.
  ///
  /// In en, this message translates to:
  /// **'18 Jul 2026 · 10:22 am'**
  String get report1Date;

  /// No description provided for @report2Date.
  ///
  /// In en, this message translates to:
  /// **'11 Jul 2026 · 10:22 am'**
  String get report2Date;

  /// No description provided for @report3Date.
  ///
  /// In en, this message translates to:
  /// **'04 Jul 2026 · 10:22 am'**
  String get report3Date;

  /// No description provided for @toastOtpSentSuccess.
  ///
  /// In en, this message translates to:
  /// **'OTP sent successfully'**
  String get toastOtpSentSuccess;

  /// No description provided for @toastSuccess.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get toastSuccess;

  /// No description provided for @toastFailure.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get toastFailure;

  /// No description provided for @toastWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get toastWarning;

  /// No description provided for @shareAppText.
  ///
  /// In en, this message translates to:
  /// **'Download Eyadaty app: {appLink}'**
  String shareAppText(String appLink);

  /// No description provided for @noResultsFound.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResultsFound;

  /// No description provided for @noDataYet.
  ///
  /// In en, this message translates to:
  /// **'No data yet'**
  String get noDataYet;

  /// No description provided for @coreUnsupportedType.
  ///
  /// In en, this message translates to:
  /// **'Unsupported type'**
  String get coreUnsupportedType;

  /// No description provided for @coreUnsupportedImageFormat.
  ///
  /// In en, this message translates to:
  /// **'Unsupported image format'**
  String get coreUnsupportedImageFormat;

  /// No description provided for @requestTimeout.
  ///
  /// In en, this message translates to:
  /// **'Request timeout'**
  String get requestTimeout;

  /// No description provided for @noInternetConnection.
  ///
  /// In en, this message translates to:
  /// **'No internet connection'**
  String get noInternetConnection;

  /// No description provided for @sendTimeout.
  ///
  /// In en, this message translates to:
  /// **'Send timeout'**
  String get sendTimeout;

  /// No description provided for @chatImageWithIcon.
  ///
  /// In en, this message translates to:
  /// **'Image'**
  String get chatImageWithIcon;

  /// No description provided for @chatVideoWithIcon.
  ///
  /// In en, this message translates to:
  /// **'Video'**
  String get chatVideoWithIcon;

  /// No description provided for @chatVoiceWithIcon.
  ///
  /// In en, this message translates to:
  /// **'Voice message'**
  String get chatVoiceWithIcon;

  /// No description provided for @chatFileWithIcon.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get chatFileWithIcon;

  /// No description provided for @legalCopied.
  ///
  /// In en, this message translates to:
  /// **'Copied to clipboard'**
  String get legalCopied;

  /// No description provided for @legalAboutIntro.
  ///
  /// In en, this message translates to:
  /// **'An all-in-one platform for managing clinics and medical labs in Saudi Arabia, connecting care providers and patients through a smooth, dependable digital experience.'**
  String get legalAboutIntro;

  /// No description provided for @legalAboutFeature1.
  ///
  /// In en, this message translates to:
  /// **'Appointment booking'**
  String get legalAboutFeature1;

  /// No description provided for @legalAboutFeature1Sub.
  ///
  /// In en, this message translates to:
  /// **'Organize patient and doctor schedules easily'**
  String get legalAboutFeature1Sub;

  /// No description provided for @legalAboutFeature2.
  ///
  /// In en, this message translates to:
  /// **'Digital lab results'**
  String get legalAboutFeature2;

  /// No description provided for @legalAboutFeature2Sub.
  ///
  /// In en, this message translates to:
  /// **'Upload and share test reports securely'**
  String get legalAboutFeature2Sub;

  /// No description provided for @legalAboutFeature3.
  ///
  /// In en, this message translates to:
  /// **'Manage your medical team'**
  String get legalAboutFeature3;

  /// No description provided for @legalAboutFeature3Sub.
  ///
  /// In en, this message translates to:
  /// **'Doctor profiles, working hours and services'**
  String get legalAboutFeature3Sub;

  /// No description provided for @legalAboutFeature4.
  ///
  /// In en, this message translates to:
  /// **'High security standards'**
  String get legalAboutFeature4;

  /// No description provided for @legalAboutFeature4Sub.
  ///
  /// In en, this message translates to:
  /// **'Patient data protected under Saudi regulations'**
  String get legalAboutFeature4Sub;

  /// No description provided for @legalAboutLinkWebsite.
  ///
  /// In en, this message translates to:
  /// **'Visit our website'**
  String get legalAboutLinkWebsite;

  /// No description provided for @legalAboutCopyright.
  ///
  /// In en, this message translates to:
  /// **'© 2026 Eyadaty. All rights reserved'**
  String get legalAboutCopyright;

  /// No description provided for @legalPrivacyUpdated.
  ///
  /// In en, this message translates to:
  /// **'Last updated: 1 July 2026'**
  String get legalPrivacyUpdated;

  /// No description provided for @legalPrivacy1.
  ///
  /// In en, this message translates to:
  /// **'Data we collect'**
  String get legalPrivacy1;

  /// No description provided for @legalPrivacy1Body.
  ///
  /// In en, this message translates to:
  /// **'We collect basic account details (name, email, license number) and the medical data needed to provide booking and lab services, in line with Saudi personal data protection regulations.'**
  String get legalPrivacy1Body;

  /// No description provided for @legalPrivacy2.
  ///
  /// In en, this message translates to:
  /// **'How we use data'**
  String get legalPrivacy2;

  /// No description provided for @legalPrivacy2Body.
  ///
  /// In en, this message translates to:
  /// **'Your data is used only to run booking, reporting and notification services. It is never shared with third parties for marketing.'**
  String get legalPrivacy2Body;

  /// No description provided for @legalPrivacy3.
  ///
  /// In en, this message translates to:
  /// **'Storage and protection'**
  String get legalPrivacy3;

  /// No description provided for @legalPrivacy3Body.
  ///
  /// In en, this message translates to:
  /// **'All data is stored on encrypted servers inside the Kingdom, with strict access controls limited to authorized staff.'**
  String get legalPrivacy3Body;

  /// No description provided for @legalPrivacy4.
  ///
  /// In en, this message translates to:
  /// **'Your rights'**
  String get legalPrivacy4;

  /// No description provided for @legalPrivacy4Body.
  ///
  /// In en, this message translates to:
  /// **'You may request access to your data, correct it, or delete your account entirely at any time by contacting our support team.'**
  String get legalPrivacy4Body;

  /// No description provided for @legalPrivacy5.
  ///
  /// In en, this message translates to:
  /// **'Cookies and local storage'**
  String get legalPrivacy5;

  /// No description provided for @legalPrivacy5Body.
  ///
  /// In en, this message translates to:
  /// **'The app keeps limited local storage for your preferences (language, theme) only — no advertising tracking.'**
  String get legalPrivacy5Body;

  /// No description provided for @legalContactTitle.
  ///
  /// In en, this message translates to:
  /// **'Contact us'**
  String get legalContactTitle;

  /// No description provided for @legalContactPhone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get legalContactPhone;

  /// No description provided for @legalContactPhoneValue.
  ///
  /// In en, this message translates to:
  /// **'+966 11 234 5678'**
  String get legalContactPhoneValue;

  /// No description provided for @legalContactEmail.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get legalContactEmail;

  /// No description provided for @legalContactEmailValue.
  ///
  /// In en, this message translates to:
  /// **'support@alshifa-clinic.sa'**
  String get legalContactEmailValue;

  /// No description provided for @legalContactAddress.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get legalContactAddress;

  /// No description provided for @legalContactAddressValue.
  ///
  /// In en, this message translates to:
  /// **'King Fahd Road, Riyadh'**
  String get legalContactAddressValue;

  /// No description provided for @legalContactWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'WhatsApp'**
  String get legalContactWhatsapp;

  /// No description provided for @legalContactWhatsappValue.
  ///
  /// In en, this message translates to:
  /// **'+966 55 123 4567'**
  String get legalContactWhatsappValue;

  /// No description provided for @legalContactHours.
  ///
  /// In en, this message translates to:
  /// **'Support hours: Saturday to Thursday, 9 AM — 9 PM Riyadh time'**
  String get legalContactHours;

  /// No description provided for @legalContactFormTitle.
  ///
  /// In en, this message translates to:
  /// **'Send us a message'**
  String get legalContactFormTitle;

  /// No description provided for @legalContactName.
  ///
  /// In en, this message translates to:
  /// **'Full name'**
  String get legalContactName;

  /// No description provided for @legalContactMessage.
  ///
  /// In en, this message translates to:
  /// **'Write your message here...'**
  String get legalContactMessage;

  /// No description provided for @legalContactSend.
  ///
  /// In en, this message translates to:
  /// **'Send message'**
  String get legalContactSend;

  /// No description provided for @legalContactSent.
  ///
  /// In en, this message translates to:
  /// **'Your message was sent — we\'ll get back to you soon'**
  String get legalContactSent;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
