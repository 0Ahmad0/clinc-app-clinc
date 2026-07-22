import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/auth_layer.dart';
import '../../domain/auth_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'auth_back_button.dart';
import 'auth_pulse_badge.dart';
import 'auth_text_field.dart';

/// The forgot-password layer: hero lock, explainer, info note, identifier field
/// and the send CTA.
class ForgotLayer extends StatefulWidget {
  const ForgotLayer({super.key});

  @override
  State<ForgotLayer> createState() => ForgotLayerState();
}

class ForgotLayerState extends State<ForgotLayer> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final cubit = context.read<AuthCubit>();

    return Form(
      key: formKey,
      child: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.lg,
            AppSpacing.xl,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - AppSpacing.xxl,
            ),
            child: IntrinsicHeight(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: AuthBackButton(
                      onTap: () => cubit.show(AuthLayer.login),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  const Center(
                    child: AuthPulseBadge(
                      icon: Iconsax.lock,
                      shapeSize: 92,
                      haloSize: 116,
                      iconSize: 42,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.authForgotTitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.headlineMedium?.copyWith(
                      fontSize: 24,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.authForgotDesc,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodySmall?.copyWith(
                      fontSize: 14.5,
                      color: colors.gray,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  _InfoNote(text: l10n.authForgotInfo),
                  const SizedBox(height: AppSpacing.sm),
                  AuthTextField(
                    controller: emailController,
                    hint: l10n.authForgotFieldHint,
                    icon: Iconsax.sms,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.done,
                    validator: (value) =>
                        AuthValidators.required(value, l10n.validationRequired),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading ||
                        previous.action != current.action,
                    builder: (context, state) => AppButton(
                      label: l10n.authForgotCta,
                      onPressed:
                          state.isLoading &&
                              state.action == AuthAction.forgotPassword
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState?.validate() ?? false) {
                                cubit.forgotPassword(
                                  email: emailController.text,
                                );
                              }
                            },
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(height: AppSpacing.md),
                  Center(
                    child: TextButton(
                      onPressed: () => cubit.show(AuthLayer.login),
                      style: TextButton.styleFrom(
                        foregroundColor: colors.gray,
                        textStyle: context.textTheme.bodyMedium,
                      ),
                      child: Text(l10n.authBackToLogin),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _InfoNote extends StatelessWidget {
  const _InfoNote({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.primary500.withValues(alpha: 0.07),
        borderRadius: BorderRadius.circular(AppRadius.field - 2),
        border: Border.all(color: colors.primary500.withValues(alpha: 0.18)),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Iconsax.lamp_on, size: 17, color: colors.primary600),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(color: colors.slate),
            ),
          ),
        ],
      ),
    );
  }
}
