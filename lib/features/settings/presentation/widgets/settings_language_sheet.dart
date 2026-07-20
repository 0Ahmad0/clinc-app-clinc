import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/app_language.dart';
import '../settings_choice_labels.dart';
import 'settings_choice_tile.dart';
import 'settings_sheet_header.dart';

/// Language picker sheet. Pops the chosen [AppLanguage], or nothing on dismiss.
class SettingsLanguageSheet extends StatelessWidget {
  const SettingsLanguageSheet({super.key, required this.current});

  final AppLanguage current;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SettingsSheetHeader(
            icon: Iconsax.global,
            title: l10n.settingsLanguage,
          ),
          AppGaps.h16,
          for (final language in AppLanguage.values)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
              child: SettingsChoiceTile(
                icon: Iconsax.global,
                name: language.label(l10n),
                sub: language.sub(l10n),
                selected: current == language,
                onTap: () => Navigator.of(context).pop(language),
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
