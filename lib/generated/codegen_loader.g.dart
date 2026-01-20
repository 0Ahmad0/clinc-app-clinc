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
    "title": "إنشاء حساب عيادة",
    "subtitle": "سجل الآن وابدأ في إدارة عيادتك بذكاء",
    "fields": {
      "clinic_name": "اسم العيادة",
      "clinic_name_hint": "مثال: عيادة الشفاء",
      "license_number": "رقم الترخيص",
      "license_hint": "رقم الترخيص الطبي المعتمد",
      "password": "كلمة المرور",
      "confirm_password": "تأكيد كلمة المرور"
    },
    "buttons": {
      "submit": "إرسال للتدقيق",
      "login_text": "لديك حساب بالفعل؟",
      "login_action": "تسجيل الدخول"
    },
    "messages": {
      "success": "تم الإرسال بنجاح، بانتظار موافقة الإدارة",
      "password_mismatch": "كلمتا المرور غير متطابقتين",
      "required_field": "هذا الحقل مطلوب"
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
    "labels": {
      "full_name": "الاسم الكامل",
      "name_hint": "مثال: د. محمد الأحمد",
      "specialty": "التخصص",
      "specialty_hint": "اختر التخصص",
      "gender": "الجنس",
      "license": "رقم الترخيص الطبي",
      "license_hint": "رقم الترخيص",
      "image_title": "الصورة الشخصية",
      "work_hours": "أيام وساعات العمل"
    },
    "gender": {
      "gmale": "ذكر",
      "gfemale": "أنثى"
    },
    "upload": {
      "drag_drop": "اسحب و أفلت الصورة هنا",
      "or": "أو",
      "browse": "اختر ملف",
      "support": "PNG, JPG, GIF up to 10MB"
    },
    "buttons": {
      "save": "حفظ",
      "cancel": "إلغاء"
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
    "title": "Create Clinic Account",
    "subtitle": "Register now and manage your clinic smartly",
    "fields": {
      "clinic_name": "Clinic Name",
      "clinic_name_hint": "e.g. Al-Shifa Clinic",
      "license_number": "License Number",
      "license_hint": "Approved medical license number",
      "password": "Password",
      "confirm_password": "Confirm Password"
    },
    "buttons": {
      "submit": "Submit for Review",
      "login_text": "Already have an account?",
      "login_action": "Login"
    },
    "messages": {
      "success": "Submitted successfully, awaiting admin approval",
      "password_mismatch": "Passwords do not match",
      "required_field": "This field is required"
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
    "labels": {
      "full_name": "Full Name",
      "name_hint": "e.g. Dr. John Doe",
      "specialty": "Specialty",
      "specialty_hint": "Select Specialty",
      "gender": "Gender",
      "license": "Medical License Number",
      "license_hint": "License Number",
      "image_title": "Profile Picture",
      "work_hours": "Working Days & Hours"
    },
    "gender": {
      "gmale": "Male",
      "gfemale": "Female"
    },
    "upload": {
      "drag_drop": "Drag & Drop image here",
      "or": "or",
      "browse": "Browse File",
      "support": "PNG, JPG, GIF up to 10MB"
    },
    "buttons": {
      "save": "Save",
      "cancel": "Cancel"
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
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ar": _ar, "en": _en};
}
