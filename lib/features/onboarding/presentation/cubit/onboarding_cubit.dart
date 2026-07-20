import 'package:flutter_bloc/flutter_bloc.dart';

import 'onboarding_state.dart';

/// Drives the current onboarding slide. Navigation on finish is the UI's call
/// (there is no next screen yet), so this only moves between slides.
class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  static const int slideCount = 3;

  bool get isLastSlide => state.index == slideCount - 1;

  void goTo(int index) =>
      emit(state.copyWith(index: index.clamp(0, slideCount - 1)));

  void next() => goTo(state.index + 1);

  /// Skip jumps straight to the final slide (matches the design).
  void skip() => goTo(slideCount - 1);
}
