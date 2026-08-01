import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:pinput/pinput.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../domain/auth_identifier.dart';
import '../../domain/auth_layer.dart';
import '../cubit/auth_cubit.dart';
import 'auth_back_button.dart';
import 'auth_pulse_badge.dart';

/// Number of digits in a verification code.
const _codeLength = 4;

/// How long before a new code can be requested.
const _resendCooldown = Duration(seconds: 45);

/// The verification-code layer, shared by signup and forgot-password: hero mail
/// badge, the masked destination, a [Pinput] code field, the confirm CTA and a
/// resend action gated by a countdown.
class OtpLayer extends StatefulWidget {
  const OtpLayer({super.key});

  @override
  State<OtpLayer> createState() => _OtpLayerState();
}

class _OtpLayerState extends State<OtpLayer> {
  final _controller = TextEditingController();
  Timer? _timer;
  int _secondsLeft = _resendCooldown.inSeconds;

  bool get _canResend => _secondsLeft <= 0;
  bool get _isComplete => _controller.text.length == _codeLength;

  @override
  void initState() {
    super.initState();
    _startCountdown();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      setState(() => _secondsLeft--);
      if (_canResend) timer.cancel();
    });
  }

  void _resend() {
    _controller.clear();
    setState(() => _secondsLeft = _resendCooldown.inSeconds);
    _startCountdown();
    AppToast.show(
      context,
      title: context.l10n.authOtpTitle,
      message: context.l10n.authOtpResent,
      type: AppFeedbackType.success,
    );
  }

  // ponytail: no backend yet, so a full code is a valid code — reject it here
  // once verification is wired and surface the error through the pin theme.
  void _verify() {
    FocusScope.of(context).unfocus();
    context.read<AuthCubit>().verifyOtp();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final cubit = context.read<AuthCubit>();
    final state = cubit.state;

    return LayoutBuilder(
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
                    onTap: () => cubit.show(state.otpOrigin),
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                const Center(
                  child: AuthPulseBadge(
                    icon: Iconsax.sms,
                    shapeSize: 92,
                    haloSize: 116,
                    iconSize: 42,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Text(
                  l10n.authOtpTitle,
                  textAlign: TextAlign.center,
                  style: context.textTheme.headlineMedium?.copyWith(
                    fontSize: 24,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  l10n.authOtpDesc(_codeLength),
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 14.5,
                    color: colors.gray,
                  ),
                ),
                const SizedBox(height: AppSpacing.xxs),
                Text(
                  maskIdentifier(state.otpDestination),
                  textAlign: TextAlign.center,
                  textDirection: TextDirection.ltr,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),
                _CodeField(
                  controller: _controller,
                  onChanged: (_) => setState(() {}),
                  onCompleted: (_) => _verify(),
                ),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: l10n.authOtpCta,
                  onPressed: _isComplete ? _verify : null,
                ),
                const SizedBox(height: AppSpacing.md),
                _ResendRow(
                  label: _canResend
                      ? l10n.authOtpResend
                      : l10n.authOtpResendIn(_secondsLeft),
                  onTap: _canResend ? _resend : null,
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
    );
  }
}

/// The four code boxes. Digits stay left-to-right even in an RTL layout.
class _CodeField extends StatelessWidget {
  const _CodeField({
    required this.controller,
    required this.onChanged,
    required this.onCompleted,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<String> onCompleted;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final base = PinTheme(
      width: 58,
      height: 64,
      textStyle: context.textTheme.headlineMedium?.copyWith(
        fontSize: 24,
        color: colors.ink,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(color: colors.line, width: 1.5),
      ),
    );

    return Directionality(
      textDirection: TextDirection.ltr,
      child: Pinput(
        length: _codeLength,
        controller: controller,
        onChanged: onChanged,
        onCompleted: onCompleted,
        keyboardType: TextInputType.number,
        defaultPinTheme: base,
        focusedPinTheme: base.copyBorderWith(
          border: Border.all(color: colors.primary500, width: 2),
        ),
        submittedPinTheme: base.copyBorderWith(
          border: Border.all(color: colors.primary500, width: 2),
        ),
        separatorBuilder: (_) => const SizedBox(width: AppSpacing.sm + 2),
        showCursor: true,
      ),
    );
  }
}

/// "Didn't get the code?" line — the action turns blue once the wait is over.
class _ResendRow extends StatelessWidget {
  const _ResendRow({required this.label, required this.onTap});

  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          context.l10n.authOtpNoCode,
          style: context.textTheme.bodySmall?.copyWith(color: colors.gray),
        ),
        const SizedBox(width: AppSpacing.xxs),
        GestureDetector(
          onTap: onTap,
          child: Text(
            label,
            style: context.textTheme.bodySmall?.copyWith(
              color: onTap == null ? colors.muted : colors.primary600,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }
}
