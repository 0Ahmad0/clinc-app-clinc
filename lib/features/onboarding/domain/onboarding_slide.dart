import 'package:equatable/equatable.dart';

/// One onboarding page's content. Text is localized and supplied by the view
/// from `context.l10n`; the asset and chip icon are fixed per slide.
class OnboardingSlide extends Equatable {
  const OnboardingSlide({
    required this.asset,
    required this.chipIcon,
    required this.kicker,
    required this.title,
    required this.description,
    required this.chipTitle,
    required this.chipSubtitle,
  });

  final String asset;
  final String chipIcon;
  final String kicker;
  final String title;
  final String description;
  final String chipTitle;
  final String chipSubtitle;

  @override
  List<Object> get props => [
    asset,
    chipIcon,
    kicker,
    title,
    description,
    chipTitle,
    chipSubtitle,
  ];
}
