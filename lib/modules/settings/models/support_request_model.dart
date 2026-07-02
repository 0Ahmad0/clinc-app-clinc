class SupportRequestModel {
  const SupportRequestModel({
    required this.requestId,
    required this.subject,
    required this.description,
    required this.imagePaths,
    required this.status,
  });

  final String requestId;
  final String subject;
  final String description;
  final List<String> imagePaths;
  final String status;

  factory SupportRequestModel.fromJson(Map<String, dynamic> json) {
    return SupportRequestModel(
      requestId: json['request_id'].toString(),
      subject: json['subject'] as String,
      description: json['description'] as String,
      imagePaths: (json['images'] as List? ?? const [])
          .map((item) => item.toString())
          .toList(),
      status: json['status'] as String? ?? 'pending',
    );
  }
}
