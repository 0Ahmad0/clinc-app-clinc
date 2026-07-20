import '../../../l10n/app_localizations.dart';
import '../domain/weekday.dart';

/// Localized weekday names.
extension WeekdayL10n on Weekday {
  String label(AppLocalizations l10n) => switch (this) {
    Weekday.saturday => l10n.weekdaySaturday,
    Weekday.sunday => l10n.weekdaySunday,
    Weekday.monday => l10n.weekdayMonday,
    Weekday.tuesday => l10n.weekdayTuesday,
    Weekday.wednesday => l10n.weekdayWednesday,
    Weekday.thursday => l10n.weekdayThursday,
    Weekday.friday => l10n.weekdayFriday,
  };
}
