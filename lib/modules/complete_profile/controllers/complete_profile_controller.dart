import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart'; // Uncomment when installing
import '../models/day_schedule_model.dart';

class CompleteProfileController extends GetxController {
  // ── Form Controllers ──
  final TextEditingController phoneController = TextEditingController();

  // ── State Variables ──
  final RxString selectedSpecialty = ''.obs;
  final Rxn<String> profileImagePath = Rxn<String>(); // مسار الصورة
  final Rxn<String> bannerImagePath = Rxn<String>();
  final RxBool isLoading = false.obs;

  // قائمة الاختصاصات (تجريبية)
  final List<String> specialties = ['Dentist', 'Dermatologist', 'Cardiologist', 'General'];

  // ── Schedule Logic ──
  // نملأ الأيام افتراضياً
  final RxList<DaySchedule> weekSchedule = <DaySchedule>[
    DaySchedule(dayKey: 'sat'),
    DaySchedule(dayKey: 'sun'),
    DaySchedule(dayKey: 'mon'),
    DaySchedule(dayKey: 'tue'),
    DaySchedule(dayKey: 'wed'),
    DaySchedule(dayKey: 'thu'),
    DaySchedule(dayKey: 'fri', isDayOff: true), // الجمعة عطلة افتراضية
  ].obs;

  // ── Actions ──

  // اختيار صورة (محاكاة)
  Future<void> pickImage(bool isBanner) async {
    // final ImagePicker picker = ImagePicker();
    // final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    // if (image != null) {
    //   if (isBanner) bannerImagePath.value = image.path;
    //   else profileImagePath.value = image.path;
    // }
    print("Picking image for ${isBanner ? 'Banner' : 'Profile'}");
  }

  // تحديث وقت (من/إلى)
  Future<void> pickTime(BuildContext context, int index, bool isStart) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      String formatted = picked.format(context);
      var day = weekSchedule[index];
      if (isStart) day.startTime = formatted;
      else day.endTime = formatted;
      weekSchedule.refresh(); // لتحديث الواجهة
    }
  }

  void toggleDayOff(int index, bool val) {
    weekSchedule[index].isDayOff = val;
    weekSchedule.refresh();
  }

  Future<void> saveDataAndFinish() async {
    isLoading.value = true;
    await Future.delayed(const Duration(seconds: 2));

    // TODO: Send data to API
    // IMPORTANT: Set 'isProfileCompleted' = true in User Model locally

    isLoading.value = false;
    // Get.offAllNamed(Routes.HOME);
  }

  void skip() {
    // TODO: Set 'isProfileCompleted' = false
    // Get.offAllNamed(Routes.HOME);
  }
}