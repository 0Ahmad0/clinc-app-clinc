import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/data/doctor_model.dart';
import '../../../app/routes/app_routes.dart';

class DoctorsController extends GetxController {
  final RxList<DoctorModel> allDoctors       = <DoctorModel>[].obs;
  final RxList<DoctorModel> displayedDoctors = <DoctorModel>[].obs;
  final TextEditingController searchController = TextEditingController();
  final RxString selectedSpecialty = ''.obs;

  // ─── Computed ──────────────────────────────────────────────────────────────
  List<String> get specialties {
    final set = <String>{};
    for (final d in allDoctors) set.add(d.specialty);
    return set.toList();
  }

  // ─── Lifecycle ─────────────────────────────────────────────────────────────
  @override
  void onInit() {
    super.onInit();
    _loadMockData();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }

  // ─── Navigation ────────────────────────────────────────────────────────────
  void goToAddDoctor() => Get.toNamed(AppRoutes.addDoctor);

  // ─── Filtering ─────────────────────────────────────────────────────────────
  void runSearch(String query) => _applyFilters(query, selectedSpecialty.value);

  void filterBySpecialty(String specialty) {
    selectedSpecialty.value = specialty;
    _applyFilters(searchController.text, specialty);
  }

  void _applyFilters(String query, String specialty) {
    var list = allDoctors.toList();
    if (query.isNotEmpty) {
      list = list.where((d) => d.nameAr.contains(query) || d.specialty.contains(query)).toList();
    }
    if (specialty.isNotEmpty) {
      list = list.where((d) => d.specialty == specialty).toList();
    }
    displayedDoctors.assignAll(list);
  }

  // ─── Actions ───────────────────────────────────────────────────────────────
  void toggleStatus(String id) {
    final index = allDoctors.indexWhere((d) => d.id == id);
    if (index == -1) return;
    final doc = allDoctors[index];
    doc.isAvailable = !doc.isAvailable;
    allDoctors[index] = doc;
    _applyFilters(searchController.text, selectedSpecialty.value);
    update();
  }

  void deleteDoctor(String id) {
    allDoctors.removeWhere((d) => d.id == id);
    _applyFilters(searchController.text, selectedSpecialty.value);
    Get.back();
    Get.back();
    Get.snackbar(
      'تم الحذف', 'تم حذف الطبيب بنجاح',
      backgroundColor: const Color(0xFFF04438).withValues(alpha: 0.9),
      colorText: Colors.white,
      snackPosition: SnackPosition.TOP,
    );
  }

