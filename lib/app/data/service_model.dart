class ServiceModel {
  final String id;
  final String name;
  final String specialtyId;
  final String specialtyName;
  final double price;
  final int durationMin;
  final bool isActive;

  ServiceModel({
    required this.id,
    required this.name,
    required this.specialtyId,
    required this.specialtyName,
    required this.price,
    required this.durationMin,
    this.isActive = true,
  });
}
