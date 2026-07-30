import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/services/storage_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../data/models/clinic_dashboard_model.dart';

/// Gradient dashboard header with the overlapping four quick actions.
class HomeTopSection extends StatelessWidget {
  const HomeTopSection({super.key, this.dashboard});

  final ClinicDashboardModel? dashboard;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.homeTopHeight,
      child: Stack(
        children: [
          HomeHeader(dashboard: dashboard),
          PositionedDirectional(
            start: AppSpacing.screen,
            end: AppSpacing.screen,
            bottom: 0,
            height: AppSizes.homeQuickActionHeight,
            child: HomeQuickActions(),
          ),
        ],
      ),
    );
  }
}

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key, this.dashboard});

  final ClinicDashboardModel? dashboard;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final clinic = dashboard?.clinic;
    final cachedClinic = StorageService.instance.getCachedClinic();
    final cachedClinicName = cachedClinic?['name']?.toString().trim();
    final clinicName = (cachedClinicName != null && cachedClinicName.isNotEmpty)
        ? cachedClinicName
        : (clinic?.name?.trim().isNotEmpty == true
              ? clinic!.name!
              : l10n.homeClinicName);
    final statusText = clinic?.workingHoursText?.trim().isNotEmpty == true
        ? clinic!.workingHoursText!
        : l10n.homeOpenStatus;
    final isOpen = clinic?.isOpen ?? true;
    return Container(
      height: AppSizes.homeHeaderHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: colors.headerGradient,
        borderRadius: const BorderRadius.vertical(
          bottom: Radius.circular(AppRadius.homeHeader),
        ),
      ),
      child: Stack(
        children: [
          const HomeHeaderRings(),
          Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              MediaQuery.paddingOf(context).top + AppSpacing.lg,
              AppSpacing.screen,
              AppSpacing.md,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      l10n.homeDashboard,
                      style: context.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w500,
                        color: colors.onBrand.withValues(alpha: 0.75),
                      ),
                    ),
                    Row(
                      children: [
                        HomeHeaderButton(
                          icon: Iconsax.notification,
                          showBadge: true,
                          onTap: () => context.push(AppRoutes.notifications),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        HomeHeaderButton(
                          icon: Iconsax.setting,
                          onTap: () => context.push(AppRoutes.settings),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.lg),
                Row(
                  children: [
                    Container(
                      width: AppSizes.homeBrandBox,
                      height: AppSizes.homeBrandBox,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(
                          AppRadius.homeQuickAction,
                        ),
                      ),
                      child: SvgPicture.asset(
                        'assets/images/app_logo.svg',
                        width: AppSizes.homeBrandLogo,
                        height: AppSizes.homeBrandLogo,
                        colorFilter: ColorFilter.mode(
                          colors.onBrand,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            clinicName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: context.textTheme.headlineMedium?.copyWith(
                              color: colors.onBrand,
                            ),
                          ),
                          Text(
                            l10n.homeDate,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.onBrand.withValues(alpha: 0.72),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.md),
                Container(
                  padding: const EdgeInsetsDirectional.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: colors.onBrand.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    border: Border.all(
                      color: colors.onBrand.withValues(alpha: 0.16),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: AppSizes.homeStatusDot,
                        height: AppSizes.homeStatusDot,
                        decoration: BoxDecoration(
                          color: isOpen ? colors.successBright : colors.gray,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: isOpen
                                  ? colors.successBright
                                  : colors.gray,
                              blurRadius: AppSpacing.sm,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSpacing.xs),
                      Expanded(
                        child: Text(
                          statusText,
                          style: context.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w500,
                            color: colors.onBrand,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HomeHeaderRings extends StatelessWidget {
  const HomeHeaderRings({super.key});

  @override
  Widget build(BuildContext context) {
    final color = context.colors.onBrand;
    return Stack(
      children: [
        PositionedDirectional(
          top: -AppSizes.homeHeaderCircleTop,
          start: -AppSizes.homeHeaderCircleStart,
          child: Container(
            width: AppSizes.homeHeaderCircleSmall,
            height: AppSizes.homeHeaderCircleSmall,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.12)),
            ),
          ),
        ),
        PositionedDirectional(
          bottom: -AppSizes.homeHeaderCircleBottom,
          end: -AppSizes.homeHeaderCircleEnd,
          child: Container(
            width: AppSizes.homeHeaderCircleLarge,
            height: AppSizes.homeHeaderCircleLarge,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: color.withValues(alpha: 0.09)),
            ),
          ),
        ),
      ],
    );
  }
}

class HomeHeaderButton extends StatelessWidget {
  const HomeHeaderButton({
    super.key,
    required this.icon,
    this.showBadge = false,
    this.onTap,
  });

  final IconData icon;
  final bool showBadge;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox.square(
      dimension: AppSizes.homeHeaderAction,
      child: Material(
        color: colors.onBrand.withValues(alpha: 0.13),
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Icon(icon, size: AppSizes.iconSm, color: colors.onBrand),
              if (showBadge)
                PositionedDirectional(
                  top: AppSpacing.xs,
                  end: AppSpacing.xs,
                  child: Container(
                    width: AppSpacing.xs,
                    height: AppSpacing.xs,
                    decoration: BoxDecoration(
                      color: colors.warning,
                      shape: BoxShape.circle,
                      border: Border.all(color: colors.primary600),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomeQuickActions extends StatelessWidget {
  const HomeQuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final actions = [
      (
        Iconsax.calendar,
        l10n.homeNewAppointment,
        () => context.go(AppRoutes.appointments),
      ),
      (
        Iconsax.profile_2user,
        l10n.homeDoctors,
        () => context.go(AppRoutes.doctors),
      ),
      (
        Iconsax.briefcase,
        l10n.homeServices,
        () => context.go(AppRoutes.services),
      ),
      (Iconsax.chart_2, l10n.homeReports, () => context.go(AppRoutes.reports)),
    ];
    return Row(
      children: [
        for (var index = 0; index < actions.length; index++) ...[
          if (index > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: HomeQuickActionButton(
              icon: actions[index].$1,
              label: actions[index].$2,
              onTap: actions[index].$3,
              primary: index == 0,
            ),
          ),
        ],
      ],
    );
  }
}

class HomeQuickActionButton extends StatelessWidget {
  const HomeQuickActionButton({
    super.key,
    required this.icon,
    required this.label,
    required this.primary,
    required this.onTap,
  });


  final IconData icon;
  final String label;
  final bool primary;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = primary ? colors.onBrand : colors.ink;
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';

    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: primary ? colors.ctaGradient : null,
        color: primary ? null : colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        boxShadow: primary ? AppShadows.primaryButton : AppShadows.homeCard,
      ),
      child: Material(
        color: colors.onBrand.withValues(alpha: 0),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: AppSizes.iconMd, color: foreground),
              const SizedBox(height: AppSpacing.xxs),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  fontSize: isArabic ? 10.sp : 9.sp,
                  color: foreground,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
