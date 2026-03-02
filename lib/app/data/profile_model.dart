class ProfileModel {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String? avatar;
  final String clinicName;
  final String clinicAddress;
  final String? licenseNumber;

  // ========== NEW FIELDS ==========
  final String? bio; // Bio/Description of the clinic
  final String? website; // Clinic website
  final String? specialty; // Doctor's specialty
  final DateTime? joinedDate; // Account creation date
  final bool? isVerified; // Verification status
  final int? totalAppointments; // Total appointments count
  final int? totalPatients; // Total patients count
  final double? rating; // Average rating

  ProfileModel({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    this.avatar,
    required this.clinicName,
    required this.clinicAddress,
    this.licenseNumber,
    this.bio,
    this.website,
    this.specialty,
    this.joinedDate,
    this.isVerified,
    this.totalAppointments,
    this.totalPatients,
    this.rating,
  });

  // ========== From JSON ==========
  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      avatar: json['avatar'] as String?,
      clinicName: json['clinicName'] as String,
      clinicAddress: json['clinicAddress'] as String,
      licenseNumber: json['licenseNumber'] as String?,
      bio: json['bio'] as String?,
      website: json['website'] as String?,
      specialty: json['specialty'] as String?,
      joinedDate: json['joinedDate'] != null
          ? DateTime.parse(json['joinedDate'] as String)
          : null,
      isVerified: json['isVerified'] as bool?,
      totalAppointments: json['totalAppointments'] as int?,
      totalPatients: json['totalPatients'] as int?,
      rating: json['rating'] != null
          ? (json['rating'] as num).toDouble()
          : null,
    );
  }

  // ========== To JSON ==========
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'avatar': avatar,
      'clinicName': clinicName,
      'clinicAddress': clinicAddress,
      'licenseNumber': licenseNumber,
      'bio': bio,
      'website': website,
      'specialty': specialty,
      'joinedDate': joinedDate?.toIso8601String(),
      'isVerified': isVerified,
      'totalAppointments': totalAppointments,
      'totalPatients': totalPatients,
      'rating': rating,
    };
  }

  // ========== Copy With ==========
  ProfileModel copyWith({
    String? id,
    String? name,
    String? email,
    String? phone,
    String? avatar,
    String? clinicName,
    String? clinicAddress,
    String? licenseNumber,
    String? bio,
    String? website,
    String? specialty,
    DateTime? joinedDate,
    bool? isVerified,
    int? totalAppointments,
    int? totalPatients,
    double? rating,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatar: avatar ?? this.avatar,
      clinicName: clinicName ?? this.clinicName,
      clinicAddress: clinicAddress ?? this.clinicAddress,
      licenseNumber: licenseNumber ?? this.licenseNumber,
      bio: bio ?? this.bio,
      website: website ?? this.website,
      specialty: specialty ?? this.specialty,
      joinedDate: joinedDate ?? this.joinedDate,
      isVerified: isVerified ?? this.isVerified,
      totalAppointments: totalAppointments ?? this.totalAppointments,
      totalPatients: totalPatients ?? this.totalPatients,
      rating: rating ?? this.rating,
    );
  }

  // ========== Mock Data for Testing ==========
  static ProfileModel get mock => ProfileModel(
    id: '1',
    name: 'Dr. Ahmed Hassan',
    email: 'dr.ahmed@clinicapp.com',
    phone: '+966 50 123 4567',
    avatar: null,
    clinicName: 'Hassan Medical Center',
    clinicAddress: 'King Fahd Road, Riyadh, Saudi Arabia',
    licenseNumber: 'MC-2024-1234',
    bio: 'Experienced family physician with over 15 years of practice. '
        'Specialized in preventive medicine and chronic disease management. '
        'Committed to providing compassionate and comprehensive healthcare to all patients.',
    website: 'https://hassanmedical.com',
    specialty: 'Family Medicine',
    joinedDate: DateTime(2024, 1, 15),
    isVerified: true,
    totalAppointments: 128,
    totalPatients: 45,
    rating: 4.8,
  );

  // ========== Helper Methods ==========

  /// Get initials from name (e.g., "Ahmed Hassan" -> "AH")
  String get initials {
    if (name.isEmpty) return '?';
    final parts = name.split(' ');
    if (parts.length == 1) {
      return parts[0][0].toUpperCase();
    }
    return '${parts[0][0]}${parts[parts.length - 1][0]}'.toUpperCase();
  }

  /// Check if profile is complete
  bool get isProfileComplete {
    return name.isNotEmpty &&
        email.isNotEmpty &&
        phone.isNotEmpty &&
        clinicName.isNotEmpty &&
        clinicAddress.isNotEmpty &&
        (licenseNumber?.isNotEmpty ?? false) &&
        (bio?.isNotEmpty ?? false);
  }

  /// Calculate profile completion percentage
  int get completionPercentage {
    int completed = 0;
    int total = 9;

    if (name.isNotEmpty) completed++;
    if (email.isNotEmpty) completed++;
    if (phone.isNotEmpty) completed++;
    if (clinicName.isNotEmpty) completed++;
    if (clinicAddress.isNotEmpty) completed++;
    if (licenseNumber?.isNotEmpty ?? false) completed++;
    if (bio?.isNotEmpty ?? false) completed++;
    if (avatar != null) completed++;
    if (specialty?.isNotEmpty ?? false) completed++;

    return ((completed / total) * 100).round();
  }

  /// Format rating with star emoji
  String get ratingDisplay {
    if (rating == null) return 'N/A';
    return '⭐ ${rating!.toStringAsFixed(1)}';
  }

  /// Format joined date
  String get joinedDateDisplay {
    if (joinedDate == null) return 'N/A';
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${months[joinedDate!.month - 1]} ${joinedDate!.year}';
  }

  @override
  String toString() {
    return 'ProfileModel(id: $id, name: $name, email: $email, '
        'clinicName: $clinicName, completion: $completionPercentage%)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is ProfileModel &&
        other.id == id &&
        other.email == email;
  }

  @override
  int get hashCode => id.hashCode ^ email.hashCode;
}