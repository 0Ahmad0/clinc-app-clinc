import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_password_field.dart';
import '../widgets/settings_password_header.dart';
import '../widgets/settings_password_strength.dart';

/// Change-password screen: gradient hero header, a requirements banner, the
/// three password fields, a live strength meter and the submit CTA.
class SettingsPasswordView extends StatefulWidget {
  const SettingsPasswordView({super.key});

  @override
  State<SettingsPasswordView> createState() => _SettingsPasswordViewState();
}

class _SettingsPasswordViewState extends State<SettingsPasswordView> {
  final _current = TextEditingController();
  final _next = TextEditingController();
  final _confirm = TextEditingController();
  bool _obscure = true;

  @override
  void dispose() {
    _current.dispose();
    _next.dispose();
    _confirm.dispose();
    super.dispose();
  }

  /// 0 empty · 1 weak · 2 medium · 3 strong.
  int get _strength {
    final value = _next.text;
    if (value.isEmpty) return 0;
    final hasDigit = value.contains(RegExp(r'\d'));
    final hasLetter = value.contains(RegExp(r'[A-Za-zء-ي]'));
    if (value.length >= 8 && hasDigit && hasLetter) return 3;
    return value.length >= 6 ? 2 : 1;
  }

  void _submit() {
    final l10n = context.l10n;
    FocusScope.of(context).unfocus();
    if (_strength < 3) {
      AppToast.show(
        context,
        title: l10n.settingsPasswordTitle,
        message: l10n.validationPasswordLength,
        type: AppFeedbackType.warning,
      );
      return;
    }
    if (_next.text != _confirm.text) {
      AppToast.show(
        context,
        title: l10n.settingsPasswordTitle,
        message: l10n.validationPasswordMismatch,
        type: AppFeedbackType.danger,
      );
      return;
    }
    AppToast.show(
      context,
      title: l10n.settingsPasswordTitle,
      message: l10n.settingsPasswordChanged,
      type: AppFeedbackType.success,
    );
    context.read<SettingsCubit>().show(SettingsSection.main);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final fields = <(TextEditingController, String)>[
      (_current, l10n.settingsPasswordCurrent),
      (_next, l10n.settingsPasswordNew),
      (_confirm, l10n.settingsPasswordConfirm),
    ];

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SettingsPasswordHeader(),
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              AppSpacing.md + 2,
              AppSpacing.screen,
              AppSpacing.xl,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  padding: const EdgeInsetsDirectional.all(AppSpacing.sm + 1),
                  decoration: BoxDecoration(
                    color: colors.primary500.withValues(alpha: 0.07),
                    borderRadius: BorderRadius.circular(AppRadius.field),
                    border: Border.all(
                      color: colors.primary500.withValues(alpha: 0.18),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Iconsax.info_circle,
                        size: AppSizes.iconSm,
                        color: colors.primary600,
                      ),
                      AppGaps.w8,
                      Expanded(
                        child: Text(
                          l10n.settingsPasswordHint,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.slate,
                            height: 1.6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                AppGaps.h12,
                for (final field in fields)
                  Padding(
                    padding: const EdgeInsetsDirectional.only(
                      bottom: AppSpacing.sm,
                    ),
                    child: SettingsPasswordField(
                      controller: field.$1,
                      hint: field.$2,
                      obscure: _obscure,
                      onToggleObscure: () =>
                          setState(() => _obscure = !_obscure),
                      onChanged: (_) => setState(() {}),
                    ),
                  ),
                AppGaps.h8,
                SettingsPasswordStrength(level: _strength),
                AppGaps.h24,
                AppButton(
                  label: l10n.settingsPasswordTitle,
                  icon: Iconsax.refresh,
                  onPressed: _submit,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
