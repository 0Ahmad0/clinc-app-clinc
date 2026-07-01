enum ClinicServiceTab { lab, medical }

class LabTestOption {
  const LabTestOption({
    required this.id,
    required this.name,
    this.icon,
    required this.price,
    required this.isEnabled,
  });

  final String id;
  final String name;
  final String? icon;
  final num price;
  final bool isEnabled;

  factory LabTestOption.fromJson(Map<String, dynamic> json) {
    return LabTestOption(
      id: json['test_id'].toString(),
      name: json['name'] as String,
      icon: json['icon'] as String?,
      price: json['price'] as num? ?? 0,
      isEnabled: json['is_enabled'] as bool? ?? false,
    );
  }

  LabTestOption copyWith({num? price, bool? isEnabled}) {
    return LabTestOption(
      id: id,
      name: name,
      icon: icon,
      price: price ?? this.price,
      isEnabled: isEnabled ?? this.isEnabled,
    );
  }
}

class ClinicServiceSection {
  const ClinicServiceSection({
    required this.id,
    required this.nameAr,
    required this.nameEn,
    this.icon,
    required this.isAdded,
    required this.hasDoctor,
    required this.tests,
  });

  final String id;
  final String nameAr;
  final String nameEn;
  final String? icon;
  final bool isAdded;
  final bool hasDoctor;
  final List<LabTestOption> tests;

  int get enabledTestsCount => tests.where((test) => test.isEnabled).length;

  factory ClinicServiceSection.fromJson(Map<String, dynamic> json) {
    return ClinicServiceSection(
      id: json['section_id'].toString(),
      nameAr: json['name_ar'] as String? ?? json['name'] as String,
      nameEn:
          json['name_en'] as String? ??
          json['name_ar'] as String? ??
          json['name'] as String,
      icon: json['icon'] as String?,
      isAdded: json['is_added'] as bool? ?? false,
      hasDoctor: json['has_doctor'] as bool? ?? true,
      tests: (json['tests'] as List? ?? const [])
          .map(
            (item) =>
                LabTestOption.fromJson(Map<String, dynamic>.from(item as Map)),
          )
          .toList(),
    );
  }

  ClinicServiceSection copyWith({bool? isAdded, List<LabTestOption>? tests}) {
    return ClinicServiceSection(
      id: id,
      nameAr: nameAr,
      nameEn: nameEn,
      icon: icon,
      isAdded: isAdded ?? this.isAdded,
      hasDoctor: hasDoctor,
      tests: tests ?? this.tests,
    );
  }
}
