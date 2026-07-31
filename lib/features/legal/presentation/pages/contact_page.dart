import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/form_validators.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../legal_clipboard.dart';
import '../widgets/legal_header.dart';

/// Contact & support: the clinic's channels, support hours and a message form.
class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _message = TextEditingController();

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _message.dispose();
    super.dispose();
  }

  // ponytail: no support inbox yet — the form clears and confirms locally.
  void _send() {
    FocusScope.of(context).unfocus();
    if (!(_formKey.currentState?.validate() ?? false)) return;
    AppToast.show(
      context,
      title: context.l10n.legalContactTitle,
      message: context.l10n.legalContactSent,
      type: AppFeedbackType.success,
    );
    _formKey.currentState?.reset();
    for (final controller in [_name, _email, _message]) {
      controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final channels = <(IconData, String, String)>[
      (Iconsax.call, l10n.legalContactPhone, l10n.legalContactPhoneValue),
      (Iconsax.sms, l10n.legalContactEmail, l10n.legalContactEmailValue),
      (Iconsax.location, l10n.legalContactAddress, l10n.legalContactAddressValue),
      (Iconsax.message, l10n.legalContactWhatsapp, l10n.legalContactWhatsappValue),
    ];

    return Scaffold(
      backgroundColor: colors.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LegalHeader(title: l10n.legalContactTitle),
            Padding(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.screen,
                AppSpacing.lg,
                AppSpacing.screen,
                AppSpacing.xl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final (icon, label, value) in channels)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.xs + 2,
                      ),
                      child: _ChannelCard(
                        icon: icon,
                        label: label,
                        value: value,
                        onTap: () => copyContactDetail(context, value),
                      ),
                    ),
                  AppGaps.h8,
                  _HoursNote(text: l10n.legalContactHours),
                  AppGaps.h24,
                  Text(
                    l10n.legalContactFormTitle,
                    style: context.textTheme.titleMedium?.copyWith(
                      color: colors.ink,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  AppGaps.h12,
                  Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _ContactField(
                          controller: _name,
                          hint: l10n.legalContactName,
                          validator: (value) => FormValidators.required(
                            value,
                            l10n.validationRequired,
                          ),
                        ),
                        AppGaps.h12,
                        _ContactField(
                          controller: _email,
                          hint: l10n.authEmailHint,
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) => FormValidators.email(
                            value,
                            requiredMessage: l10n.validationRequired,
                            invalidMessage: l10n.validationEmail,
                          ),
                        ),
                        AppGaps.h12,
                        _ContactField(
                          controller: _message,
                          hint: l10n.legalContactMessage,
                          maxLines: 4,
                          textInputAction: TextInputAction.newline,
                          validator: (value) => FormValidators.required(
                            value,
                            l10n.validationRequired,
                          ),
                        ),
                        AppGaps.h16,
                        AppButton(
                          label: l10n.legalContactSend,
                          icon: Iconsax.send_2,
                          onPressed: _send,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// One reachable channel — tapping copies the detail to the clipboard.
class _ChannelCard extends StatelessWidget {
  const _ChannelCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.field + 2),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.field + 2),
        child: Ink(
          padding: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm + 2,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.field + 2),
            border: Border.all(color: colors.line),
            boxShadow: AppShadows.homeCard,
          ),
          child: Row(
            children: [
              Container(
                width: AppSizes.hitTarget,
                height: AppSizes.hitTarget,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.primary500.withValues(alpha: 0.10),
                  borderRadius: BorderRadius.circular(AppRadius.field - 2),
                ),
                child: Icon(
                  icon,
                  size: AppSizes.iconMd,
                  color: colors.primary600,
                ),
              ),
              AppGaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
                    ),
                    Text(
                      value,
                      textDirection: TextDirection.ltr,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Iconsax.copy,
                size: AppSizes.iconSm,
                color: colors.ink.withValues(alpha: 0.35),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Tinted note listing when the support team is available.
class _HoursNote extends StatelessWidget {
  const _HoursNote({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
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
          Icon(Iconsax.clock, size: AppSizes.iconSm, color: colors.primary600),
          AppGaps.w8,
          Expanded(
            child: Text(
              text,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.slate,
                height: 1.8,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Form input for the message form — same surface treatment as the auth fields,
/// minus the leading icon.
class _ContactField extends StatelessWidget {
  const _ContactField({
    required this.controller,
    required this.hint,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction = TextInputAction.next,
    this.validator,
  });

  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction textInputAction;
  final FormFieldValidator<String>? validator;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    OutlineInputBorder border(Color color) => OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.field),
      borderSide: BorderSide(color: color, width: 1.5),
    );

    return TextFormField(
      controller: controller,
      validator: validator,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLines: maxLines,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w500,
        color: colors.ink,
      ),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: context.textTheme.bodyMedium?.copyWith(color: colors.muted),
        filled: true,
        fillColor: colors.surface,
        constraints: const BoxConstraints(minHeight: AppSizes.hitTarget + 8),
        contentPadding: const EdgeInsetsDirectional.all(AppSpacing.md),
        enabledBorder: border(colors.line),
        border: border(colors.line),
        focusedBorder: border(colors.primary500),
      ),
    );
  }
}
