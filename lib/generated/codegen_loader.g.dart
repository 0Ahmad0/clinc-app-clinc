// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _ar = {
  "splash": {
    "welcome": "مرحباً بك في عيادتك",
    "loading": "جاري التحميل...",
    "powered_by": "بواسطة مهندسي البرمجيات"
  },
  "onboarding": {
    "skip": "تخطي",
    "next": "التالي",
    "get_started": "ابدأ الآن",
    "titles": {
      "0": "إدارة مواعيدك بذكاء",
      "1": "فريقك الطبي في مكان واحد",
      "2": "تقارير وتحليلات دقيقة"
    },
    "descriptions": {
      "0": "نظم جدول مواعيد المرضى، قلل وقت الانتظار، وارفع كفاءة عيادتك بلمسة واحدة.",
      "1": "أضف الأطباء، حدد تخصصاتهم وأوقات عملهم، وتابع أداءهم بسهولة تامة.",
      "2": "راقب نمو عيادتك من خلال تقارير مفصلة عن الدخل، أعداد المرضى، والخدمات الأكثر طلباً."
    }
  },
  "register": {
    "title": "إنشاء حساب",
    "subtitle": "أنشئ حساب منشأتك الطبية",
    "fields": {
      "clinic_name": "اسم المنشأة",
      "clinic_name_hint": "مثال: عيادة الشفاء / مخبر الأمل",
      "license_number": "رقم الترخيص",
      "license_hint": "رقم الترخيص المعتمد",
      "account_type": "نوع الحساب",
      "password": "كلمة المرور",
      "confirm_password": "تأكيد كلمة المرور"
    },
    "account_type": {
      "clinic": "عيادة مستقلة",
      "clinic_with_lab": "عيادة تحتوي مخبر",
      "lab": "مخبر مستقل"
    },
    "buttons": {
      "submit": "إرسال للتدقيق",
      "login_text": "لديك حساب بالفعل؟",
      "login_action": "تسجيل الدخول"
    },
    "messages": {
      "required_field": "هذا الحقل مطلوب",
      "password_mismatch": "كلمتا المرور غير متطابقتين",
      "type_required": "اختر نوع الحساب"
    }
  },
  "login": {
    "title": "تسجيل الدخول",
    "subtitle": "مرحباً بعودتك، نتمنى لك يوماً مثمراً",
    "fields": {
      "identifier": "البريد الإلكتروني أو رقم الترخيص",
      "identifier_hint": "أدخل البريد أو رقم الترخيص",
      "password": "كلمة المرور",
      "forgot_password": "هل نسيت كلمة المرور؟"
    },
    "buttons": {
      "login": "دخول",
      "register_text": "ليس لديك حساب عيادة؟",
      "register_action": "إنشاء حساب جديد"
    },
    "messages": {
      "success": "تم تسجيل الدخول بنجاح",
      "required_field": "هذا الحقل مطلوب"
    }
  },
  "forgot_password": {
    "title": "نسيت كلمة المرور؟",
    "subtitle": "لا تقلق! يحدث ذلك. الرجاء إدخال البريد الإلكتروني أو رقم الترخيص المرتبط بحسابك.",
    "fields": {
      "identifier": "البريد الإلكتروني أو رقم الترخيص",
      "identifier_hint": "مثال: info@clinic.com"
    },
    "buttons": {
      "submit": "إرسال رمز التحقق",
      "back_to_login": "العودة لتسجيل الدخول"
    },
    "messages": {
      "success": "تم إرسال رابط الاستعادة بنجاح، تفقد بريدك الوارد.",
      "required_field": "الرجاء إدخال البيانات المطلوبة"
    }
  },
  "otp": {
    "title": "التحقق من الرمز",
    "subtitle": "لقد أرسلنا رمز تحقق مكون من 4 أرقام إلى",
    "buttons": {
      "verify": "تحقق الآن",
      "resend": "إعادة إرسال الرمز",
      "resend_wait": "إعادة الإرسال بعد"
    },
    "messages": {
      "success": "تم التحقق بنجاح!",
      "resend_success": "تم إرسال رمز جديد",
      "invalid_code": "الرمز غير صحيح"
    }
  },
  "pending_approval": {
    "title": "طلبك قيد المراجعة",
    "subtitle": "شكراً لانضمامك إلينا!",
    "description": "يقوم فريق الإدارة حالياً بالتحقق من بيانات العيادة ورقم الترخيص الطبي.\nتستغرق هذه العملية عادةً أقل من 24 ساعة.",
    "buttons": {
      "check_status": "تحديث الحالة",
      "contact_support": "تواصل مع الدعم",
      "logout": "تسجيل الخروج"
    },
    "messages": {
      "still_pending": "الطلب لا يزال قيد المراجعة، يرجى الانتظار.",
      "approved": "تمت الموافقة! جاري تحويلك..."
    }
  },
  "complete_profile": {
    "title": "إعداد العيادة",
    "skip": "تخطي الآن",
    "sections": {
      "images": "المظهر العام",
      "info": "المعلومات الأساسية",
      "schedule": "أوقات الدوام"
    },
    "fields": {
      "banner_hint": "اضغط لإضافة صورة غلاف",
      "specialty": "الاختصاص الطبي",
      "specialty_hint": "اختر الاختصاص",
      "phone": "رقم هاتف العيادة",
      "phone_hint": "للتواصل مع المرضى"
    },
    "schedule": {
      "day_off": "عطلة",
      "working": "دوام",
      "from": "من",
      "to": "إلى",
      "days": {
        "sat": "السبت",
        "sun": "الأحد",
        "mon": "الاثنين",
        "tue": "الثلاثاء",
        "wed": "الأربعاء",
        "thu": "الخميس",
        "fri": "الجمعة"
      }
    },
    "buttons": {
      "save_finish": "حفظ وإنهاء"
    }
  },
  "home": {
    "incomplete_profile_alert": {
      "title": "ملفك غير مكتمل!",
      "message": "للحصول على حجوزات أكثر، يرجى استكمال صور العيادة وأوقات الدوام.",
      "action": "أكمل الآن"
    }
  },
  "nav": {
    "dashboard": "الرئيسية",
    "doctors": "الأطباء",
    "services": "الخدمات",
    "appointments": "المواعيد",
    "reports": "التقارير"
  },
  "dashboard": {
    "welcome": "مرحباً",
    "stats": {
      "doctors": "طبيب",
      "reports": "تقرير",
      "appointments": "موعد",
      "services": "خدمة"
    },
    "todays_appointments": "مواعيد اليوم",
    "view_all": "عرض الكل",
    "status": {
      "upcoming": "قادم",
      "cancelled": "ملغي",
      "completed": "مكتمل"
    }
  },
  "alerts": {
    "incomplete_profile_blocking": "عذراً! لا يمكنك إدارة {section} قبل استكمال بيانات العيادة.",
    "complete_now": "استكمال الملف"
  },
  "doctors_page": {
    "title": "الأطباء",
    "add_button": "إضافة طبيب جديد",
    "registered_title": "الأطباء المسجلين",
    "status": {
      "active": "نشط",
      "inactive": "غير نشط"
    },
    "details": "تفاصيل الطبيب"
  },
  "add_doctor": {
    "title": "إضافة طبيب جديد",
    "buttons": {
      "cancel": "إلغاء",
      "save": "حفظ"
    },
    "labels": {
      "full_name": "الاسم الكامل",
      "name_hint": "أدخل اسم الطبيب الكامل",
      "specialty": "التخصص",
      "specialty_hint": "اختر تخصص الطبيب",
      "gender": "الجنس",
      "gmale": "ذكر",
      "gfemale": "أنثى",
      "license": "رقم الترخيص",
      "license_hint": "أدخل رقم الترخيص الطبي",
      "hospital": "المستشفى/العيادة",
      "hospital_hint": "أدخل اسم المستشفى أو العيادة",
      "phone": "رقم الهاتف",
      "phone_hint": "أدخل رقم الهاتف",
      "email": "البريد الإلكتروني",
      "email_hint": "أدخل البريد الإلكتروني",
      "experience": "سنوات الخبرة",
      "experience_hint": "أدخل عدد سنوات الخبرة",
      "qualifications": "المؤهلات العلمية",
      "qualification_hint": "أضف مؤهل علمي",
      "add_qualification": "إضافة مؤهل",
      "about": "نبذة عن الطبيب",
      "about_hint": "أضف معلومات عن الطبيب",
      "active": "الحالة",
      "work_hours": "ساعات العمل",
      "image_title": "صورة الطبيب",
      "upload_drag_drop": "اسحب وأفلت الصورة هنا",
      "upload_or": "أو",
      "upload_browse": "تصفح الملفات",
      "upload_support": "يدعم JPG, PNG"
    },
    "schedule": {
      "day_off": "عطلة",
      "days": {
        "mon": "الإثنين",
        "tue": "الثلاثاء",
        "wed": "الأربعاء",
        "thu": "الخميس",
        "fri": "الجمعة",
        "sat": "السبت",
        "sun": "الأحد"
      }
    },
    "messages": {
      "success": "تم إضافة الطبيب بنجاح",
      "error": "حدث خطأ أثناء إضافة الطبيب"
    }
  },
  "services_module": {
    "title": "إدارة الخدمات",
    "tabs": {
      "services": "قائمة الخدمات",
      "specialties": "التخصصات / الأقسام"
    },
    "buttons": {
      "add_service": "إضافة خدمة جديدة",
      "add_specialty": "إضافة تخصص جديد"
    },
    "labels": {
      "name": "الاسم",
      "name_hint": "مثال: قلبية، تحليل دم...",
      "description": "الوصف",
      "price": "السعر",
      "duration": "المدة (دقيقة)",
      "select_specialty": "تابع للقسم",
      "select_icon": "اختر أيقونة معبرة",
      "status": "الحالة"
    },
    "cards": {
      "min": "دقيقة",
      "currency": "ريال"
    },
    "forms": {
      "save": "حفظ التغييرات",
      "create": "إضافة جديد",
      "edit_title": "تعديل {name}",
      "add_title": "إضافة {name}",
      "name_label": "الاسم",
      "desc_label": "الوصف",
      "price_label": "السعر",
      "duration_label": "المدة (دقيقة)",
      "category_label": "القسم التابع له",
      "icon_label": "أيقونة القسم",
      "color_label": "لون التمييز",
      "active_label": "الخدمة متاحة (نشطة)",
      "validation": {
        "required": "هذا الحقل مطلوب"
      },
      "success_add": "تمت الإضافة بنجاح",
      "success_edit": "تم التعديل بنجاح"
    }
  },
  "appointments": {
    "title": "المواعيد",
    "search_hint": "بحث عن موعد أو مريض...",
    "tabs": {
      "all": "الكل",
      "pending": "قيد المراجعة",
      "approved": "مؤكدة",
      "completed": "مكتملة",
      "rejected": "مرفوضة"
    },
    "empty": {
      "title": "لا توجد مواعيد",
      "subtitle": "لم يتم العثور على أي مواعيد تطابق معايير البحث"
    },
    "card": {
      "patient": "المريض",
      "service": "الخدمة",
      "type": "النوع",
      "time": "الوقت"
    },
    "type": {
      "consultation": "استشارة",
      "service": "خدمة",
      "lab_test": "تحليل مخبري"
    },
    "status": {
      "pending": "قيد المراجعة",
      "approved": "مؤكد",
      "completed": "مكتمل",
      "rejected": "مرفوض"
    },
    "details": {
      "title": "تفاصيل الموعد",
      "patient_info": "معلومات المريض",
      "appointment_info": "معلومات الموعد",
      "notes": "ملاحظات",
      "add_notes": "أضف ملاحظات هنا...",
      "result": "نتيجة التحليل",
      "result_missing": "لم يتم رفع نتيجة التحليل بعد",
      "result_uploaded": "تم رفع نتيجة التحليل"
    },
    "actions": {
      "approve": "موافقة",
      "reject": "رفض",
      "complete": "إنهاء الموعد",
      "upload_result": "رفع نتيجة التحليل (PDF)",
      "view_result": "عرض الملف",
      "save": "حفظ"
    },
    "reject": {
      "title": "سبب الرفض",
      "reason_label": "اختر سبباً",
      "other": "أخرى",
      "note_label": "اكتب السبب بالتفصيل",
      "note_hint": "مثال: الطبيب غير متوفر في هذا الوقت",
      "reasons": {
        "doctor_unavailable": "الطبيب غير متوفر",
        "clinic_closed": "العيادة مغلقة",
        "invalid_booking": "حجز غير صحيح",
        "need_more_info": "نحتاج معلومات إضافية"
      },
      "validation": {
        "reason_required": "اختر سبباً",
        "note_required": "اكتب سبب الرفض"
      }
    },
    "upload": {
      "title": "رفع نتيجة التحليل",
      "pick_pdf": "اختيار ملف PDF",
      "selected_file": "الملف المختار",
      "no_file": "لا يوجد ملف",
      "uploading": "جارٍ الرفع...",
      "validation": {
        "pdf_required": "الرجاء اختيار ملف PDF"
      },
      "success": "تم رفع النتيجة بنجاح"
    },
    "messages": {
      "approved": "تمت الموافقة على الموعد",
      "rejected": "تم رفض الموعد",
      "completed": "تم إنهاء الموعد",
      "error": "حدث خطأ، حاول مرة أخرى"
    }
  },
  "reports": {
    "title": "التقارير",
    "actions_save": "",
    "filters": {
      "type": "نوع التقرير",
      "range": "الفترة",
      "today": "اليوم",
      "week": "هذا الأسبوع",
      "month": "هذا الشهر",
      "custom": "مخصص"
    },
    "types": {
      "appointments": "تقرير المواعيد",
      "revenue": "تقرير الإيرادات",
      "lab_results": "تقرير التحاليل",
      "doctors": "تقرير الأطباء"
    },
    "sections": {
      "summary": "ملخص",
      "list": "قائمة التقارير"
    },
    "cards": {
      "total": "الإجمالي",
      "completed": "مكتمل",
      "cancelled": "ملغي",
      "pending": "قيد المراجعة"
    },
    "details": {
      "title": "تفاصيل التقرير",
      "generated_at": "تاريخ الإنشاء",
      "download_pdf": "تحميل PDF",
      "view_pdf": "عرض PDF",
      "visual_summary": "ملخص مرئي",
      "notes": "ملاحظات",
      "add_notes": "أضف ملاحظاتك هنا..."
    },
    "actions": {
      "generate": "إنشاء تقرير جديد",
      "save": "حفظ",
      "view_pdf": "عرض PDF"
    },
    "messages": {
      "empty": "لا توجد تقارير",
      "empty_title": "لم يتم إنشاء أي تقارير بعد",
      "empty_subtitle": "يمكنك إنشاء تقرير جديد بالضغط على الزر أدناه"
    }
  },
  "notifications": {
    "title": "الإشعارات",
    "mark_all_read": "قراءة الكل",
    "delete_all": "حذف الكل",
    "confirm_mark_all_read": "هل تريد وضع جميع الإشعارات كمقروءة؟",
    "confirm_delete_all": "هل تريد حذف جميع الإشعارات؟",
    "confirm": "تأكيد",
    "cancel": "إلغاء",
    "delete": "حذف",
    "empty_title": "لا توجد إشعارات",
    "empty_subtitle": "ستظهر الإشعارات الجديدة هنا عندما تتلقاها"
  },
  "settings": {
    "title": "الإعدادات",
    "sections": {
      "account": "الحساب",
      "notifications": "الإشعارات",
      "appearance": "المظهر",
      "support": "الدعم"
    },
    "profile": "الملف الشخصي",
    "profile_subtitle": "تعديل معلوماتك الشخصية",
    "profile_name": "الاسم الكامل",
    "profile_email": "البريد الإلكتروني",
    "profile_phone": "رقم الهاتف",
    "profile_clinic_name": "اسم العيادة",
    "profile_clinic_address": "عنوان العيادة",
    "profile_license": "رقم الترخيص الطبي",
    "edit_profile": "تعديل الملف الشخصي",
    "password": "كلمة المرور",
    "password_subtitle": "تغيير كلمة المرور",
    "app_notifications": "إشعارات التطبيق",
    "email_notifications": "إشعارات البريد الإلكتروني",
    "sms_notifications": "إشعارات الرسائل القصيرة",
    "language": "اللغة",
    "theme": "الثيم",
    "theme_system": "نظام التشغيل",
    "theme_light": "فاتح",
    "theme_dark": "داكن",
    "help": "المساعدة",
    "contact_support": "تواصل مع الدعم",
    "privacy_policy": "سياسة الخصوصية",
    "about": "حول التطبيق",
    "logout": "تسجيل الخروج",
    "confirm_logout": "هل أنت متأكد أنك تريد تسجيل الخروج؟",
    "save": "حفظ",
    "cancel": "إلغاء",
    "close": "إغلاق",
    "confirm": "تأكيد",
    "validation_required": "هذا الحقل مطلوب",
    "validation_invalid_email": "البريد الإلكتروني غير صالح"
  }
};
static const Map<String,dynamic> _en = {
  "splash": {
    "welcome": "Welcome to Your Clinic",
    "loading": "Loading...",
    "powered_by": "Powered by Software Engineers"
  },
  "onboarding": {
    "skip": "Skip",
    "next": "Next",
    "get_started": "Get Started",
    "titles": {
      "0": "Smart Appointment Management",
      "1": "Your Medical Team in One Place",
      "2": "Accurate Reports and Analytics"
    },
    "descriptions": {
      "0": "Organize patient schedules, reduce waiting times, and boost your clinic's efficiency with one tap.",
      "1": "Add doctors, specify their specialties and working hours, and monitor their performance effortlessly.",
      "2": "Track your clinic's growth with detailed reports on income, patient numbers, and most requested services."
    }
  },
  "register": {
    "title": "Create Account",
    "subtitle": "Create your medical facility account",
    "fields": {
      "clinic_name": "Facility Name",
      "clinic_name_hint": "e.g. Al-Shifa Clinic / Hope Lab",
      "license_number": "License Number",
      "license_hint": "Official license number",
      "account_type": "Account Type",
      "password": "Password",
      "confirm_password": "Confirm Password"
    },
    "account_type": {
      "clinic": "Clinic Only",
      "clinic_with_lab": "Clinic With Lab",
      "lab": "Lab Only"
    },
    "buttons": {
      "submit": "Submit for Review",
      "login_text": "Already have an account?",
      "login_action": "Login"
    },
    "messages": {
      "required_field": "This field is required",
      "password_mismatch": "Passwords do not match",
      "type_required": "Please select account type"
    }
  },
  "login": {
    "title": "Login",
    "subtitle": "Welcome back, have a productive day",
    "fields": {
      "identifier": "Email or License Number",
      "identifier_hint": "Enter email or license number",
      "password": "Password",
      "forgot_password": "Forgot Password?"
    },
    "buttons": {
      "login": "Login",
      "register_text": "Don't have a clinic account?",
      "register_action": "Create New Account"
    },
    "messages": {
      "success": "Logged in successfully",
      "required_field": "This field is required"
    }
  },
  "forgot_password": {
    "title": "Forgot Password?",
    "subtitle": "Don't worry! It happens. Please enter the email or license number associated with your account.",
    "fields": {
      "identifier": "Email or License Number",
      "identifier_hint": "e.g. info@clinic.com"
    },
    "buttons": {
      "submit": "Send Verification Code",
      "back_to_login": "Back to Login"
    },
    "messages": {
      "success": "Reset link sent successfully, please check your inbox.",
      "required_field": "Please enter the required data"
    }
  },
  "otp": {
    "title": "Verification Code",
    "subtitle": "We have sent a 4-digit verification code to",
    "buttons": {
      "verify": "Verify Now",
      "resend": "Resend Code",
      "resend_wait": "Resend in"
    },
    "messages": {
      "success": "Verified successfully!",
      "resend_success": "New code sent",
      "invalid_code": "Invalid code"
    }
  },
  "pending_approval": {
    "title": "Under Review",
    "subtitle": "Thanks for joining us!",
    "description": "Our team is currently verifying the clinic details and medical license.\nThis process usually takes less than 24 hours.",
    "buttons": {
      "check_status": "Refresh Status",
      "contact_support": "Contact Support",
      "logout": "Logout"
    },
    "messages": {
      "still_pending": "Application is still pending, please wait.",
      "approved": "Approved! Redirecting..."
    }
  },
  "complete_profile": {
    "title": "Clinic Setup",
    "skip": "Skip for now",
    "sections": {
      "images": "Appearance",
      "info": "Basic Info",
      "schedule": "Working Hours"
    },
    "fields": {
      "banner_hint": "Tap to add banner",
      "specialty": "Medical Specialty",
      "specialty_hint": "Select specialty",
      "phone": "Clinic Phone",
      "phone_hint": "For patient contact"
    },
    "schedule": {
      "day_off": "Off",
      "working": "Open",
      "from": "From",
      "to": "To",
      "days": {
        "sat": "Saturday",
        "sun": "Sunday",
        "mon": "Monday",
        "tue": "Tuesday",
        "wed": "Wednesday",
        "thu": "Thursday",
        "fri": "Friday"
      }
    },
    "buttons": {
      "save_finish": "Save & Finish"
    }
  },
  "home": {
    "incomplete_profile_alert": {
      "title": "Profile Incomplete!",
      "message": "To get more bookings, please complete your clinic photos and schedule.",
      "action": "Complete Now"
    }
  },
  "nav": {
    "dashboard": "Dashboard",
    "doctors": "Doctors",
    "services": "Services",
    "appointments": "Appointments",
    "reports": "Reports"
  },
  "dashboard": {
    "welcome": "Welcome",
    "stats": {
      "doctors": "Doctors",
      "reports": "Reports",
      "appointments": "Appointments",
      "services": "Services"
    },
    "todays_appointments": "Today's Appointments",
    "view_all": "View All",
    "status": {
      "upcoming": "Upcoming",
      "cancelled": "Cancelled",
      "completed": "Completed"
    }
  },
  "alerts": {
    "incomplete_profile_blocking": "Sorry! You cannot manage {section} before completing the clinic profile.",
    "complete_now": "Complete Now"
  },
  "doctors_page": {
    "title": "Doctors",
    "add_button": "Add New Doctor",
    "registered_title": "Registered Doctors",
    "status": {
      "active": "Active",
      "inactive": "Inactive"
    },
    "details": "Doctor Details"
  },
  "add_doctor": {
    "title": "Add New Doctor",
    "buttons": {
      "cancel": "Cancel",
      "save": "Save"
    },
    "labels": {
      "full_name": "Full Name",
      "name_hint": "Enter doctor's full name",
      "specialty": "Specialty",
      "specialty_hint": "Select doctor's specialty",
      "gender": "Gender",
      "gmale": "Male",
      "gfemale": "Female",
      "license": "License Number",
      "license_hint": "Enter medical license number",
      "hospital": "Hospital/Clinic",
      "hospital_hint": "Enter hospital or clinic name",
      "phone": "Phone Number",
      "phone_hint": "Enter phone number",
      "email": "Email Address",
      "email_hint": "Enter email address",
      "experience": "Years of Experience",
      "experience_hint": "Enter number of years of experience",
      "qualifications": "Academic Qualifications",
      "qualification_hint": "Add academic qualification",
      "add_qualification": "Add Qualification",
      "about": "About the Doctor",
      "about_hint": "Add information about the doctor",
      "active": "Status",
      "work_hours": "Working Hours",
      "image_title": "Doctor's Photo",
      "upload_drag_drop": "Drag and drop image here",
      "upload_or": "or",
      "upload_browse": "Browse files",
      "upload_support": "Supports JPG, PNG"
    },
    "schedule": {
      "day_off": "Day Off",
      "days": {
        "mon": "Monday",
        "tue": "Tuesday",
        "wed": "Wednesday",
        "thu": "Thursday",
        "fri": "Friday",
        "sat": "Saturday",
        "sun": "Sunday"
      }
    },
    "messages": {
      "success": "Doctor added successfully",
      "error": "An error occurred while adding the doctor"
    }
  },
  "services_module": {
    "title": "Services Management",
    "tabs": {
      "services": "Service List",
      "specialties": "Specialties"
    },
    "buttons": {
      "add_service": "Add New Service",
      "add_specialty": "Add New Specialty"
    },
    "labels": {
      "name": "Name",
      "name_hint": "e.g. Cardiology, Blood Test...",
      "description": "Description",
      "price": "Price",
      "duration": "Duration (min)",
      "select_specialty": "Department",
      "select_icon": "Select Icon",
      "status": "Status"
    },
    "cards": {
      "min": "min",
      "currency": "SR"
    },
    "forms": {
      "save": "Save Changes",
      "create": "Create New",
      "edit_title": "Edit {name}",
      "add_title": "Add {name}",
      "name_label": "Name",
      "desc_label": "Description",
      "price_label": "Price",
      "duration_label": "Duration (min)",
      "category_label": "Department",
      "icon_label": "Department Icon",
      "color_label": "Highlight Color",
      "active_label": "Service Available (Active)",
      "validation": {
        "required": "Field required"
      },
      "success_add": "Added Successfully",
      "success_edit": "Updated Successfully"
    }
  },
  "appointments": {
    "title": "Appointments",
    "tabs": {
      "all": "All",
      "pending": "Pending",
      "approved": "Approved",
      "completed": "Completed",
      "rejected": "Rejected"
    },
    "search_hint": "Search for appointment or patient...",
    "card": {
      "patient": "Patient",
      "service": "Service",
      "type": "Type",
      "time": "Time"
    },
    "type": {
      "consultation": "Consultation",
      "service": "Service",
      "lab_test": "Lab Test"
    },
    "empty": {
      "title": "No Appointments",
      "subtitle": "No appointments found matching the search criteria"
    },
    "status": {
      "pending": "Pending",
      "approved": "Approved",
      "completed": "Completed",
      "rejected": "Rejected"
    },
    "details": {
      "title": "Appointment Details",
      "patient_info": "Patient Info",
      "appointment_info": "Appointment Info",
      "result": "Lab Result",
      "notes": "Notes",
      "add_notes": "Add notes here...",
      "result_missing": "Lab result not uploaded yet",
      "result_uploaded": "Lab result uploaded"
    },
    "actions": {
      "approve": "Approve",
      "reject": "Reject",
      "complete": "Complete",
      "upload_result": "Upload Lab Result (PDF)",
      "view_result": "View File",
      "save": "Save"
    },
    "reject": {
      "title": "Rejection Reason",
      "reason_label": "Select a reason",
      "other": "Other",
      "note_label": "Write the reason",
      "note_hint": "e.g. Doctor is unavailable at this time",
      "reasons": {
        "doctor_unavailable": "Doctor unavailable",
        "clinic_closed": "Clinic closed",
        "invalid_booking": "Invalid booking",
        "need_more_info": "Need more information"
      },
      "validation": {
        "reason_required": "Please select a reason",
        "note_required": "Please write the rejection reason"
      }
    },
    "upload": {
      "title": "Upload Lab Result",
      "pick_pdf": "Pick PDF File",
      "selected_file": "Selected file",
      "no_file": "No file selected",
      "uploading": "Uploading...",
      "validation": {
        "pdf_required": "Please select a PDF file"
      },
      "success": "Result uploaded successfully"
    },
    "messages": {
      "approved": "Appointment approved",
      "rejected": "Appointment rejected",
      "completed": "Appointment completed",
      "error": "Something went wrong"
    }
  },
  "reports": {
    "title": "Reports",
    "filters": {
      "type": "Report Type",
      "range": "Range",
      "today": "Today",
      "week": "This Week",
      "month": "This Month",
      "custom": "Custom"
    },
    "types": {
      "appointments": "Appointments Report",
      "revenue": "Revenue Report",
      "lab_results": "Lab Results Report",
      "doctors": "Doctors Report"
    },
    "sections": {
      "summary": "Summary",
      "list": "Reports List"
    },
    "cards": {
      "total": "Total",
      "completed": "Completed",
      "cancelled": "Cancelled",
      "pending": "Pending"
    },
    "details": {
      "title": "Report Details",
      "generated_at": "Generated at",
      "download_pdf": "Download PDF",
      "visual_summary": "Visual Summary",
      "notes": "Notes",
      "add_notes": "Add your notes here..."
    },
    "actions": {
      "generate": "Generate New Report",
      "save": "Save",
      "view_pdf": "View PDF"
    },
    "messages": {
      "empty": "No Reports",
      "empty_title": "No reports have been created yet",
      "empty_subtitle": "You can create a new report by clicking the button below"
    }
  },
  "notifications": {
    "title": "Notifications",
    "mark_all_read": "Mark All as Read",
    "delete_all": "Delete All",
    "confirm_mark_all_read": "Do you want to mark all notifications as read?",
    "confirm_delete_all": "Do you want to delete all notifications?",
    "confirm": "Confirm",
    "cancel": "Cancel",
    "delete": "Delete",
    "empty_title": "No notifications",
    "empty_subtitle": "New notifications will appear here when you receive them"
  },
  "settings": {
    "title": "Settings",
    "sections": {
      "account": "Account",
      "notifications": "Notifications",
      "appearance": "Appearance",
      "support": "Support"
    },
    "profile": "Profile",
    "profile_subtitle": "Edit your personal information",
    "profile_name": "Full Name",
    "profile_email": "Email Address",
    "profile_phone": "Phone Number",
    "profile_clinic_name": "Clinic Name",
    "profile_clinic_address": "Clinic Address",
    "profile_license": "Medical License Number",
    "edit_profile": "Edit Profile",
    "password": "Password",
    "password_subtitle": "Change your password",
    "app_notifications": "App Notifications",
    "email_notifications": "Email Notifications",
    "sms_notifications": "SMS Notifications",
    "language": "Language",
    "theme": "Theme",
    "theme_system": "System Default",
    "theme_light": "Light",
    "theme_dark": "Dark",
    "help": "Help",
    "contact_support": "Contact Support",
    "privacy_policy": "Privacy Policy",
    "about": "About App",
    "logout": "Logout",
    "confirm_logout": "Are you sure you want to logout?",
    "save": "Save",
    "cancel": "Cancel",
    "close": "Close",
    "confirm": "Confirm",
    "validation_required": "This field is required",
    "validation_invalid_email": "Invalid email address"
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
