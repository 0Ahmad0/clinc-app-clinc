class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatar;
  final String clinicName;
  final String clinicAddress;
  final String? licenseNumber;

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    required this.clinicName,
    required this.clinicAddress,
    this.licenseNumber,
  });

  // نسخة افتراضية للاختبار
  static ProfileModel get mock => ProfileModel(
    id: 'u1',
    name: 'د. أحمد خالد',
    email: 'ahmed.khaled@clinic.com',
    phone: '+963 999 123 456',
    avatar: null,
    clinicName: 'عيادة الشفاء الطبية',
    clinicAddress: 'دمشق، شارع المزرعة، بناية 5',
    licenseNumber: 'SY-MED-2023-12345',
  );
}