import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../cubit/onboarding_cubit.dart';
import 'onboarding_view.dart';

/// Route entry point: provides the [OnboardingCubit] and renders the view.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<OnboardingCubit>(),
      child: const OnboardingView(),
    );
  }
}
