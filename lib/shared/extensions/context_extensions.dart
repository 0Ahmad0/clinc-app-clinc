import 'package:flutter/material.dart';

import '../../config/theme/app_colors.dart';
import '../../l10n/app_localizations.dart';

/// Ergonomic accessors used everywhere instead of `Theme.of` /
/// `AppLocalizations.of`. Widgets read design tokens and copy through these.
extension BuildContextX on BuildContext {
  ThemeData get theme => Theme.of(this);

  /// Theme-aware design colors (`context.colors.primary600`, `.surface`, …).
  AppColorsTheme get colors => theme.extension<AppColorsTheme>()!;

  TextTheme get textTheme => theme.textTheme;

  /// Localized strings (`context.l10n.appBrand`).
  AppLocalizations get l10n => AppLocalizations.of(this);
}
