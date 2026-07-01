class PendingApprovalModel {
  const PendingApprovalModel({
    required this.status,
    required this.needsCompletion,
    this.rejectionReason,
  });

  final String status;
  final bool needsCompletion;
  final String? rejectionReason;

  factory PendingApprovalModel.fromJson(Map<String, dynamic> json) {
    return PendingApprovalModel(
      status: json['status'] as String,
      needsCompletion: json['needs_completion'] as bool? ?? true,
      rejectionReason: json['rejection_reason'] as String?,
    );
  }
}
