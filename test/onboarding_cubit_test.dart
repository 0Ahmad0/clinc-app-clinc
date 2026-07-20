import 'package:clinic_app/features/onboarding/presentation/cubit/onboarding_cubit.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('onboarding navigation stays in bounds', () {
    final cubit = OnboardingCubit();
    expect(cubit.state.index, 0);
    expect(cubit.isLastSlide, isFalse);

    cubit.next();
    expect(cubit.state.index, 1);

    // Skip jumps to the last slide.
    cubit.skip();
    expect(cubit.state.index, OnboardingCubit.slideCount - 1);
    expect(cubit.isLastSlide, isTrue);

    // next() past the end clamps instead of overflowing.
    cubit.next();
    expect(cubit.state.index, OnboardingCubit.slideCount - 1);

    // goTo clamps a negative index back to the first slide.
    cubit.goTo(-5);
    expect(cubit.state.index, 0);

    cubit.close();
  });
}
