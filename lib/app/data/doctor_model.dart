class WorkingHours {
  String day;
  String? startTime;
  String? endTime;
  bool isDayOff;

  WorkingHours({
    required this.day,
    this.startTime,
    this.endTime,
    this.isDayOff = false,
  });

}

class DoctorModel {
  String? id;
  String imagePath;
  String nameAr;
  String nameEn;
  String specialty;
  double fee;
  String gender; // 'Male' or 'Female'
  String licenseNumber;
  int yearsOfExperience;
  String about;
  String phone;
  String email;
  List<String> qualificationFiles; // مسارات ملفات PDF
  bool isAvailable;
  List<WorkingHours> workingHours;

  DoctorModel({
    this.id,
    required this.imagePath,
    required this.nameAr,
    required this.nameEn,
    required this.specialty,
    required this.fee,
    required this.gender,
    required this.licenseNumber,
    required this.yearsOfExperience,
    required this.about,
    required this.phone,
    required this.email,
    required this.qualificationFiles,
    required this.isAvailable,
    required this.workingHours,
  });
}
