import 'package:equatable/equatable.dart';

/// The ad being composed, plus whether it has been sent for review.
class CreateAdState extends Equatable {
  const CreateAdState({
    this.titleAr = '',
    this.titleEn = '',
    this.descriptionAr = '',
    this.descriptionEn = '',
    this.coverPath,
    this.isSubmitting = false,
    this.submitted = false,
    this.errorMessage = '',
  });

  final String titleAr;
  final String titleEn;
  final String descriptionAr;
  final String descriptionEn;

  /// Local path of the picked cover image; null until one is chosen.
  final String? coverPath;

  final bool isSubmitting;

  /// True once the ad is queued for admin review.
  final bool submitted;

  final String errorMessage;

  bool get canSubmit =>
      titleAr.trim().isNotEmpty &&
      titleEn.trim().isNotEmpty &&
      descriptionAr.trim().isNotEmpty &&
      descriptionEn.trim().isNotEmpty &&
      coverPath != null &&
      !isSubmitting;

  CreateAdState copyWith({
    String? titleAr,
    String? titleEn,
    String? descriptionAr,
    String? descriptionEn,
    String? coverPath,
    bool? isSubmitting,
    bool? submitted,
    String? errorMessage,
  }) => CreateAdState(
    titleAr: titleAr ?? this.titleAr,
    titleEn: titleEn ?? this.titleEn,
    descriptionAr: descriptionAr ?? this.descriptionAr,
    descriptionEn: descriptionEn ?? this.descriptionEn,
    coverPath: coverPath ?? this.coverPath,
    isSubmitting: isSubmitting ?? this.isSubmitting,
    submitted: submitted ?? this.submitted,
    errorMessage: errorMessage ?? this.errorMessage,
  );

  @override
  List<Object?> get props => [
    titleAr,
    titleEn,
    descriptionAr,
    descriptionEn,
    coverPath,
    isSubmitting,
    submitted,
    errorMessage,
  ];
}
