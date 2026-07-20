import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/auth_layer.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import '../widgets/forgot_layer.dart';
import '../widgets/login_layer.dart';
import '../widgets/pending_layer.dart';
import '../widgets/signup_layer.dart';

/// Hosts the auth design and cross-fades between its four layers.
class AuthView extends StatelessWidget {
  const AuthView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: SafeArea(
        child: BlocBuilder<AuthCubit, AuthState>(
          buildWhen: (previous, current) => previous.layer != current.layer,
          builder: (context, state) {
            final child = switch (state.layer) {
              AuthLayer.login => const LoginLayer(
                key: ValueKey(AuthLayer.login),
              ),
              AuthLayer.signup => const SignupLayer(
                key: ValueKey(AuthLayer.signup),
              ),
              AuthLayer.forgot => const ForgotLayer(
                key: ValueKey(AuthLayer.forgot),
              ),
              AuthLayer.pending => const PendingLayer(
                key: ValueKey(AuthLayer.pending),
              ),
            };

            return AnimatedSwitcher(
              duration: AppMotion.fade,
              switchInCurve: AppMotion.emphasized,
              switchOutCurve: AppMotion.emphasized,
              child: child,
            );
          },
        ),
      ),
    );
  }
}
