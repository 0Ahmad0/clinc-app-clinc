import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/app_language.dart';
import '../../domain/app_theme_choice.dart';
import '../../domain/notification_channel.dart';
import '../../domain/settings_section.dart';
import 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(const SettingsState());

  void show(SettingsSection section) =>
      emit(state.copyWith(section: section));

  void toggleChannel(NotificationChannel channel) {
    final channels = {...state.channels};
    if (!channels.remove(channel)) channels.add(channel);
    emit(state.copyWith(channels: channels));
  }

  void setTheme(AppThemeChoice theme) => emit(state.copyWith(theme: theme));

  void setLanguage(AppLanguage language) =>
      emit(state.copyWith(language: language));

  void setCover(String path) => emit(state.copyWith(coverPath: path));

  void setAvatar(String path) => emit(state.copyWith(avatarPath: path));
}

