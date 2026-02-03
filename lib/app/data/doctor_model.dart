class DoctorModel {
  final int id;
  final String name;
  final String specialty;
  final String hospital;
  final String? image;
  final bool isActive;
  final String license;
  final String phone;
  final String email;
  final int experience;
  final String about;
  final List<String>? qualifications;
  final List<String>? workingDays;
  final String? workingHours;

  DoctorModel({
    required this.id,
    required this.name,
    required this.specialty,
    required this.hospital,
    this.image,
    required this.isActive,
    required this.license,
    required this.phone,
    required this.email,
    required this.experience,
    required this.about,
    this.qualifications,
    this.workingDays,
    this.workingHours,
  });

  // تحويل من Map إلى DoctorModel
  factory DoctorModel.fromMap(Map<String, dynamic> map) {
    return DoctorModel(
      id: map['id'],
      name: map['name'],
      specialty: map['specialty'],
      hospital: map['hospital'] ?? 'غير محدد',
      image: map['image'],
      isActive: map['isActive'] ?? true,
      license: map['license'] ?? 'غير محدد',
      phone: map['phone'] ?? 'غير محدد',
      email: map['email'] ?? 'غير محدد',
      experience: map['experience'] ?? 0,
      about: map['about'] ?? '',
      qualifications: map['qualifications'] != null
          ? List<String>.from(map['qualifications'])
          : null,
      workingDays: map['workingDays'] != null
          ? List<String>.from(map['workingDays'])
          : null,
      workingHours: map['workingHours'],
    );
  }

  // تحويل إلى Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'specialty': specialty,
      'hospital': hospital,
      'image': image,
      'isActive': isActive,
      'license': license,
      'phone': phone,
      'email': email,
      'experience': experience,
      'about': about,
      'qualifications': qualifications,
      'workingDays': workingDays,
      'workingHours': workingHours,
    };
  }
}