import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

enum _StepStatus { done, active, waiting }

/// The three-step activation tracker card on the pending-approval layer.
class PendingSteps extends StatelessWidget {
  const PendingSteps({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final steps = [
      (l10n.authStep1Title, l10n.authStep1Sub, _StepStatus.done),
      (l10n.authStep2Title, l10n.authStep2Sub, _StepStatus.active),
      (l10n.authStep3Title, l10n.authStep3Sub, _StepStatus.waiting),
    ];

    return Container(
      decoration: BoxDecoration(
        color: context.colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: context.colors.line),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg - 4),
      child: Column(
        children: [
          for (var i = 0; i < steps.length; i++)
            _StepRow(
              title: steps[i].$1,
              subtitle: steps[i].$2,
              status: steps[i].$3,
              isLast: i == steps.length - 1,
            ),
        ],
      ),
    );
  }
}

class _StepRow extends StatelessWidget {
  const _StepRow({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.isLast,
  });

  final String title;
  final String subtitle;
  final _StepStatus status;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final done = status == _StepStatus.done;
    final active = status == _StepStatus.active;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Container(
              width: 22,
              height: 22,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: done
                    ? colors.primary500
                    : active
                    ? colors.primary500.withValues(alpha: 0.15)
                    : colors.fill,
                border: active
                    ? Border.all(color: colors.primary500, width: 2)
                    : null,
              ),
              child: done
                  ? Icon(Iconsax.tick_circle, size: 13, color: colors.onBrand)
                  : active
                  ? Icon(Iconsax.record, size: 7, color: colors.primary500)
                  : null,
            ),
            if (!isLast)
              Container(
                width: 2,
                height: 18,
                margin: const EdgeInsets.symmetric(vertical: 2),
                color: done ? colors.primary500 : colors.line,
              ),
          ],
        ),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w700,
                    color: colors.ink,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontSize: 12,
                    color: colors.muted,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
