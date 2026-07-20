import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_motion.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/account_type.dart';
import '../cubit/auth_cubit.dart';
import '../cubit/auth_state.dart';

/// The three-up account-type picker (clinic / lab / both). The selected tile
/// lifts, tints and gains a blue border.
class AccountTypeSelector extends StatelessWidget {
  const AccountTypeSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (a, b) => a.accountType != b.accountType,
      builder: (context, state) {
        final cubit = context.read<AuthCubit>();
        final options = _options(context);
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            for (var i = 0; i < options.length; i++) ...[
              if (i != 0) const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _TypeTile(
                  icon: options[i].icon,
                  title: options[i].title,
                  subtitle: options[i].subtitle,
                  selected: state.accountType == options[i].type,
                  onTap: () => cubit.selectAccountType(options[i].type),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  List<_TypeOption> _options(BuildContext context) {
    final l10n = context.l10n;
    return [
      _TypeOption(
        AccountType.clinic,
        Iconsax.hospital,
        l10n.authTypeClinic,
        l10n.authTypeClinicSub,
      ),
      _TypeOption(
        AccountType.lab,
        Iconsax.microscope,
        l10n.authTypeLab,
        l10n.authTypeLabSub,
      ),
      _TypeOption(
        AccountType.both,
        Iconsax.buildings,
        l10n.authTypeBoth,
        l10n.authTypeBothSub,
      ),
    ];
  }
}

class _TypeOption {
  const _TypeOption(this.type, this.icon, this.title, this.subtitle);
  final AccountType type;
  final IconData icon;
  final String title;
  final String subtitle;
}

class _TypeTile extends StatelessWidget {
  const _TypeTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final fg = selected ? colors.primary600 : colors.ink;

    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: AppMotion.quick,
        curve: AppMotion.emphasized,
        transform: Matrix4.translationValues(0, selected ? -2 : 0, 0),
        padding: const EdgeInsetsDirectional.symmetric(
          vertical: AppSpacing.md,
          horizontal: AppSpacing.xxs + 2,
        ),
        decoration: BoxDecoration(
          color: selected
              ? colors.primary500.withValues(alpha: 0.08)
              : colors.surface,
          borderRadius: BorderRadius.circular(AppRadius.button),
          border: Border.all(
            color: selected ? colors.primary500 : colors.line,
            width: selected ? 2 : 1.5,
          ),
          boxShadow: selected
              ? [
                  BoxShadow(
                    color: colors.primary500.withValues(alpha: 0.28),
                    blurRadius: 24,
                    spreadRadius: -10,
                    offset: const Offset(0, 10),
                  ),
                ]
              : null,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 24, color: fg),
            const SizedBox(height: AppSpacing.xxs + 2),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: fg,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: context.textTheme.labelSmall?.copyWith(
                fontSize: 10.5,
                color: fg.withValues(alpha: 0.75),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
