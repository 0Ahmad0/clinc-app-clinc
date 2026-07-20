import 'package:equatable/equatable.dart';

import '../../domain/app_language.dart';
import '../../domain/app_theme_choice.dart';
import '../../domain/notification_channel.dart';
import '../../domain/settings_section.dart';

class SettingsState extends Equatable {
  const SettingsState({
    this.section = SettingsSection.main,
    this.channels = const {NotificationChannel.app, NotificationChannel.sms},
    this.theme = AppThemeChoice.system,
    this.language = AppLanguage.ar,
    this.coverPath,
    this.avatarPath,
  });

  final SettingsSection section;
  final Set<NotificationChannel> channels;
  final AppThemeChoice theme;
  final AppLanguage language;

  /// Local file paths for the picked cover/avatar images (null until chosen).
  final String? coverPath;
  final String? avatarPath;

  bool isOn(NotificationChannel channel) => channels.contains(channel);

  SettingsState copyWith({
    SettingsSection? section,
    Set<NotificationChannel>? channels,
    AppThemeChoice? theme,
    AppLanguage? language,
    String? coverPath,
    String? avatarPath,
  }) => SettingsState(
    section: section ?? this.section,
    channels: channels ?? this.channels,
    theme: theme ?? this.theme,
    language: language ?? this.language,
    coverPath: coverPath ?? this.coverPath,
    avatarPath: avatarPath ?? this.avatarPath,
  );

  @override
  List<Object?> get props => [
    section,
    channels,
    theme,
    language,
    coverPath,
    avatarPath,
  ];
}
