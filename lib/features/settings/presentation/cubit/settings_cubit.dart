import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/models/clinic_settings_model.dart';
import '../../domain/app_language.dart';
import '../../domain/app_theme_choice.dart';
import '../../domain/clinic_settings_repository.dart';
import '../../domain/notification_channel.dart';
import '../../domain/settings_section.dart';

part 'settings_cubit.freezed.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit(this._repository) : super(const SettingsState());

  final ClinicSettingsRepository _repository;

  Future<void> loadInitial() async {
    emit(state.copyWith(isLoading: true, failure: null));
    final profileResult = await _repository.profile();
    profileResult.when(
      success: (response) => emit(
        state.copyWith(
          clinic: response.result?.clinic,
          pendingUpdate: response.result?.pendingUpdate ?? false,
          isLoading: false,
          failure: null,
        ),
      ),
      failure: (exception) =>
          emit(state.copyWith(isLoading: false, failure: exception)),
    );
    await loadNotificationSettings();
  }

  Future<void> loadNotificationSettings() async {
    final result = await _repository.notificationSettings();
    result.when(
      success: (response) =>
          emit(state.copyWith(channels: _channels(response.result))),
      failure: (exception) => emit(state.copyWith(failure: exception)),
    );
  }

  void show(SettingsSection section) => emit(state.copyWith(section: section));

  Future<void> toggleChannel(NotificationChannel channel) async {
    final channels = {...state.channels};
    if (!channels.remove(channel)) channels.add(channel);
    emit(state.copyWith(channels: channels, failure: null));

    final result = await _repository.updateNotificationSettings(
      appNotifications: channels.contains(NotificationChannel.app),
      emailNotifications: channels.contains(NotificationChannel.email),
      smsNotifications: channels.contains(NotificationChannel.sms),
    );
    result.when(
      success: (response) =>
          emit(state.copyWith(channels: _channels(response.result))),
      failure: (exception) => emit(state.copyWith(failure: exception)),
    );
  }

  void setTheme(AppThemeChoice theme) => emit(state.copyWith(theme: theme));

  void setLanguage(AppLanguage language) =>
      emit(state.copyWith(language: language));

  void setCover(String path) => emit(state.copyWith(coverPath: path));

  void setAvatar(String path) => emit(state.copyWith(avatarPath: path));

  Future<void> updateProfile({
    required String name,
    required String email,
    required String phone,
    required String location,
    required String description,
    required String website,
  }) async {
    emit(state.copyWith(isSavingProfile: true, failure: null));
    final result = await _repository.updateProfile(
      fields: {
        'name': name,
        'email': email,
        'phone': phone,
        'location': location,
        'description': description,
        'website': website,
      },
      logoPath: state.avatarPath,
      coverPath: state.coverPath,
    );
    result.when(
      success: (response) => emit(
        state.copyWith(
          clinic: response.result?.clinic ?? state.clinic,
          pendingUpdate: response.result?.submittedForReview ?? false,
          coverPath: null,
          avatarPath: null,
          isSavingProfile: false,
          section: SettingsSection.main,
          failure: null,
        ),
      ),
      failure: (exception) =>
          emit(state.copyWith(isSavingProfile: false, failure: exception)),
    );
  }

  Future<void> changePassword({
    required String currentPassword,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(
      state.copyWith(
        isChangingPassword: true,
        passwordChanged: false,
        failure: null,
      ),
    );
    final result = await _repository.changePassword(
      currentPassword: currentPassword,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    result.when(
      success: (response) => emit(
        state.copyWith(
          isChangingPassword: false,
          passwordChanged: response.result?.passwordChanged ?? true,
          section: SettingsSection.main,
          failure: null,
        ),
      ),
      failure: (exception) => emit(
        state.copyWith(
          isChangingPassword: false,
          passwordChanged: false,
          failure: exception,
        ),
      ),
    );
  }

  Set<NotificationChannel> _channels(ClinicNotificationSettingsModel? model) {
    if (model == null) return state.channels;
    return {
      if (model.appNotifications) NotificationChannel.app,
      if (model.emailNotifications) NotificationChannel.email,
      if (model.smsNotifications) NotificationChannel.sms,
    };
  }
}
