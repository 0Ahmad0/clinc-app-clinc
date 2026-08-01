import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/form_validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_password_strength.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../domain/auth_layer.dart';
import '../cubit/auth_cubit.dart';
import 'auth_back_button.dart';
import 'auth_pulse_badge.dart';
import 'auth_text_field.dart';

/// The choose-a-new-password layer, reached once a reset code is verified: hero
/// lock, the two password fields, a live strength meter and the save CTA, which
/// stays disabled until the pair is long enough and matching.
class ResetPasswordLayer extends StatefulWidget {
  const ResetPasswordLayer({super.key});

  @override
  State<ResetPasswordLayer> createState() => _ResetPasswordLayerState();
}

class _ResetPasswordLayerState extends State<ResetPasswordLayer> {
  final _next = TextEditingController();
  final _confirm = TextEditingController();

  @override
  void dispose() {
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  bool get _mismatch => _confirm.text.isNotEmpty && _next.text != _confirm.text;

  bool get _canSubmit =>
      _next.text.length >= FormValidators.minPasswordLength &&
      _next.text == _confirm.text;

  void _submit() {
    FocusScope.of(context).unfocus();
    AppToast.show(
      context,
      title: context.l10n.authResetTitle,
      message: context.l10n.authResetDone,
      type: AppFeedbackType.success,
    );
    context.read<AuthCubit>().completeReset();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final cubit = context.read<AuthCubit>();

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: AlignmentDirectional.centerStart,
            child: AuthBackButton(onTap: () => cubit.show(AuthLayer.otp)),
          ),
          const SizedBox(height: AppSpacing.md),
          const Center(
            child: AuthPulseBadge(
              icon: Iconsax.lock_1,
              shapeSize: 92,
              haloSize: 116,
              iconSize: 42,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.authResetTitle,
            textAlign: TextAlign.center,
            style: context.textTheme.headlineMedium?.copyWith(fontSize: 24),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.authResetDesc(FormValidators.minPasswordLength),
            textAlign: TextAlign.center,
            style: context.textTheme.bodySmall?.copyWith(
              fontSize: 14.5,
              color: colors.gray,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          AuthTextField(
            controller: _next,
            hint: l10n.authResetNewHint,
            icon: Iconsax.lock,
            obscure: true,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.sm),
          AuthTextField(
            controller: _confirm,
            hint: l10n.authConfirmPasswordHint,
            icon: Iconsax.key,
            obscure: true,
            textInputAction: TextInputAction.done,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: AppSpacing.sm),
          AppPasswordStrength(level: AppPasswordStrength.levelOf(_next.text)),
          if (_mismatch) ...[
            const SizedBox(height: AppSpacing.xs),
            Text(
              l10n.validationPasswordMismatch,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.danger,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: l10n.authResetCta,
            onPressed: _canSubmit ? _submit : null,
          ),
        ],
      ),
    );
  }
}
