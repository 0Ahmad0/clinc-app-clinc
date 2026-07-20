import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Centered "prompt + action" footer shared by the login and signup layers
/// (e.g. "Don't have an account? Create one").
class AuthFooterLink extends StatelessWidget {
  const AuthFooterLink({
    super.key,
    required this.leading,
    required this.action,
    required this.onTap,
  });

  final String leading;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          leading,
          style: context.textTheme.bodyMedium?.copyWith(
            fontWeight: FontWeight.w400,
            color: colors.gray,
          ),
        ),
        const SizedBox(width: AppSpacing.xxs + 2),
        GestureDetector(
          onTap: onTap,
          child: Text(
            action,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w700,
              color: colors.primary600,
            ),
          ),
        ),
      ],
    );
  }
}
