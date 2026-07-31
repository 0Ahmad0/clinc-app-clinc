import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/input/email_input.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/auth_layer.dart';
import '../../domain/auth_validators.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';
import 'auth_footer_link.dart';
import 'auth_text_field.dart';

/// The sign-in layer: brand, credentials, forgot link, primary + guest CTAs and
/// a footer link to signup.
class LoginLayer extends StatefulWidget {
  const LoginLayer({super.key});

  @override
  State<LoginLayer> createState() => LoginLayerState();
}

class LoginLayerState extends State<LoginLayer> {
  final formKey = GlobalKey<FormState>();
  final identifierController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    identifierController.dispose();
    passwordController.dispose();
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
            AppSpacing.lg,
          ),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: constraints.maxHeight - AppSpacing.xxl,
            ),
            child: IntrinsicHeight(
              child: Column(
                children: [
                  const SizedBox(height: AppSpacing.xs),
                  SvgPicture.asset(
                    'assets/images/app_logo.svg',
                    width: 76,
                    height: 76,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.authLoginTitle,
                    style: context.textTheme.headlineMedium,
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.authLoginSubtitle,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      color: colors.gray,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AuthTextField(
                    controller: identifierController,
                    hint: l10n.authIdentifierHint,
                    icon: Iconsax.sms,
                    keyboardType: TextInputType.emailAddress,
                    inputFormatters: const [EmailInputFormatter()],
                    validator: (value) =>
                        AuthValidators.required(value, l10n.validationRequired),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  AuthTextField(
                    controller: passwordController,
                    hint: l10n.authPasswordHint,
                    icon: Iconsax.lock,
                    obscure: true,
                    textInputAction: TextInputAction.done,
                    validator: (value) => AuthValidators.password(
                      value,
                      requiredMessage: l10n.validationRequired,
                      shortMessage: l10n.validationPasswordLength,
                    ),
                  ),
                  Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: TextButton(
                      onPressed: () => cubit.show(AuthLayer.forgot),
                      style: TextButton.styleFrom(
                        foregroundColor: colors.primary600,
                        textStyle: context.textTheme.bodySmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        padding: const EdgeInsetsDirectional.symmetric(
                          vertical: AppSpacing.xs,
                        ),
                      ),
                      child: Text(l10n.authForgotLink),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  BlocBuilder<AuthCubit, AuthState>(
                    buildWhen: (previous, current) =>
                        previous.isLoading != current.isLoading ||
                        previous.action != current.action,
                    builder: (context, state) => AppButton(
                      label: l10n.authLoginCta,
                      isLoading:
                          state.isLoading && state.action == AuthAction.login,
                      onPressed:
                          state.isLoading && state.action == AuthAction.login
                          ? null
                          : () {
                              FocusScope.of(context).unfocus();
                              if (formKey.currentState?.validate() ?? false) {
                                cubit.login(
                                  identifier: normalizeEmailInput(
                                    identifierController.text,
                                  ),
                                  password: passwordController.text,
                                );
                              }
                            },
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if(false)
                  const _GuestButton(onPressed: null),
                  const Spacer(),
                  const SizedBox(height: AppSpacing.lg),
                  AuthFooterLink(
                    leading: l10n.authNoAccount,
                    action: l10n.authCreateAccount,
                    onTap: () => cubit.show(AuthLayer.signup),
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

class _GuestButton extends StatelessWidget {
  const _GuestButton({required this.onPressed});
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(Iconsax.user, size: 19, color: colors.primary600),
      label: Text(context.l10n.authGuestCta),
      style: OutlinedButton.styleFrom(
        foregroundColor: colors.primary600,
        backgroundColor: colors.primary500.withValues(alpha: 0.06),
        textStyle: context.textTheme.labelLarge?.copyWith(fontSize: 15.5),
        minimumSize: const Size.fromHeight(AppSizes.buttonHeightSm),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppRadius.button),
        ),
      ),
    );
  }
}