  /// Shows a confirmation dialog before deleting — no BuildContext needed (GetX).
  void showDeleteConfirm(DoctorModel doctor) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: const Row(
          children: [
            Icon(Icons.warning_rounded, color: Colors.red, size: 24),
            SizedBox(width: 8),
            Text('حذف الطبيب'),
          ],
        ),
        content: Text('هل أنت متأكد من حذف ${doctor.nameAr}؟'),
        actions: [
          TextButton(onPressed: Get.back, child: const Text('إلغاء')),
          ElevatedButton(
            onPressed: () => deleteDoctor(doctor.id!),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('حذف', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  // ─── Static Helpers ────────────────────────────────────────────────────────
  static String getInitials(String name) {
    final parts = name.replaceAll('د.', '').trim().split(' ');
    if (parts.length >= 2) return '${parts[0][0]}${parts[1][0]}';
    return parts[0].isNotEmpty ? parts[0][0] : '؟';
  }

  static Color specialtyColor(String specialty) {
    const map = <String, Color>{
      'أمراض القلب':      Color(0xFFEF4444),
      'الجلدية والتجميل': Color(0xFF8B5CF6),
      'طب الأطفال':       Color(0xFF3B82F6),
      'طب العيون':        Color(0xFF06B6D4),
      'العظام والمفاصل':  Color(0xFFF59E0B),
      'الأعصاب':          Color(0xFF009688),
    };
    return map[specialty] ?? const Color(0xFF6B7280);
  }

  // ─── Mock Data ─────────────────────────────────────────────────────────────
  void _loadMockData() {
    allDoctors.addAll([
      DoctorModel(
        id: '1', nameAr: 'د. أحمد محمد علي', nameEn: 'Dr. Ahmed Mohammed Ali',
        specialty: 'أمراض القلب', fee: 150.0, isAvailable: true,
        phone: '+963911000111', email: 'ahmed@clinic.com', licenseNumber: 'LIC-9920',
        yearsOfExperience: 12,
        about: 'طبيب متخصص في أمراض القلب والأوعية الدموية بخبرة 12 عاماً. حاصل على زمالة أمريكية في القسطرة القلبية.',
        imagePath: '', qualificationFiles: [], gender: 'Male',
        workingHours: [
          WorkingHours(day: 'saturday',  startTime: '09:00', endTime: '13:00'),
          WorkingHours(day: 'sunday',    startTime: '09:00', endTime: '13:00'),
          WorkingHours(day: 'monday',    startTime: '14:00', endTime: '19:00'),
          WorkingHours(day: 'tuesday',   startTime: '09:00', endTime: '13:00'),
          WorkingHours(day: 'wednesday', isDayOff: true),
          WorkingHours(day: 'thursday',  startTime: '14:00', endTime: '18:00'),
          WorkingHours(day: 'friday',    isDayOff: true),
        ],
      ),
      DoctorModel(
        id: '2', nameAr: 'د. سارة حسن', nameEn: 'Dr. Sarah Hassan',
        specialty: 'الجلدية والتجميل', fee: 200.0, isAvailable: true,
        phone: '+963922000222', email: 'sarah@clinic.com', licenseNumber: 'LIC-5541',
        yearsOfExperience: 7,
        about: 'أخصائية جلدية وتجميل وعلاج بالليزر. متخصصة في علاج حب الشباب والبقع الداكنة.',
        imagePath: '', qualificationFiles: [], gender: 'Female',
        workingHours: [
          WorkingHours(day: 'saturday',  isDayOff: true),
          WorkingHours(day: 'sunday',    startTime: '10:00', endTime: '15:00'),
          WorkingHours(day: 'monday',    startTime: '10:00', endTime: '15:00'),
          WorkingHours(day: 'tuesday',   startTime: '10:00', endTime: '15:00'),
          WorkingHours(day: 'wednesday', startTime: '10:00', endTime: '15:00'),
          WorkingHours(day: 'thursday',  startTime: '10:00', endTime: '15:00'),
          WorkingHours(day: 'friday',    isDayOff: true),
        ],
      ),
      DoctorModel(
        id: '3', nameAr: 'د. خالد العمري', nameEn: 'Dr. Khaled Al-Omari',
        specialty: 'طب الأطفال', fee: 120.0, isAvailable: true,
        phone: '+963933000333', email: 'khaled@clinic.com', licenseNumber: 'LIC-3312',
        yearsOfExperience: 9,
        about: 'طبيب أطفال متخصص في رعاية صحة الطفل من الولادة حتى سن المراهقة.',
        imagePath: '', qualificationFiles: [], gender: 'Male',
        workingHours: [
          WorkingHours(day: 'saturday',  startTime: '08:00', endTime: '14:00'),
          WorkingHours(day: 'sunday',    startTime: '08:00', endTime: '14:00'),
          WorkingHours(day: 'monday',    startTime: '08:00', endTime: '14:00'),
          WorkingHours(day: 'tuesday',   isDayOff: true),
          WorkingHours(day: 'wednesday', startTime: '08:00', endTime: '14:00'),
          WorkingHours(day: 'thursday',  startTime: '08:00', endTime: '14:00'),
          WorkingHours(day: 'friday',    isDayOff: true),
        ],
      ),
      DoctorModel(
        id: '4', nameAr: 'د. ليلى يوسف', nameEn: 'Dr. Layla Youssef',
        specialty: 'طب العيون', fee: 180.0, isAvailable: false,
        phone: '+963944000444', email: 'layla@clinic.com', licenseNumber: 'LIC-7723',
        yearsOfExperience: 15,
        about: 'أستاذة في طب وجراحة العيون بخبرة 15 عاماً. متخصصة في جراحة الليزيك وإزالة المياه البيضاء.',
        imagePath: '', qualificationFiles: [], gender: 'Female',
        workingHours: [
          WorkingHours(day: 'saturday',  startTime: '10:00', endTime: '14:00'),
          WorkingHours(day: 'sunday',    isDayOff: true),
          WorkingHours(day: 'monday',    startTime: '10:00', endTime: '14:00'),
          WorkingHours(day: 'tuesday',   startTime: '10:00', endTime: '14:00'),
          WorkingHours(day: 'wednesday', isDayOff: true),
          WorkingHours(day: 'thursday',  startTime: '10:00', endTime: '16:00'),
          WorkingHours(day: 'friday',    isDayOff: true),
        ],
      ),
      DoctorModel(
        id: '5', nameAr: 'د. عمر الشريف', nameEn: 'Dr. Omar Al-Sharif',
        specialty: 'العظام والمفاصل', fee: 160.0, isAvailable: true,
        phone: '+963955000555', email: 'omar@clinic.com', licenseNumber: 'LIC-2241',
        yearsOfExperience: 11,
        about: 'جراح عظام ومفاصل. خبير في العمليات المنظارية وزراعة المفاصل الصناعية.',
        imagePath: '', qualificationFiles: [], gender: 'Male',
        workingHours: [
          WorkingHours(day: 'saturday',  startTime: '09:00', endTime: '15:00'),
          WorkingHours(day: 'sunday',    startTime: '09:00', endTime: '15:00'),
          WorkingHours(day: 'monday',    isDayOff: true),
          WorkingHours(day: 'tuesday',   startTime: '09:00', endTime: '15:00'),
          WorkingHours(day: 'wednesday', startTime: '09:00', endTime: '15:00'),
          WorkingHours(day: 'thursday',  isDayOff: true),
          WorkingHours(day: 'friday',    isDayOff: true),
        ],
      ),
    ]);
    displayedDoctors.assignAll(allDoctors);
  }
}
