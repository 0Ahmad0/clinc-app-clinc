import 'package:flutter/widgets.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../l10n/app_localizations.dart';
import '../domain/app_language.dart';
import '../domain/app_theme_choice.dart';

/// Localized name, description and icon for each theme option.
extension AppThemeChoiceLabels on AppThemeChoice {
  String label(AppLocalizations l10n) => switch (this) {
    AppThemeChoice.system => l10n.settingsThemeSystem,
    AppThemeChoice.light => l10n.settingsThemeLight,
    AppThemeChoice.dark => l10n.settingsThemeDark,
  };

  String sub(AppLocalizations l10n) => switch (this) {
    AppThemeChoice.system => l10n.settingsThemeSystemSub,
    AppThemeChoice.light => l10n.settingsThemeLightSub,
    AppThemeChoice.dark => l10n.settingsThemeDarkSub,
  };

  IconData get icon => switch (this) {
    AppThemeChoice.system => Iconsax.monitor,
    AppThemeChoice.light => Iconsax.sun_1,
    AppThemeChoice.dark => Iconsax.moon,
  };
}

/// Localized name and description for each language option.
extension AppLanguageLabels on AppLanguage {
  String label(AppLocalizations l10n) => switch (this) {
    AppLanguage.ar => l10n.settingsLangAr,
    AppLanguage.en => l10n.settingsLangEn,
  };

  String sub(AppLocalizations l10n) => switch (this) {
    AppLanguage.ar => l10n.settingsLangArSub,
    AppLanguage.en => l10n.settingsLangEnSub,
  };
}
