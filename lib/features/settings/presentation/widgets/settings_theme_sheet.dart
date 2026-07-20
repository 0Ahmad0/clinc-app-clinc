import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/app_theme_choice.dart';
import '../settings_choice_labels.dart';
import 'settings_choice_tile.dart';
import 'settings_sheet_header.dart';

/// Theme picker sheet. Pops the chosen [AppThemeChoice], or nothing on dismiss.
class SettingsThemeSheet extends StatelessWidget {
  const SettingsThemeSheet({super.key, required this.current});

  final AppThemeChoice current;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsSheetHeader(icon: Iconsax.brush_2, title: l10n.settingsTheme),
          AppGaps.h16,
          for (final choice in AppThemeChoice.values)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
              child: SettingsChoiceTile(
                icon: choice.icon,
                name: choice.label(l10n),
                sub: choice.sub(l10n),
                selected: current == choice,
                onTap: () => Navigator.of(context).pop(choice),
              ),
            ),
          AppGaps.h8,
          AppButton(
            label: l10n.commonClose,
            variant: AppButtonVariant.ghost,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}
