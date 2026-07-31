import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_switch.dart';
import '../../../../shared/widgets/specialization_visual.dart';
import '../../data/models/clinic_service_model.dart';
import '../services_l10n.dart';

/// One lab test row: code chip, name/sub, an enable switch, a price field and a
/// state chip. Stateful only to own the price field's controller so typing
/// never fights a rebuild.
class ServiceTestCard extends StatefulWidget {
  const ServiceTestCard({
    super.key,
    required this.test,
    required this.accent,
    required this.enabled,
    required this.price,
    required this.onToggle,
    required this.onPriceChanged,
    this.loading = false,
  });

  final ClinicAvailableLabTestModel test;
  final Color accent;
  final bool enabled;
  final String price;
  final VoidCallback onToggle;
  final ValueChanged<String> onPriceChanged;
  final bool loading;

  @override
  State<ServiceTestCard> createState() => _ServiceTestCardState();
}

class _ServiceTestCardState extends State<ServiceTestCard> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.price,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final accent = widget.accent;
    final hasIcon = (widget.test.icon ?? '').trim().isNotEmpty;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      padding: const EdgeInsetsDirectional.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(
          color: widget.enabled
              ? colors.primary500.withValues(alpha: 0.35)
              : colors.line,
          width: widget.enabled ? 1.5 : 1,
        ),
        boxShadow: widget.enabled ? AppShadows.selectedChip : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                constraints: const BoxConstraints(
                  minWidth: AppSizes.servicesCodeChipWidth,
                ),
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.xs,
                  vertical: AppSpacing.xxs + 2,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (hasIcon) ...[
                      SpecializationIconView(
                        value: widget.test.icon,
                        color: accent,
                        size: AppSizes.filterChipIcon,
                      ),
                      const SizedBox(width: AppSpacing.xxs),
                    ],
                    Text(
                      widget.test.code ?? '-',
                      textDirection: TextDirection.ltr,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: accent,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              AppGaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.test.label(context),
                      style: context.textTheme.titleSmall?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      widget.test.subtitle(context),
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.gray,
                      ),
                    ),
                  ],
                ),
              ),
              AppGaps.w8,
              AppSwitch(
                value: widget.enabled,
                loading: widget.loading,
                onChanged: widget.onToggle,
              ),
            ],
          ),
          AppGaps.h12,
          Row(
            children: [
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs,
                ),
                decoration: BoxDecoration(
                  color: colors.fill,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  border: Border.all(color: colors.line, width: 1.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: AppSizes.servicesGridIcon,
                      child: TextField(
                        controller: _controller,
                        onChanged: widget.onPriceChanged,
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly,
                        ],
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: EdgeInsets.zero,
                          border: InputBorder.none,
                          hintText: l10n.servicesPriceHint,
                          hintStyle: context.textTheme.titleSmall?.copyWith(
                            color: colors.muted,
                          ),
                        ),
                        style: context.textTheme.titleSmall?.copyWith(
                          color: colors.ink,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    AppGaps.w8,
                    Text(
                      l10n.servicesCurrency,
                      style: context.textTheme.bodySmall?.copyWith(
                        color: colors.muted,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              AppGaps.w12,
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xs - 2,
                ),
                decoration: BoxDecoration(
                  color: (widget.enabled ? colors.success : colors.muted)
                      .withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  widget.enabled ? l10n.servicesEnabled : l10n.servicesDisabled,
                  style: context.textTheme.labelSmall?.copyWith(
                    color: widget.enabled ? colors.successFg : colors.muted,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
