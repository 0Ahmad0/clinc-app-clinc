import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/input/email_input.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/account_type.dart';
import '../../domain/auth_layer.dart';
import '../../domain/auth_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'account_type_selector.dart';
import 'auth_back_button.dart';
import 'auth_footer_link.dart';
import 'auth_text_field.dart';

/// The create-account layer: header, account-type picker, facility + password
/// sections, submit, terms and a footer link back to sign-in.
class SignupLayer extends StatefulWidget {
  const SignupLayer({super.key});

  @override
  State<SignupLayer> createState() => SignupLayerState();
}

class SignupLayerState extends State<SignupLayer> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final licenseController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    licenseController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final cubit = context.read<AuthCubit>();

    return Form(
      key: formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.lg,
          AppSpacing.xl,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _Header(onBack: () => cubit.show(AuthLayer.login)),
            const SizedBox(height: AppSpacing.lg),
            _SectionLabel(l10n.authAccountTypeLabel),
            const SizedBox(height: AppSpacing.sm),
            const AccountTypeSelector(),
            const SizedBox(height: AppSpacing.lg),
            // Facility label + first field track the selected account type.
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (a, b) => a.accountType != b.accountType,
              builder: (context, state) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _SectionLabel(_facilityLabel(l10n, state.accountType)),
                  const SizedBox(height: AppSpacing.sm),
                  AuthTextField(
                    controller: nameController,
                    hint: _facilityHint(l10n, state.accountType),
                    icon: Iconsax.building,
                    validator: (value) =>
                        AuthValidators.required(value, l10n.validationRequired),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            AuthTextField(
              controller: licenseController,
              hint: l10n.authLicenseHint,
              icon: Iconsax.personalcard,
              validator: (value) =>
                  AuthValidators.required(value, l10n.validationRequired),
            ),
            const SizedBox(height: AppSpacing.sm),
            AuthTextField(
              controller: emailController,
              hint: l10n.authEmailHint,
              icon: Iconsax.sms,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: const [EmailInputFormatter()],
              validator: (value) => AuthValidators.email(
                value,
                requiredMessage: l10n.validationRequired,
                invalidMessage: l10n.validationEmail,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            _SectionLabel(l10n.authPasswordHint),
            const SizedBox(height: AppSpacing.sm),
            AuthTextField(
              controller: passwordController,
              hint: l10n.authPasswordHint,
              icon: Iconsax.lock,
              obscure: true,
              validator: (value) => AuthValidators.password(
                value,
                requiredMessage: l10n.validationRequired,
                shortMessage: l10n.validationPasswordLength,
              ),
            ),
            const SizedBox(height: AppSpacing.sm),
            AuthTextField(
              hint: l10n.authConfirmPasswordHint,
              icon: Iconsax.key,
              obscure: true,
              textInputAction: TextInputAction.done,
              validator: (value) => AuthValidators.confirmation(
                value,
                passwordController.text,
                requiredMessage: l10n.validationRequired,
                mismatchMessage: l10n.validationPasswordMismatch,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            BlocBuilder<AuthCubit, AuthState>(
              buildWhen: (previous, current) =>
                  previous.isLoading != current.isLoading ||
                  previous.action != current.action,
              builder: (context, state) => AppButton(
                label: l10n.authSignupCta,
                onPressed:
                    state.isLoading && state.action == AuthAction.register
                    ? null
                    : () {
                        FocusScope.of(context).unfocus();
                        if (formKey.currentState?.validate() ?? false) {
                          cubit.register(
                            name: nameController.text,
                            licenseNumber: licenseController.text,
                            email: normalizeEmailInput(emailController.text),
                            password: passwordController.text,
                          );
                        }
                      },
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            const _TermsText(),
            const SizedBox(height: AppSpacing.sm),
            Center(
              child: AuthFooterLink(
                leading: l10n.authHaveAccount,
                action: l10n.authSignin,
                onTap: () => cubit.show(AuthLayer.login),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _facilityLabel(AppLocalizations l10n, AccountType type) =>
      switch (type) {
        AccountType.clinic => l10n.authFacilityClinic,
        AccountType.lab => l10n.authFacilityLab,
        AccountType.both => l10n.authFacilityBoth,
      };

  String _facilityHint(AppLocalizations l10n, AccountType type) =>
      switch (type) {
        AccountType.clinic => l10n.authFacilityHintClinic,
        AccountType.lab => l10n.authFacilityHintLab,
        AccountType.both => l10n.authFacilityHintBoth,
      };
}

class _Header extends StatelessWidget {
  const _Header({required this.onBack});
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Row(
      children: [
        AuthBackButton(onTap: onBack),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.authSignupTitle,
                style: context.textTheme.titleLarge?.copyWith(fontSize: 22),
              ),
              const SizedBox(height: 2),
              Text(
                l10n.authSignupSubtitle,
                style: context.textTheme.bodySmall?.copyWith(
                  fontSize: 13.5,
                  color: context.colors.gray,
                ),
              ),
            ],
          ),
        ),
        SvgPicture.asset(
          'assets/images/app_logo.svg',
          width: AppSizes.logoSm,
          height: AppSizes.logoSm,
        ),
      ],
    );
  }
}

class _SectionLabel extends StatelessWidget {
  const _SectionLabel(this.text);
  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.bodyMedium?.copyWith(
        fontWeight: FontWeight.w700,
        color: context.colors.ink,
      ),
    );
  }
}

class _TermsText extends StatelessWidget {
  const _TermsText();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final base = context.textTheme.bodySmall?.copyWith(
      color: context.colors.muted,
    );
    return SizedBox(
      width: double.infinity,
      child: Text.rich(
        TextSpan(
          style: base,
          children: [
            TextSpan(text: l10n.authTermsPrefix),
            TextSpan(
              text: l10n.authTermsLink,
              style: base?.copyWith(color: context.colors.primary600),
            ),
            TextSpan(text: l10n.authTermsSuffix),
          ],
        ),
        textAlign: TextAlign.center,
      ),
    );
  }
}
