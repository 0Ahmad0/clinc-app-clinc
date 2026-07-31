import 'package:flutter/material.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../widgets/legal_header.dart';

/// Privacy policy: a last-updated line followed by the policy sections.
class PrivacyPage extends StatelessWidget {
  const PrivacyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final sections = <(String, String)>[
      (l10n.legalPrivacy1, l10n.legalPrivacy1Body),
      (l10n.legalPrivacy2, l10n.legalPrivacy2Body),
      (l10n.legalPrivacy3, l10n.legalPrivacy3Body),
      (l10n.legalPrivacy4, l10n.legalPrivacy4Body),
      (l10n.legalPrivacy5, l10n.legalPrivacy5Body),
    ];

    return Scaffold(
      backgroundColor: colors.bg,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LegalHeader(title: l10n.settingsPrivacy),
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
                  Text(
                    l10n.legalPrivacyUpdated,
                    style: context.textTheme.bodySmall?.copyWith(
                      color: colors.muted,
                    ),
                  ),
                  AppGaps.h16,
                  for (final (title, body) in sections)
                    Padding(
                      padding: const EdgeInsetsDirectional.only(
                        bottom: AppSpacing.md,
                      ),
                      child: _PolicySection(title: title, body: body),
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

/// One policy clause: a marker-and-heading row above the body copy.
class _PolicySection extends StatelessWidget {
  const _PolicySection({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md + 2,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field + 2),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.homeSectionMarkerWidth,
                height: AppSizes.homeSectionMarkerHeight - 3,
                decoration: BoxDecoration(
                  gradient: colors.heroBadgeGradient,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
              AppGaps.w8,
              Expanded(
                child: Text(
                  title,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: colors.ink,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          AppGaps.h8,
          Text(
            body,
            style: context.textTheme.bodySmall?.copyWith(
              color: colors.paragraph,
              height: 1.9,
            ),
          ),
        ],
      ),
    );
  }
}
