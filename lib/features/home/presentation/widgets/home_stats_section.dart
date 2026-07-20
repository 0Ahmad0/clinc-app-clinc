import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Clinic statistics block shown below the quick actions.
class HomeStatsSection extends StatelessWidget {
  const HomeStatsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.lg,
        AppSpacing.screen,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          HomeSectionTitle(title: l10n.homeStatsTitle),
          const SizedBox(height: AppSpacing.sm),
          const HomePatientCard(),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Expanded(
                child: HomeMetricCard(
                  icon: Iconsax.profile_2user,
                  count: l10n.homeDoctorsCount,
                  label: l10n.homeDoctors,
                  detail: l10n.homeDoctorsGrowth,
                  accent: colors.primary500,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: HomeMetricCard(
                  icon: Iconsax.money,
                  count: l10n.homeIncomeCount,
                  suffix: l10n.homeCurrency,
                  label: l10n.homeDailyIncome,
                  accent: colors.warning,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          const HomeTodaySummaryCard(),
        ],
      ),
    );
  }
}

class HomeSectionTitle extends StatelessWidget {
  const HomeSectionTitle({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: AppSizes.homeSectionMarkerWidth,
          height: AppSizes.homeSectionMarkerHeight,
          decoration: BoxDecoration(
            gradient: context.colors.ctaGradient,
            borderRadius: BorderRadius.circular(AppRadius.pill),
          ),
        ),
        const SizedBox(width: AppSpacing.xs),
        Expanded(
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.titleMedium,
          ),
        ),
      ],
    );
  }
}

class HomePatientCard extends StatelessWidget {
  const HomePatientCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: AlignmentDirectional.topStart,
          end: AlignmentDirectional.bottomEnd,
          colors: [colors.ink, colors.primary800],
        ),
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.homeDarkCard,
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            start: 0,
            end: 0,
            bottom: 0,
            height: AppSizes.homeChartHeight,
            child: HomePatientChart(color: colors.primary300),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.symmetric(
              horizontal: AppSpacing.lg,
              vertical: AppSpacing.md,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.homePatients,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.onBrand.withValues(alpha: 0.65),
                      ),
                    ),
                    Text(
                      l10n.homePatientsCount,
                      style: context.textTheme.headlineMedium?.copyWith(
                        fontSize: AppSizes.homePatientCountText,
                        height: 1,
                        color: colors.onBrand,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppSpacing.xs),
                Flexible(
                  child: Container(
                    padding: const EdgeInsetsDirectional.symmetric(
                      horizontal: AppSpacing.sm,
                      vertical: AppSpacing.xxs,
                    ),
                    decoration: BoxDecoration(
                      color: colors.successBright.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                    child: Text(
                      l10n.homeWeeklyGrowth,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: context.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: colors.successBright,
                      ),
                    ),
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

class HomePatientChart extends StatelessWidget {
  const HomePatientChart({super.key, required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: HomePatientChartPainter(color));
  }
}

class HomePatientChartPainter extends CustomPainter {
  const HomePatientChartPainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path()
      ..moveTo(0, size.height * 0.82)
      ..cubicTo(
        size.width * 0.18,
        size.height * 0.7,
        size.width * 0.22,
        size.height * 0.3,
        size.width * 0.38,
        size.height * 0.48,
      )
      ..cubicTo(
        size.width * 0.58,
        size.height * 0.85,
        size.width * 0.7,
        size.height * 0.18,
        size.width,
        size.height * 0.42,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(
      path,
      Paint()
        ..shader = LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [color.withValues(alpha: 0.8), color.withValues(alpha: 0)],
        ).createShader(Offset.zero & size),
    );
  }

  @override
  bool shouldRepaint(HomePatientChartPainter oldDelegate) =>
      oldDelegate.color != color;
}

class HomeMetricCard extends StatelessWidget {
  const HomeMetricCard({
    super.key,
    required this.icon,
    required this.count,
    required this.label,
    required this.accent,
    this.detail,
    this.suffix,
  });

  final IconData icon;
  final String count;
  final String label;
  final String? detail;
  final String? suffix;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: colors.line.withValues(alpha: 0.7)),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: AppSizes.homeStatIcon,
            height: AppSizes.homeStatIcon,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Icon(icon, size: AppSizes.iconSm, color: accent),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: count),
                if (suffix != null)
                  TextSpan(
                    text: ' $suffix',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: colors.muted,
                    ),
                  ),
              ],
            ),
            style: context.textTheme.headlineMedium?.copyWith(
              fontSize: AppSizes.homeMetricCountText,
              height: 1,
            ),
          ),
          const SizedBox(height: AppSpacing.xxs),
          Text.rich(
            TextSpan(
              children: [
                TextSpan(text: label),
                if (detail != null)
                  TextSpan(
                    text: ' $detail',
                    style: context.textTheme.bodySmall?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: accent,
                    ),
                  ),
              ],
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall?.copyWith(color: colors.gray),
          ),
        ],
      ),
    );
  }
}

class HomeTodaySummaryCard extends StatelessWidget {
  const HomeTodaySummaryCard({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        gradient: colors.ctaGradient,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.homeBlueCard,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  width: AppSizes.hitTarget,
                  height: AppSizes.hitTarget,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.onBrand.withValues(alpha: 0.16),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Icon(
                    Iconsax.calendar,
                    size: AppSizes.iconMd,
                    color: colors.onBrand,
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        l10n.homeAppointmentsCount,
                        style: context.textTheme.headlineMedium?.copyWith(
                          color: colors.onBrand,
                          height: 1,
                        ),
                      ),
                      Text(
                        l10n.homeTodayAppointments,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: colors.onBrand.withValues(alpha: 0.75),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Flexible(
            child: Container(
              padding: const EdgeInsetsDirectional.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: colors.onBrand.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(AppRadius.pill),
              ),
              child: Text(
                l10n.homeUpcomingCount,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  color: colors.onBrand,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
