import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../config/routes/app_routes.dart';
import '../../config/theme/app_shadows.dart';
import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

class AppBottomNavigation extends StatelessWidget {
  const AppBottomNavigation({super.key, required this.activeRoute});

  final String activeRoute;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final items = <(IconData, String, String?)>[
      (Iconsax.home, context.l10n.homeNavHome, AppRoutes.home),
      (Iconsax.profile_2user, context.l10n.homeDoctors, AppRoutes.doctors),
      (Iconsax.calendar, context.l10n.homeNavCalendar, AppRoutes.appointments),
      (Iconsax.briefcase, context.l10n.homeServices, AppRoutes.services),
      (Iconsax.chart_2, context.l10n.homeReports, AppRoutes.reports),
    ];

    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.sm,
        AppSpacing.xl,
        AppSpacing.sm,
        MediaQuery.paddingOf(context).bottom + AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [colors.bg, colors.bg.withValues(alpha: 0)],
        ),
      ),
      child: Container(
        padding: const EdgeInsetsDirectional.all(AppSpacing.xs),
        decoration: BoxDecoration(
          color: colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.card),
          border: Border.all(color: colors.line),
          boxShadow: AppShadows.homeNavigation,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            for (final item in items)
              Builder(
                builder: (context) {
                  final active = item.$3 == activeRoute;
                  final foreground = active ? colors.primary600 : colors.muted;
                  return Material(
                    color: active
                        ? colors.primary500.withValues(alpha: 0.1)
                        : colors.surface.withValues(alpha: 0),
                    borderRadius: BorderRadius.circular(AppRadius.field),
                    child: InkWell(
                      onTap: item.$3 == null || active
                          ? null
                          : () => context.go(item.$3!),
                      borderRadius: BorderRadius.circular(AppRadius.field),
                      child: Padding(
                        padding: EdgeInsetsDirectional.symmetric(
                          horizontal: active ? AppSpacing.md : AppSpacing.sm,
                          vertical: AppSpacing.sm,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              item.$1,
                              size: AppSizes.iconMd,
                              color: foreground,
                            ),
                            if (active) ...[
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                item.$2,
                                style: context.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.w700,
                                  color: foreground,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
