import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../legal_clipboard.dart';
import '../widgets/legal_header.dart';

/// Website shown in the about links.
const _websiteUrl = 'https://alshifa-clinic.sa';

/// About the app: brand hero, what the platform does, quick links and the
/// copyright line.
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final features = <(IconData, String, String)>[
      (Iconsax.calendar_tick, l10n.legalAboutFeature1, l10n.legalAboutFeature1Sub),
      (Iconsax.document_text, l10n.legalAboutFeature2, l10n.legalAboutFeature2Sub),
      (Iconsax.profile_2user, l10n.legalAboutFeature3, l10n.legalAboutFeature3Sub),
      (Iconsax.shield_tick, l10n.legalAboutFeature4, l10n.legalAboutFeature4Sub),
    ];

    return Scaffold(
      backgroundColor: colors.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LegalHeader(title: l10n.settingsAbout),
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
                  const Center(child: _BrandMark()),
                  AppGaps.h12,
                  Text(
                    l10n.appBrand,
                    textAlign: TextAlign.center,
                    style: context.textTheme.titleLarge?.copyWith(
                      color: colors.ink,
                    ),
                  ),
                  Text(
                    l10n.settingsVersion,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.muted,
                    ),
                  ),
                  AppGaps.h16,
                  Text(
                    l10n.legalAboutIntro,
                    textAlign: TextAlign.center,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: colors.slate,
                      height: 1.9,
                    ),
                  ),
                  AppGaps.h24,
                  for (final (icon, title, sub) in features)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.xs + 2,
                      ),
                      child: _FeatureCard(icon: icon, title: title, sub: sub),
                    ),
                  AppGaps.h12,
                  _LinksCard(
                    links: [
                      (
                        l10n.legalAboutLinkWebsite,
                        () => copyContactDetail(context, _websiteUrl),
                      ),
                      (
                        l10n.authTermsLink,
                        () => context.push(AppRoutes.privacy),
                      ),
                    ],
                  ),
                  AppGaps.h24,
                  Text(
                    l10n.legalAboutCopyright,
                    textAlign: TextAlign.center,
                    style: context.textTheme.labelSmall?.copyWith(
                      color: colors.muted,
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

/// Rounded gradient tile holding the app logo.
class _BrandMark extends StatelessWidget {
  const _BrandMark();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: AppSizes.settingsPasswordHero,
      height: AppSizes.settingsPasswordHero,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        gradient: colors.heroBadgeGradient,
        borderRadius: BorderRadius.circular(AppRadius.card),
        boxShadow: AppShadows.primaryButton,
      ),
      child: SvgPicture.asset(
        'assets/images/app_logo.svg',
        width: AppSizes.iconLg + AppSpacing.md,
        height: AppSizes.iconLg + AppSpacing.md,
        colorFilter: ColorFilter.mode(colors.onBrand, BlendMode.srcIn),
      ),
    );
  }
}

/// One capability of the platform: tinted icon, title and one-line summary.
class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.sub,
  });

  final IconData icon;
  final String title;
  final String sub;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm + 2,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field + 2),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.iconBox,
            height: AppSizes.iconBox,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: colors.primary500.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(AppRadius.sm + 1),
            ),
            child: Icon(
              icon,
              size: AppSizes.iconSm,
              color: colors.primary600,
            ),
          ),
          AppGaps.w12,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  sub,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: colors.muted,
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

/// Grouped navigation links, hairline-separated inside one card.
class _LinksCard extends StatelessWidget {
  const _LinksCard({required this.links});

  final List<(String, VoidCallback)> links;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card - 4),
        border: Border.all(color: colors.line),
      ),
      child: Column(
        children: [
          for (final (index, (label, onTap)) in links.indexed) ...[
            if (index > 0) Divider(height: 1, color: colors.line),
            InkWell(
              onTap: onTap,
              child: Padding(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.md + 2,
                  vertical: AppSpacing.md,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        label,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: colors.ink,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    Icon(
                      Directionality.of(context) == TextDirection.rtl
                          ? Iconsax.arrow_left_2
                          : Iconsax.arrow_right_3,
                      size: AppSizes.iconSm,
                      color: colors.ink.withValues(alpha: 0.35),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
