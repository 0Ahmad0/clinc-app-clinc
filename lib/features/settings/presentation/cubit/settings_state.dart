part of 'settings_cubit.dart';

@freezed
abstract class SettingsState with _$SettingsState {
  const factory SettingsState({
    @Default(SettingsSection.main) SettingsSection section,
    @Default({NotificationChannel.app, NotificationChannel.sms})
    Set<NotificationChannel> channels,
    @Default(AppThemeChoice.system) AppThemeChoice theme,
    @Default(AppLanguage.ar) AppLanguage language,
    String? coverPath,
    String? avatarPath,
    ClinicSettingsClinicModel? clinic,
    @Default(false) bool pendingUpdate,
    @Default(false) bool isLoading,
    @Default(false) bool isSavingProfile,
    @Default(false) bool profileSaved,
    @Default(false) bool isChangingPassword,
    @Default(false) bool passwordChanged,
    NetworkExceptions? failure,
  }) = _SettingsState;
}

extension SettingsStateX on SettingsState {
  bool isOn(NotificationChannel channel) => channels.contains(channel);
}
