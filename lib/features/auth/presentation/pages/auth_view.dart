import 'package:clinic_app/core/helper/response_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_motion.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
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
        child: BlocListener<AuthCubit, AuthState>(
          listenWhen: (previous, current) =>
              previous.isLoading != current.isLoading ||
              previous.message != current.message ||
              previous.failure != current.failure,
          listener: (context, state) {
            final failure = state.failure;
            if (failure != null) {
              ResponseHelper.onFailure(
                message: NetworkExceptions.getErrorMessage(failure),
              );
              // AppToast.show(
              //   context,
              //   title: context.l10n.toastFailure,
              //   message: NetworkExceptions.getErrorMessage(failure),
              //   type: AppFeedbackType.danger,
              // );
              return;
            }


            final message = state.message;
            if (!state.isLoading && message != null && message.isNotEmpty) {
              ResponseHelper.onSuccess(message: message);
              // AppToast.show(
              //   context,
              //   title: context.l10n.toastSuccess,
              //   message: message,
              //   type: AppFeedbackType.success,
              // );
            }

            if (!state.isLoading &&
                state.action == AuthAction.login &&
                state.login?.token != null) {
              context.go(AppRoutes.home);
            }
          },
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
      ),
    );
  }
}
