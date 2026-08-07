// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appBrand => 'عيادتي';

  @override
  String get onboardingSkip => 'تخطي';

  @override
  String get onboardingNext => 'التالي';

  @override
  String get onboardingStart => 'ابدأ الآن';

  @override
  String get onb1Kicker => 'للعيادات';

  @override
  String get onb1Title => 'إدارة مواعيدك بذكاء';

  @override
  String get onb1Desc =>
      'نظّم جدول مواعيد المرضى، قلّل وقت الانتظار، وارفع كفاءة عيادتك بلمسة واحدة.';

  @override
  String get onb1ChipTitle => 'موعد مؤكد';

  @override
  String get onb1ChipSub => 'د. سارة — ٤:٣٠ م';

  @override
  String get onb2Kicker => 'للمرضى';

  @override
  String get onb2Title => 'احجز موعدك في ثوانٍ';

  @override
  String get onb2Desc =>
      'اختر الطبيب والوقت المناسب لك، وأكّد حجزك بسهولة — كل ذلك من مكان واحد.';

  @override
  String get onb2ChipTitle => 'حجز فوري';

  @override
  String get onb2ChipSub => 'أقرب موعد اليوم';

  @override
  String get onb3Kicker => 'ملفك الصحي';

  @override
  String get onb3Title => 'ملفك الطبي معك أينما كنت';

  @override
  String get onb3Desc =>
      'تقاريرك ووصفاتك ونتائج فحوصاتك محفوظة بأمان ومتاحة في أي وقت.';

  @override
  String get onb3ChipTitle => 'محفوظ بأمان';

  @override
  String get onb3ChipSub => 'تشفير كامل';

  @override
  String get authLoginTitle => 'تسجيل الدخول';

  @override
  String get authLoginSubtitle => 'مرحباً بعودتك، نتمنى لك يوماً مثمراً';

  @override
  String get authIdentifierHint => 'البريد الإلكتروني أو رقم الترخيص';

  @override
  String get authPasswordHint => 'كلمة المرور';

  @override
  String get authForgotLink => 'هل نسيت كلمة المرور؟';

  @override
  String get authLoginCta => 'دخول';

  @override
  String get authGuestCta => 'التصفح كزائر';

  @override
  String get authNoAccount => 'ليس لديك حساب؟';

  @override
  String get authCreateAccount => 'إنشاء حساب جديد';

  @override
  String get authSignupTitle => 'إنشاء حساب';

  @override
  String get authSignupSubtitle => 'أنشئ حساب منشأتك الطبية';

  @override
  String get authAccountTypeLabel => 'نوع الحساب';

  @override
  String get authTypeClinic => 'عيادة';

  @override
  String get authTypeClinicSub => 'عيادة طبية';

  @override
  String get authTypeLab => 'مخبر';

  @override
  String get authTypeLabSub => 'مختبر طبي';

  @override
  String get authTypeBoth => 'عيادة + مخبر';

  @override
  String get authTypeBothSub => 'منشأة متكاملة';

  @override
  String get authFacilityClinic => 'معلومات العيادة';

  @override
  String get authFacilityLab => 'معلومات المخبر';

  @override
  String get authFacilityBoth => 'معلومات المنشأة';

  @override
  String get authFacilityHintClinic => 'مثال: عيادة الشفاء';

  @override
  String get authFacilityHintLab => 'مثال: مخبر الأمل';

  @override
  String get authFacilityHintBoth => 'مثال: مجمع الشفاء الطبي';

  @override
  String get authLicenseHint => 'رقم الترخيص المعتمد';

  @override
  String get authEmailHint => 'البريد الإلكتروني';

  @override
  String get authConfirmPasswordHint => 'تأكيد كلمة المرور';

  @override
  String get authSignupCta => 'إرسال للتدقيق';

  @override
  String get authTermsPrefix => 'بالتسجيل أنت توافق على ';

  @override
  String get authTermsLink => 'الشروط والأحكام';

  @override
  String get authTermsSuffix => ' وسياسة الخصوصية';

  @override
  String get authHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get authSignin => 'تسجيل الدخول';

  @override
  String get authForgotTitle => 'نسيت كلمة المرور؟';

  @override
  String get authForgotDesc =>
      'لا تقلق! يحدث ذلك. أدخل البريد الإلكتروني أو رقم الترخيص المرتبط بحسابك.';

  @override
  String get authForgotInfo =>
      'سنرسل لك رابط إعادة تعيين كلمة المرور على بريدك الإلكتروني أو رقم هاتفك';

  @override
  String get authForgotFieldHint => 'مثال: info@clinic.com';

  @override
  String get authForgotCta => 'إرسال رمز التحقق';

  @override
  String get authBackToLogin => 'العودة لتسجيل الدخول';

  @override
  String get authOtpTitle => 'رمز التحقق';

  @override
  String authOtpDesc(int count) {
    return 'أرسلنا رمزاً مكوناً من $count أرقام إلى بريدك الإلكتروني';
  }

  @override
  String get authOtpCta => 'تأكيد الرمز';

  @override
  String get authOtpNoCode => 'لم يصلك الرمز؟';

  @override
  String get authOtpResend => 'إعادة إرسال الرمز';

  @override
  String authOtpResendIn(int seconds) {
    return 'إعادة الإرسال خلال $seconds ثانية';
  }

  @override
  String get authOtpResent => 'أعدنا إرسال رمز التحقق';

  @override
  String get authResetTitle => 'كلمة مرور جديدة';

  @override
  String authResetDesc(int count) {
    return 'يجب أن تختلف عن كلمة المرور السابقة، وألا تقل عن $count أحرف';
  }

  @override
  String get authResetNewHint => 'كلمة المرور الجديدة';

  @override
  String get authResetCta => 'حفظ كلمة المرور';

  @override
  String get authResetDone => 'تم تحديث كلمة المرور بنجاح';

  @override
  String get authPendingTitle => 'طلبك قيد المراجعة';

  @override
  String get authPendingDesc =>
      'تم إرسال طلب تسجيل منشأتك إلى إدارة المنصة. سيتم إشعارك فور الموافقة على حسابك — عادةً خلال ٢٤ ساعة.';

  @override
  String get authStep1Title => 'تم إرسال الطلب';

  @override
  String get authStep1Sub => 'وصل طلبك إلى الإدارة';

  @override
  String get authStep2Title => 'المراجعة والتحقق';

  @override
  String get authStep2Sub => 'جارٍ التحقق من رقم الترخيص';

  @override
  String get authStep3Title => 'تفعيل الحساب';

  @override
  String get authStep3Sub => 'ستصلك رسالة تأكيد';

  @override
  String get validationRequired => 'هذا الحقل مطلوب';

  @override
  String get validationEmail => 'أدخل بريداً إلكترونياً صحيحاً';

  @override
  String get validationPasswordLength => 'كلمة المرور يجب ألا تقل عن ٨ أحرف';

  @override
  String get validationPasswordMismatch => 'كلمتا المرور غير متطابقتين';

  @override
  String get homeDashboard => 'لوحة التحكم';

  @override
  String get homeClinicName => 'عيادة الشفاء';

  @override
  String get homeDate => 'السبت، ١٨ يوليو';

  @override
  String get homeOpenStatus => 'العيادة مفتوحة — ٨:٠٠ ص إلى ٨:٠٠ م';

  @override
  String get homeNewAppointment => 'المواعيد';

  @override
  String get homeDoctors => 'الأطباء';

  @override
  String get homeServices => 'الخدمات';

  @override
  String get homeReports => 'التقارير';

  @override
  String get homeStatsTitle => 'إحصائيات العيادة';

  @override
  String get homePatients => 'المرضى';

  @override
  String get homePatientsCount => '٢٤٨';

  @override
  String get homeWeeklyGrowth => '+١٨ هذا الأسبوع ↑';

  @override
  String get homeDoctorsCount => '١٢';

  @override
  String get homeDoctorsGrowth => '+٢ هذا الشهر';

  @override
  String get homeIncomeCount => '٣٤٥٠';

  @override
  String get homeCurrency => 'ر.س';

  @override
  String get homeDailyIncome => 'الدخل اليومي';

  @override
  String get homeAppointmentsCount => '٨';

  @override
  String get homeTodayAppointments => 'مواعيد اليوم';

  @override
  String get homeUpcomingCount => '٥ قادمة';

  @override
  String get homeViewAll => 'عرض الكل';

  @override
  String get homeNavHome => 'الرئيسية';

  @override
  String get homeNavCalendar => 'التقويم';

  @override
  String get homeAppointment1Name => 'أحمد محمد السيد';

  @override
  String get homeAppointment1Service => 'استشارة قلب';

  @override
  String get homeAppointment1Time => '٩:٠٠ ص';

  @override
  String get homeAppointment2Name => 'فاطمة علي الزهراني';

  @override
  String get homeAppointment2Service => 'تحليل دم شامل';

  @override
  String get homeAppointment2Time => '١٠:٣٠ ص';

  @override
  String get homeAppointment3Name => 'محمد عبدالله الغامدي';

  @override
  String get homeAppointment3Service => 'فحص عيون';

  @override
  String get homeAppointment3Time => '١٢:٠٠ م';

  @override
  String get homeAppointment4Name => 'نورة سلمان القحطاني';

  @override
  String get homeAppointment4Service => 'استشارة عامة';

  @override
  String get homeAppointment4Time => '٢:٠٠ م';

  @override
  String get homeAppointment5Name => 'عبدالرحمن خالد العتيبي';

  @override
  String get homeAppointment5Service => 'أشعة سينية';

  @override
  String get homeAppointment5Time => '٤:٠٠ م';

  @override
  String get homeAppointmentUpcoming => 'قادم';

  @override
  String get homeAppointmentDone => 'مكتمل';

  @override
  String get homeAppointmentCancelled => 'ملغي';

  @override
  String get doctorsTitle => 'الأطباء';

  @override
  String doctorsHeaderLine(String total, String available) {
    return '$total أطباء • $available متاح الآن';
  }

  @override
  String get doctorsTotal => 'إجمالي';

  @override
  String get doctorsUnavailable => 'غير متاح';

  @override
  String get doctorsSearchHint => 'ابحث عن طبيب أو تخصص...';

  @override
  String get doctorsAll => 'الكل';

  @override
  String get specialtyCardiology => 'أمراض القلب';

  @override
  String get specialtyDermatology => 'الجلدية والتجميل';

  @override
  String get specialtyPediatrics => 'طب الأطفال';

  @override
  String get specialtyOphthalmology => 'طب العيون';

  @override
  String get specialtyDentistry => 'طب الأسنان';

  @override
  String get doctor1Name => 'د. أحمد محمد علي';

  @override
  String get doctor2Name => 'د. سارة حسن';

  @override
  String get doctor3Name => 'د. خالد العمري';

  @override
  String get doctor4Name => 'د. ليلى يوسف';

  @override
  String get doctor5Name => 'د. محمد الحربي';

  @override
  String get doctorAvailable => 'متاح';

  @override
  String get doctorUnavailable => 'غير متاح';

  @override
  String doctorExperience(String years) {
    return '$years سنة';
  }

  @override
  String doctorFee(String amount) {
    return '$amount ر.س';
  }

  @override
  String get doctorsNoResults => 'لا توجد نتائج مطابقة';

  @override
  String get doctorsAdd => 'إضافة طبيب';

  @override
  String get specialtyOrthopedics => 'العظام والمفاصل';

  @override
  String get specialtyInternal => 'الباطنية';

  @override
  String get doctorProfileTitle => 'بروفايل الطبيب';

  @override
  String get doctorProfileYearsExp => 'سنة خبرة';

  @override
  String get doctorProfilePatients => 'مريض';

  @override
  String get doctorProfileRating => 'التقييم';

  @override
  String get doctorProfileAvailTitle => 'حالة الاستقبال';

  @override
  String get doctorProfileAvailOn => 'يستقبل حجوزات جديدة الآن';

  @override
  String get doctorProfileAvailOff => 'متوقف عن استقبال الحجوزات';

  @override
  String get doctorProfileAbout => 'نبذة';

  @override
  String get doctorProfileAboutBody =>
      'استشاري بخبرة طويلة في تخصصه، وحاصل على زمالات وشهادات معتمدة، ويقدم رعاية دقيقة تركّز على راحة المريض.';

  @override
  String get doctorProfileSchedule => 'أيام الدوام';

  @override
  String get doctorProfileHours => 'من ٤:٠٠ م إلى ٩:٠٠ م — مدة الكشف ٢٠ دقيقة';

  @override
  String get doctorProfileServices => 'الخدمات والأتعاب';

  @override
  String get doctorProfileService1 => 'كشف عيادة';

  @override
  String get doctorProfileService2 => 'استشارة متابعة';

  @override
  String get doctorProfileService3 => 'تخطيط قلب ECG';

  @override
  String get doctorProfileBook => 'مواعيد الطبيب';

  @override
  String get addDoctorTitle => 'إضافة طبيب جديد';

  @override
  String get addDoctorSubtitle => 'أدخل بيانات الطبيب بشكل كامل';

  @override
  String get addDoctorBasicSection => 'المعلومات الأساسية';

  @override
  String get addDoctorNameAr => 'الاسم (بالعربي)';

  @override
  String get addDoctorNameEn => 'الاسم (بالإنجليزي)';

  @override
  String get addDoctorSpecialtyPlaceholder => 'التخصص';

  @override
  String get addDoctorFee => 'أتعاب الكشفية (ر.س)';

  @override
  String get addDoctorPhone => 'رقم الهاتف';

  @override
  String get addDoctorEmail => 'البريد الإلكتروني';

  @override
  String get addDoctorProSection => 'المعلومات المهنية';

  @override
  String get addDoctorLicense => 'رقم الترخيص الطبي';

  @override
  String get addDoctorExperienceHint => 'سنوات الخبرة';

  @override
  String get addDoctorBio => 'نبذة عن الطبيب';

  @override
  String get addDoctorQualSection => 'المؤهلات العلمية (PDF)';

  @override
  String get addDoctorUploadTitle => 'رفع ملفات';

  @override
  String get addDoctorUploadHint => 'PDF فقط';

  @override
  String get addDoctorScheduleSection => 'جدول العمل الأسبوعي';

  @override
  String get addDoctorDayOff => 'يوم إجازة';

  @override
  String get addDoctorFrom => 'من';

  @override
  String get addDoctorTo => 'إلى';

  @override
  String get addDoctorDefaultStart => '9:00 am';

  @override
  String get addDoctorDefaultEnd => '5:00 pm';

  @override
  String get addDoctorSave => 'حفظ البيانات';

  @override
  String get weekdaySaturday => 'السبت';

  @override
  String get weekdaySunday => 'الأحد';

  @override
  String get weekdayMonday => 'الاثنين';

  @override
  String get weekdayTuesday => 'الثلاثاء';

  @override
  String get weekdayWednesday => 'الأربعاء';

  @override
  String get weekdayThursday => 'الخميس';

  @override
  String get weekdayFriday => 'الجمعة';

  @override
  String get notifTitle => 'الإشعارات';

  @override
  String notifUnreadLine(String count) {
    return '$count غير مقروء';
  }

  @override
  String get notifAllRead => 'كل الإشعارات مقروءة';

  @override
  String get notifTabAll => 'الكل';

  @override
  String get notifTabUnread => 'غير مقروء';

  @override
  String get notifTabRead => 'مقروء';

  @override
  String get notifMarkAllRead => 'تحديد الكل كمقروء';

  @override
  String get notifClearAll => 'حذف الكل';

  @override
  String get notifNew => 'جديد';

  @override
  String get notifEmpty => 'لا توجد إشعارات هنا';

  @override
  String get notifToday => 'اليوم';

  @override
  String get notifYesterday => 'البارحة';

  @override
  String get notifSampleDate => '١٦/٧/٢٠٢٦';

  @override
  String get notif1Title => 'موعد جديد';

  @override
  String get notif1Body =>
      'تم حجز موعد جديد مع المريض أحمد خالد في الساعة ٣:٠٠ مساءً';

  @override
  String get notif2Title => 'نتائج الفحوصات';

  @override
  String get notif2Body => 'تم تحميل نتائج فحوصات المريضة سارة محمد';

  @override
  String get notif3Title => 'دفع فاتورة';

  @override
  String get notif3Body => 'تم دفع الفاتورة رقم #١٢٣٤ بقيمة ١٥٠ ر.س';

  @override
  String get notif4Title => 'رسالة جديدة';

  @override
  String get notif4Body => 'لديك رسالة جديدة من الدكتور محمد علي';

  @override
  String get notif5Title => 'تذكير بموعد';

  @override
  String get notif5Body => 'موعد المريض فهد العنزي غداً الساعة ١١:٠٠ صباحاً';

  @override
  String get apptTitle => 'المواعيد';

  @override
  String apptHeaderLine(String total, String pending) {
    return '$total مواعيد • $pending قيد المراجعة';
  }

  @override
  String get apptStatConfirmed => 'مؤكد';

  @override
  String get apptStatDone => 'مكتمل';

  @override
  String get apptTabAll => 'الكل';

  @override
  String get apptTabPending => 'قيد المراجعة';

  @override
  String get apptTabConfirmed => 'المؤكد';

  @override
  String get apptTabDone => 'المكتمل';

  @override
  String get apptTabRejected => 'المرفوض';

  @override
  String get apptStatusPending => 'قيد المراجعة';

  @override
  String get apptStatusConfirmed => 'مؤكد';

  @override
  String get apptStatusDone => 'مكتمل';

  @override
  String get apptStatusRejected => 'مرفوض';

  @override
  String get apptEmpty => 'لا توجد مواعيد في هذه الفئة';

  @override
  String get apptAccept => 'قبول';

  @override
  String get apptReject => 'رفض';

  @override
  String get apptFinish => 'إنهاء';

  @override
  String get apptFinishLab => 'إنهاء ورفع النتيجة';

  @override
  String get apptRejectReasonPrefix => 'سبب الرفض';

  @override
  String get apptPatientSection => 'معلومات المريض';

  @override
  String get apptDetailsSection => 'تفاصيل الموعد';

  @override
  String get apptActionsSection => 'الإجراءات';

  @override
  String get apptRowName => 'الاسم';

  @override
  String get apptRowPhone => 'الهاتف';

  @override
  String get apptRowService => 'الخدمة';

  @override
  String get apptRowDate => 'التاريخ';

  @override
  String get apptRowTime => 'الوقت';

  @override
  String get apptSampleDate => 'السبت، ١٨ يوليو ٢٠٢٦';

  @override
  String get apptRejectTitle => 'سبب الرفض';

  @override
  String get apptRejectSub => 'مطلوب — سيظهر السبب للمريض';

  @override
  String get apptReasonFull => 'الجدول ممتلئ';

  @override
  String get apptReasonScope => 'خارج نطاق التخصص';

  @override
  String get apptReasonIncomplete => 'بيانات الطلب غير مكتملة';

  @override
  String get apptReasonOther => 'أخرى';

  @override
  String get apptRejectNoteHint => 'اكتب سبب الرفض...';

  @override
  String get apptRejectConfirm => 'تأكيد الرفض';

  @override
  String get apptRejectToast => 'تم رفض الموعد وإشعار المريض';

  @override
  String get apptFinishSubLab => 'أرفق نتيجة التحليل PDF مع ملاحظاتك';

  @override
  String get apptFinishSub => 'أضف ملاحظاتك ثم أكّد الإنهاء';

  @override
  String get apptUploadTitle => 'اضغط لرفع نتيجة التحليل (PDF)';

  @override
  String get apptUploadHint => 'الحد الأقصى ١٠ ميغابايت';

  @override
  String get apptFileName => 'lab-result.pdf';

  @override
  String get apptFileAttached => 'تم الإرفاق ✓ — اضغط للتغيير';

  @override
  String get apptFinishNoteHint => 'ملاحظات (اختياري)...';

  @override
  String get apptFinishConfirm => 'تأكيد الإنهاء';

  @override
  String get apptFinishConfirmLab => 'رفع النتيجة وإنهاء';

  @override
  String get apptFinishToast => 'تم إنهاء الموعد بنجاح';

  @override
  String get apptFinishToastLab => 'تم رفع النتيجة وإنهاء الموعد';

  @override
  String get appt1Name => 'أحمد محمد علي';

  @override
  String get appt1Service => 'فحص دم CBC (مختبر)';

  @override
  String get appt2Name => 'سارة يوسف';

  @override
  String get appt2Service => 'عيادة الأطفال - كشف دوري';

  @override
  String get appt3Name => 'محمود عبد الرحمن';

  @override
  String get appt3Service => 'أشعة سينية (X-Ray)';

  @override
  String get appt4Name => 'فاطمة الزهراني';

  @override
  String get appt4Service => 'استشارة قلب';

  @override
  String get appt5Name => 'خالد العتيبي';

  @override
  String get appt5Service => 'تحليل هرمونات';

  @override
  String get appt6Name => 'نورة القحطاني';

  @override
  String get appt6Service => 'فحص عيون';

  @override
  String get appt7Name => 'عبدالله الغامدي';

  @override
  String get appt7Service => 'فيتامين د';

  @override
  String get appt8Name => 'ريم الشهري';

  @override
  String get appt8Service => 'استشارة جلدية';

  @override
  String get appt9Name => 'سلطان الدوسري';

  @override
  String get appt9Service => 'تخطيط قلب ECG';

  @override
  String get settingsTitle => 'الإعدادات';

  @override
  String get settingsClinicName => 'عيادة الشفاء';

  @override
  String get settingsClinicEmail => 'info@alshifa-clinic.sa';

  @override
  String get settingsGroupAccount => 'الحساب';

  @override
  String get settingsGroupNotifications => 'الإشعارات';

  @override
  String get settingsGroupAppearance => 'المظهر';

  @override
  String get settingsGroupSupport => 'الدعم';

  @override
  String get settingsProfile => 'ملف العيادة';

  @override
  String get settingsProfileSub => 'معلومات المنشأة وصورة الغلاف';

  @override
  String get settingsPassword => 'كلمة المرور';

  @override
  String get settingsPasswordSub => 'تغيير كلمة المرور';

  @override
  String get settingsNotifApp => 'إشعارات التطبيق';

  @override
  String get settingsNotifEmail => 'إشعارات البريد الإلكتروني';

  @override
  String get settingsNotifSms => 'إشعارات الرسائل القصيرة';

  @override
  String get settingsLanguage => 'اللغة';

  @override
  String get settingsTheme => 'الثيم';

  @override
  String get settingsHelp => 'المساعدة والدعم';

  @override
  String get settingsHelpSub => 'أسئلة شائعة وتواصل مع الفريق';

  @override
  String get settingsPrivacy => 'سياسة الخصوصية';

  @override
  String get settingsAbout => 'حول التطبيق';

  @override
  String get settingsVersion => 'الإصدار ١.٠.٠';

  @override
  String get settingsLogout => 'تسجيل الخروج';

  @override
  String get settingsThemeSystem => 'نظام التشغيل';

  @override
  String get settingsThemeLight => 'فاتح';

  @override
  String get settingsThemeDark => 'داكن';

  @override
  String get settingsThemeSystemSub => 'يتبع إعدادات الجهاز';

  @override
  String get settingsThemeLightSub => 'واجهة فاتحة دائماً';

  @override
  String get settingsThemeDarkSub => 'واجهة داكنة دائماً';

  @override
  String get settingsLangAr => 'العربية';

  @override
  String get settingsLangArSub => 'Arabic';

  @override
  String get settingsLangEn => 'English';

  @override
  String get settingsLangEnSub => 'الإنجليزية';

  @override
  String get settingsProfileTitle => 'ملف العيادة';

  @override
  String get settingsProfileSave => 'حفظ';

  @override
  String get settingsCoverHint => 'صورة غلاف العيادة — اضغط لرفع صورة';

  @override
  String get settingsClinicInfo => 'معلومات العيادة';

  @override
  String get settingsContactInfo => 'بيانات التواصل';

  @override
  String get settingsInsurances => 'شركات التأمين المقبولة';

  @override
  String get settingsInsurancesLoading => 'جار تحميل شركات التأمين...';

  @override
  String get settingsInsurancesEmpty => 'لا توجد شركات تأمين متاحة';

  @override
  String get settingsFieldClinicName => 'اسم العيادة';

  @override
  String get settingsFieldAddress => 'عنوان العيادة';

  @override
  String get settingsFieldLicense => 'رقم الترخيص';

  @override
  String get settingsFieldEmail => 'البريد الإلكتروني';

  @override
  String get settingsFieldPhone => 'رقم الهاتف';

  @override
  String get settingsFieldWebsite => 'الموقع الإلكتروني';

  @override
  String get settingsPasswordTitle => 'تغيير كلمة المرور';

  @override
  String get settingsPasswordHero => 'أمان حسابك أولويتنا';

  @override
  String get settingsPasswordHint =>
      'يجب أن تكون كلمة المرور الجديدة ٨ أحرف على الأقل وتحتوي على أرقام وحروف';

  @override
  String get settingsPasswordCurrent => 'كلمة المرور الحالية';

  @override
  String get settingsPasswordNew => 'كلمة المرور الجديدة';

  @override
  String get settingsPasswordConfirm => 'تأكيد كلمة المرور';

  @override
  String get passwordStrengthLabel => 'قوة كلمة المرور:';

  @override
  String get passwordStrengthNone => 'أدخل كلمة مرور';

  @override
  String get passwordStrengthWeak => 'ضعيفة';

  @override
  String get passwordStrengthMedium => 'متوسطة';

  @override
  String get passwordStrengthStrong => 'قوية';

  @override
  String get settingsValueAddress => 'طريق الملك فهد، الرياض';

  @override
  String get settingsValueLicense => 'MC-2024-1234';

  @override
  String get settingsValuePhone => '+966 11 234 5678';

  @override
  String get settingsValueWebsite => 'www.alshifa-clinic.sa';

  @override
  String get settingsImageSoonTitle => 'الصورة';

  @override
  String get settingsImageSoonMessage => 'رفع الصور سيتوفر قريباً';

  @override
  String get settingsPasswordChanged => 'تم تغيير كلمة المرور بنجاح';

  @override
  String get mediaSourceTitle => 'اختر مصدر الصورة';

  @override
  String get mediaSourceCamera => 'الكاميرا';

  @override
  String get mediaSourceCameraSub => 'التقاط صورة جديدة';

  @override
  String get mediaSourceGallery => 'المعرض';

  @override
  String get mediaSourceGallerySub => 'اختيار من الصور المحفوظة';

  @override
  String get commonClose => 'إغلاق';

  @override
  String get servicesTitle => 'إدارة الخدمات';

  @override
  String servicesActiveLine(String count) {
    return '$count خدمة نشطة';
  }

  @override
  String get servicesLabTab => 'التحاليل المخبرية';

  @override
  String get servicesSpecialtyTab => 'التخصصات الطبية';

  @override
  String get servicesLabStat => 'تحاليل';

  @override
  String get servicesSpecialtyStat => 'تخصصات';

  @override
  String servicesTestsAvailable(String count) {
    return '$count تحاليل متاحة';
  }

  @override
  String get servicesSpecialtyLabel => 'تخصص طبي';

  @override
  String get servicesAddSection => 'إضافة قسم تحاليل';

  @override
  String get servicesAddSpecialty => 'إضافة تخصص';

  @override
  String get servicesAddSectionSub => 'اختر القسم لإضافته وإدارة أسعار تحاليله';

  @override
  String get servicesAddSpecialtyTitle => 'إضافة تخصص طبي';

  @override
  String get servicesAddSpecialtySub => 'اختر التخصص لإضافته إلى عيادتك';

  @override
  String get servicesAdded => 'مضاف';

  @override
  String get servicesEnabled => 'مفعّل';

  @override
  String get servicesDisabled => 'غير مفعّل';

  @override
  String get servicesCurrency => 'ر.س';

  @override
  String get servicesPriceHint => '٠';

  @override
  String get labSectionMarriage => 'فحص الزواج';

  @override
  String get labSectionHormones => 'الهرمونات';

  @override
  String get labSectionVitamins => 'الفيتامينات';

  @override
  String get testScd => 'الأنيميا المنجلية';

  @override
  String get testThal => 'الثلاسيميا';

  @override
  String get testHbv => 'التهاب الكبد B';

  @override
  String get testHcv => 'التهاب الكبد C';

  @override
  String get testHiv => 'فحص المناعة HIV';

  @override
  String get testTsh => 'الغدة الدرقية TSH';

  @override
  String get testTestosterone => 'هرمون التستوستيرون';

  @override
  String get testVitaminD => 'فيتامين د';

  @override
  String get testVitaminB12 => 'فيتامين ب١٢';

  @override
  String get serviceSubHereditary => 'فحص أمراض الدم الوراثية';

  @override
  String get serviceSubGenetic => 'فحص وراثي لخلايا الدم';

  @override
  String get serviceSubInfectious => 'فحص الفيروسات المعدية';

  @override
  String get serviceSubThyroid => 'وظائف الغدة الدرقية';

  @override
  String get serviceSubSexHormone => 'الهرمونات الجنسية';

  @override
  String get serviceSubVitaminD => 'مستوى فيتامين D3';

  @override
  String get serviceSubVitaminB12 => 'مستوى فيتامين B12';

  @override
  String get reportsTitle => 'التقارير';

  @override
  String reportsHeaderLine(String total, String done) {
    return '$total الإجمالي • $done مكتمل';
  }

  @override
  String get reportsPeriodWeek => 'أسبوعي';

  @override
  String get reportsPeriodMonth => 'شهري';

  @override
  String get reportsChartTitleWeek => 'الأداء الأسبوعي';

  @override
  String get reportsChartTitleMonth => 'الأداء الشهري';

  @override
  String get reportsChartSubWeek => 'توزيع المواعيد خلال الأسبوع';

  @override
  String get reportsChartSubMonth => 'توزيع المواعيد خلال الشهر';

  @override
  String get reportsTypeSection => 'نوع التقرير';

  @override
  String get reportsTypeAppointments => 'تقرير المواعيد';

  @override
  String get reportsTypeRevenue => 'تقرير الإيرادات';

  @override
  String get reportsTypeLabs => 'تقرير التحاليل';

  @override
  String get reportsOutcomeDone => 'مكتمل';

  @override
  String get reportsOutcomePending => 'قيد';

  @override
  String get reportsOutcomePendingLong => 'قيد المراجعة';

  @override
  String get reportsOutcomeCancelled => 'ملغي';

  @override
  String get reportsDaySat => 'س';

  @override
  String get reportsDaySun => 'ح';

  @override
  String get reportsDayMon => 'ن';

  @override
  String get reportsDayTue => 'ث';

  @override
  String get reportsDayWed => 'ر';

  @override
  String get reportsDayThu => 'خ';

  @override
  String get reportsDayFri => 'ج';

  @override
  String get reportsWeek1 => 'أسبوع ١';

  @override
  String get reportsWeek2 => 'أسبوع ٢';

  @override
  String get reportsWeek3 => 'أسبوع ٣';

  @override
  String get reportsWeek4 => 'أسبوع ٤';

  @override
  String get reportsExportPdf => 'تصدير PDF';

  @override
  String get reportsExportCsv => 'تصدير CSV';

  @override
  String get reportsExportSoonTitle => 'التصدير';

  @override
  String get reportsExportSoonMessage => 'سيتوفر تصدير التقارير قريباً';

  @override
  String get reportsListTitle => 'قائمة التقارير';

  @override
  String reportsCountLabel(String count, String label) {
    return '$count $label';
  }

  @override
  String reportsTotalLabel(String total) {
    return '$total الإجمالي';
  }

  @override
  String get report1Date => '18 Jul 2026 · 10:22 am';

  @override
  String get report2Date => '11 Jul 2026 · 10:22 am';

  @override
  String get report3Date => '04 Jul 2026 · 10:22 am';

  @override
  String get toastOtpSentSuccess => 'تم إرسال رمز التحقق بنجاح';

  @override
  String get toastSuccess => 'تم بنجاح';

  @override
  String get toastFailure => 'حدث خطأ';

  @override
  String get toastWarning => 'تنبيه';

  @override
  String shareAppText(String appLink) {
    return 'حمّل تطبيق عيادتي: $appLink';
  }

  @override
  String get noResultsFound => 'لا توجد نتائج';

  @override
  String get noDataYet => 'لا توجد بيانات بعد';

  @override
  String get coreUnsupportedType => 'نوع غير مدعوم';

  @override
  String get coreUnsupportedImageFormat => 'صيغة صورة غير مدعومة';

  @override
  String get requestTimeout => 'انتهت مهلة الطلب';

  @override
  String get noInternetConnection => 'لا يوجد اتصال بالإنترنت';

  @override
  String get sendTimeout => 'انتهت مهلة الإرسال';

  @override
  String get chatImageWithIcon => 'صورة';

  @override
  String get chatVideoWithIcon => 'فيديو';

  @override
  String get chatVoiceWithIcon => 'رسالة صوتية';

  @override
  String get chatFileWithIcon => 'ملف';

  @override
  String get legalCopied => 'تم النسخ إلى الحافظة';

  @override
  String get legalAboutIntro =>
      'منصة متكاملة لإدارة العيادات والمخابر الطبية في المملكة العربية السعودية، تربط بين مقدمي الرعاية الصحية والمرضى بتجربة رقمية سلسة وموثوقة.';

  @override
  String get legalAboutFeature1 => 'حجز وإدارة المواعيد';

  @override
  String get legalAboutFeature1Sub => 'تنظيم مواعيد المرضى والأطباء بسهولة';

  @override
  String get legalAboutFeature2 => 'نتائج المخبر الرقمية';

  @override
  String get legalAboutFeature2Sub => 'رفع ومشاركة تقارير التحاليل بأمان';

  @override
  String get legalAboutFeature3 => 'إدارة فريق الأطباء';

  @override
  String get legalAboutFeature3Sub => 'ملفات الأطباء وساعات العمل والخدمات';

  @override
  String get legalAboutFeature4 => 'أمان بمعايير عالية';

  @override
  String get legalAboutFeature4Sub =>
      'حماية بيانات المرضى وفق الأنظمة السعودية';

  @override
  String get legalAboutLinkWebsite => 'زيارة الموقع الإلكتروني';

  @override
  String get legalAboutCopyright => '© ٢٠٢٦ عيادتي. جميع الحقوق محفوظة';

  @override
  String get legalPrivacyUpdated => 'آخر تحديث: ١ يوليو ٢٠٢٦';

  @override
  String get legalPrivacy1 => 'جمع البيانات';

  @override
  String get legalPrivacy1Body =>
      'نجمع معلومات الحساب الأساسية (الاسم، البريد الإلكتروني، رقم الترخيص) والبيانات الطبية اللازمة لتقديم خدمات الحجز والمخبر، وفقاً لأنظمة حماية البيانات الشخصية في المملكة العربية السعودية.';

  @override
  String get legalPrivacy2 => 'استخدام البيانات';

  @override
  String get legalPrivacy2Body =>
      'تُستخدم بياناتك لتشغيل خدمات الحجز والتقارير والإشعارات فقط، ولا تتم مشاركتها مع أي طرف ثالث لأغراض تسويقية.';

  @override
  String get legalPrivacy3 => 'تخزين وحماية البيانات';

  @override
  String get legalPrivacy3Body =>
      'تُخزَّن جميع البيانات على خوادم مشفّرة داخل المملكة، مع ضوابط وصول صارمة تقتصر على الموظفين المخوّلين فقط.';

  @override
  String get legalPrivacy4 => 'حقوق المستخدم';

  @override
  String get legalPrivacy4Body =>
      'يحق لك في أي وقت طلب الاطلاع على بياناتك أو تعديلها أو حذف حسابك بالكامل من خلال التواصل مع فريق الدعم.';

  @override
  String get legalPrivacy5 => 'ملفات تعريف الارتباط';

  @override
  String get legalPrivacy5Body =>
      'يستخدم التطبيق تخزيناً محلياً محدوداً لحفظ تفضيلاتك (اللغة، الثيم) فقط، دون أي تتبع إعلاني.';

  @override
  String get legalContactTitle => 'تواصل معنا';

  @override
  String get legalContactPhone => 'الهاتف';

  @override
  String get legalContactPhoneValue => '+966 11 234 5678';

  @override
  String get legalContactEmail => 'البريد الإلكتروني';

  @override
  String get legalContactEmailValue => 'support@alshifa-clinic.sa';

  @override
  String get legalContactAddress => 'العنوان';

  @override
  String get legalContactAddressValue => 'طريق الملك فهد، الرياض';

  @override
  String get legalContactWhatsapp => 'واتساب';

  @override
  String get legalContactWhatsappValue => '+966 55 123 4567';

  @override
  String get legalContactHours =>
      'أوقات الدعم: من السبت للخميس، ٩ صباحاً — ٩ مساءً بتوقيت الرياض';

  @override
  String get legalContactFormTitle => 'أرسل لنا رسالة';

  @override
  String get legalContactName => 'الاسم الكامل';

  @override
  String get legalContactMessage => 'اكتب رسالتك هنا...';

  @override
  String get legalContactSend => 'إرسال الرسالة';

  @override
  String get legalContactSent => 'تم إرسال رسالتك، سنعود إليك قريباً';

  @override
  String get settingsPublishAd => 'نشر إعلان';

  @override
  String get settingsPublishAdSub => 'أنشئ إعلاناً لعرض خدماتك';

  @override
  String get adsCreateTitle => 'إعلان جديد';

  @override
  String get adsCreateSubtitle => 'سيُعرض بعد موافقة الإدارة';

  @override
  String get adsCoverLabel => 'صورة الإعلان';

  @override
  String get adsCoverPlaceholder => 'انقر لرفع صورة الإعلان';

  @override
  String get adsCoverHint => 'مقاس مقترح ١٢٠٠×٦٧٥، بحد أقصى ٥ ميجابايت';

  @override
  String get adsTitleLabel => 'عنوان الإعلان';

  @override
  String get adsTitleHint => 'مثال: خصم ٢٠٪ على تنظيف الأسنان';

  @override
  String get adsTitleArLabel => 'عنوان الإعلان بالعربية';

  @override
  String get adsTitleArHint => 'مثال: خصم ٢٠٪ على تنظيف الأسنان';

  @override
  String get adsTitleEnLabel => 'عنوان الإعلان بالإنجليزية';

  @override
  String get adsTitleEnHint => 'e.g. 20% off teeth cleaning';

  @override
  String get adsDescriptionLabel => 'الوصف';

  @override
  String get adsDescriptionHint =>
      'اكتب تفاصيل العرض أو الخدمة المُعلن عنها...';

  @override
  String get adsDescriptionArLabel => 'الوصف بالعربية';

  @override
  String get adsDescriptionArHint =>
      'اكتب تفاصيل العرض أو الخدمة المُعلن عنها...';

  @override
  String get adsDescriptionEnLabel => 'الوصف بالإنجليزية';

  @override
  String get adsDescriptionEnHint =>
      'Describe the offer or service you\'re advertising...';

  @override
  String adsCharCounter(int count, int max) {
    return '$count/$max';
  }

  @override
  String get adsReviewNote =>
      'تراجع الإدارة الإعلان خلال ٢٤ ساعة عادةً قبل نشره لجميع المستخدمين';

  @override
  String get adsSubmitCta => 'إرسال للمراجعة';

  @override
  String get adsSubmitFailedTitle => 'تعذر إرسال الإعلان';

  @override
  String get adsSubmittedTitle => 'تم إرسال الإعلان';

  @override
  String get adsSubmittedDesc =>
      'إعلانك الآن قيد المراجعة، وسيتم إشعارك فور اعتماده من قِبل الإدارة';

  @override
  String get adsComposeAnother => 'إنشاء إعلان آخر';
}
