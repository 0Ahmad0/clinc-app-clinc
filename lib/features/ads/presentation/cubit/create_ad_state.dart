import 'package:equatable/equatable.dart';

/// The ad being composed, plus whether it has been sent for review.
class CreateAdState extends Equatable {
  const CreateAdState({
    this.title = '',
    this.description = '',
    this.coverPath,
    this.submitted = false,
  });

  final String title;
  final String description;

  /// Local path of the picked cover image; null until one is chosen.
  final String? coverPath;

  /// True once the ad is queued for admin review.
  final bool submitted;

  /// The cover is optional — an ad needs at least a title and a description.
  bool get canSubmit =>
      title.trim().isNotEmpty && description.trim().isNotEmpty;

  CreateAdState copyWith({
    String? title,
    String? description,
    String? coverPath,
    bool? submitted,
  }) => CreateAdState(
    title: title ?? this.title,
    description: description ?? this.description,
    coverPath: coverPath ?? this.coverPath,
    submitted: submitted ?? this.submitted,
  );

  @override
  List<Object?> get props => [title, description, coverPath, submitted];
}
