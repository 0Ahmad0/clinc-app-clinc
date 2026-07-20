import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Top bar: brand (logo + name) on the start side, Skip on the end side.
class OnboardingHeader extends StatelessWidget {
  const OnboardingHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.lg,
        AppSpacing.xs,
        AppSpacing.lg,
        0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SvgPicture.asset(
                'assets/images/app_logo.svg',
                width: AppSizes.logoSm,
                height: AppSizes.logoSm,
              ),
              const SizedBox(width: AppSpacing.xs),
              Text(context.l10n.appBrand, style: context.textTheme.titleMedium),
            ],
          ),
          TextButton(
            onPressed: () => context.go(AppRoutes.auth),
            style: TextButton.styleFrom(
              foregroundColor: context.colors.gray,
              textStyle: context.textTheme.bodyMedium,
              shape: const StadiumBorder(),
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.xs,
              ),
            ),
            child: Text(context.l10n.onboardingSkip),
          ),
        ],
      ),
    );
  }
}
