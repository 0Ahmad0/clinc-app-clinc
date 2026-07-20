import 'package:equatable/equatable.dart';

/// Which onboarding slide is currently shown.
class OnboardingState extends Equatable {
  const OnboardingState({this.index = 0});

  final int index;

  OnboardingState copyWith({int? index}) =>
      OnboardingState(index: index ?? this.index);

  @override
  List<Object> get props => [index];
}
