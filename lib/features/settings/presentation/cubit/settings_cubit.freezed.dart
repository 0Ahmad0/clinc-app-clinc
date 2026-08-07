// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'settings_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SettingsState {

 SettingsSection get section; Set<NotificationChannel> get channels; AppThemeChoice get theme; AppLanguage get language; String? get coverPath; String? get avatarPath; ClinicSettingsClinicModel? get clinic; List<ClinicInsuranceModel> get insurances; Set<int> get selectedInsuranceIds; bool get pendingUpdate; bool get isLoading; bool get isLoadingInsurances; bool get isSavingProfile; bool get profileSaved; bool get isChangingPassword; bool get passwordChanged; Set<NotificationChannel> get busyNotificationChannels; NetworkExceptions? get failure;
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SettingsStateCopyWith<SettingsState> get copyWith => _$SettingsStateCopyWithImpl<SettingsState>(this as SettingsState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SettingsState&&(identical(other.section, section) || other.section == section)&&const DeepCollectionEquality().equals(other.channels, channels)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.language, language) || other.language == language)&&(identical(other.coverPath, coverPath) || other.coverPath == coverPath)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.clinic, clinic) || other.clinic == clinic)&&const DeepCollectionEquality().equals(other.insurances, insurances)&&const DeepCollectionEquality().equals(other.selectedInsuranceIds, selectedInsuranceIds)&&(identical(other.pendingUpdate, pendingUpdate) || other.pendingUpdate == pendingUpdate)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingInsurances, isLoadingInsurances) || other.isLoadingInsurances == isLoadingInsurances)&&(identical(other.isSavingProfile, isSavingProfile) || other.isSavingProfile == isSavingProfile)&&(identical(other.profileSaved, profileSaved) || other.profileSaved == profileSaved)&&(identical(other.isChangingPassword, isChangingPassword) || other.isChangingPassword == isChangingPassword)&&(identical(other.passwordChanged, passwordChanged) || other.passwordChanged == passwordChanged)&&const DeepCollectionEquality().equals(other.busyNotificationChannels, busyNotificationChannels)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,section,const DeepCollectionEquality().hash(channels),theme,language,coverPath,avatarPath,clinic,const DeepCollectionEquality().hash(insurances),const DeepCollectionEquality().hash(selectedInsuranceIds),pendingUpdate,isLoading,isLoadingInsurances,isSavingProfile,profileSaved,isChangingPassword,passwordChanged,const DeepCollectionEquality().hash(busyNotificationChannels),failure);

@override
String toString() {
  return 'SettingsState(section: $section, channels: $channels, theme: $theme, language: $language, coverPath: $coverPath, avatarPath: $avatarPath, clinic: $clinic, insurances: $insurances, selectedInsuranceIds: $selectedInsuranceIds, pendingUpdate: $pendingUpdate, isLoading: $isLoading, isLoadingInsurances: $isLoadingInsurances, isSavingProfile: $isSavingProfile, profileSaved: $profileSaved, isChangingPassword: $isChangingPassword, passwordChanged: $passwordChanged, busyNotificationChannels: $busyNotificationChannels, failure: $failure)';
}


}

/// @nodoc
abstract mixin class $SettingsStateCopyWith<$Res>  {
  factory $SettingsStateCopyWith(SettingsState value, $Res Function(SettingsState) _then) = _$SettingsStateCopyWithImpl;
@useResult
$Res call({
 SettingsSection section, Set<NotificationChannel> channels, AppThemeChoice theme, AppLanguage language, String? coverPath, String? avatarPath, ClinicSettingsClinicModel? clinic, List<ClinicInsuranceModel> insurances, Set<int> selectedInsuranceIds, bool pendingUpdate, bool isLoading, bool isLoadingInsurances, bool isSavingProfile, bool profileSaved, bool isChangingPassword, bool passwordChanged, Set<NotificationChannel> busyNotificationChannels, NetworkExceptions? failure
});


$ClinicSettingsClinicModelCopyWith<$Res>? get clinic;$NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class _$SettingsStateCopyWithImpl<$Res>
    implements $SettingsStateCopyWith<$Res> {
  _$SettingsStateCopyWithImpl(this._self, this._then);

  final SettingsState _self;
  final $Res Function(SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? section = null,Object? channels = null,Object? theme = null,Object? language = null,Object? coverPath = freezed,Object? avatarPath = freezed,Object? clinic = freezed,Object? insurances = null,Object? selectedInsuranceIds = null,Object? pendingUpdate = null,Object? isLoading = null,Object? isLoadingInsurances = null,Object? isSavingProfile = null,Object? profileSaved = null,Object? isChangingPassword = null,Object? passwordChanged = null,Object? busyNotificationChannels = null,Object? failure = freezed,}) {
  return _then(_self.copyWith(
section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as SettingsSection,channels: null == channels ? _self.channels : channels // ignore: cast_nullable_to_non_nullable
as Set<NotificationChannel>,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemeChoice,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,coverPath: freezed == coverPath ? _self.coverPath : coverPath // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicSettingsClinicModel?,insurances: null == insurances ? _self.insurances : insurances // ignore: cast_nullable_to_non_nullable
as List<ClinicInsuranceModel>,selectedInsuranceIds: null == selectedInsuranceIds ? _self.selectedInsuranceIds : selectedInsuranceIds // ignore: cast_nullable_to_non_nullable
as Set<int>,pendingUpdate: null == pendingUpdate ? _self.pendingUpdate : pendingUpdate // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingInsurances: null == isLoadingInsurances ? _self.isLoadingInsurances : isLoadingInsurances // ignore: cast_nullable_to_non_nullable
as bool,isSavingProfile: null == isSavingProfile ? _self.isSavingProfile : isSavingProfile // ignore: cast_nullable_to_non_nullable
as bool,profileSaved: null == profileSaved ? _self.profileSaved : profileSaved // ignore: cast_nullable_to_non_nullable
as bool,isChangingPassword: null == isChangingPassword ? _self.isChangingPassword : isChangingPassword // ignore: cast_nullable_to_non_nullable
as bool,passwordChanged: null == passwordChanged ? _self.passwordChanged : passwordChanged // ignore: cast_nullable_to_non_nullable
as bool,busyNotificationChannels: null == busyNotificationChannels ? _self.busyNotificationChannels : busyNotificationChannels // ignore: cast_nullable_to_non_nullable
as Set<NotificationChannel>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}
/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicSettingsClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicSettingsClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionsCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $NetworkExceptionsCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}


/// Adds pattern-matching-related methods to [SettingsState].
extension SettingsStatePatterns on SettingsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SettingsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SettingsState value)  $default,){
final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SettingsState value)?  $default,){
final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SettingsSection section,  Set<NotificationChannel> channels,  AppThemeChoice theme,  AppLanguage language,  String? coverPath,  String? avatarPath,  ClinicSettingsClinicModel? clinic,  List<ClinicInsuranceModel> insurances,  Set<int> selectedInsuranceIds,  bool pendingUpdate,  bool isLoading,  bool isLoadingInsurances,  bool isSavingProfile,  bool profileSaved,  bool isChangingPassword,  bool passwordChanged,  Set<NotificationChannel> busyNotificationChannels,  NetworkExceptions? failure)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.section,_that.channels,_that.theme,_that.language,_that.coverPath,_that.avatarPath,_that.clinic,_that.insurances,_that.selectedInsuranceIds,_that.pendingUpdate,_that.isLoading,_that.isLoadingInsurances,_that.isSavingProfile,_that.profileSaved,_that.isChangingPassword,_that.passwordChanged,_that.busyNotificationChannels,_that.failure);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SettingsSection section,  Set<NotificationChannel> channels,  AppThemeChoice theme,  AppLanguage language,  String? coverPath,  String? avatarPath,  ClinicSettingsClinicModel? clinic,  List<ClinicInsuranceModel> insurances,  Set<int> selectedInsuranceIds,  bool pendingUpdate,  bool isLoading,  bool isLoadingInsurances,  bool isSavingProfile,  bool profileSaved,  bool isChangingPassword,  bool passwordChanged,  Set<NotificationChannel> busyNotificationChannels,  NetworkExceptions? failure)  $default,) {final _that = this;
switch (_that) {
case _SettingsState():
return $default(_that.section,_that.channels,_that.theme,_that.language,_that.coverPath,_that.avatarPath,_that.clinic,_that.insurances,_that.selectedInsuranceIds,_that.pendingUpdate,_that.isLoading,_that.isLoadingInsurances,_that.isSavingProfile,_that.profileSaved,_that.isChangingPassword,_that.passwordChanged,_that.busyNotificationChannels,_that.failure);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SettingsSection section,  Set<NotificationChannel> channels,  AppThemeChoice theme,  AppLanguage language,  String? coverPath,  String? avatarPath,  ClinicSettingsClinicModel? clinic,  List<ClinicInsuranceModel> insurances,  Set<int> selectedInsuranceIds,  bool pendingUpdate,  bool isLoading,  bool isLoadingInsurances,  bool isSavingProfile,  bool profileSaved,  bool isChangingPassword,  bool passwordChanged,  Set<NotificationChannel> busyNotificationChannels,  NetworkExceptions? failure)?  $default,) {final _that = this;
switch (_that) {
case _SettingsState() when $default != null:
return $default(_that.section,_that.channels,_that.theme,_that.language,_that.coverPath,_that.avatarPath,_that.clinic,_that.insurances,_that.selectedInsuranceIds,_that.pendingUpdate,_that.isLoading,_that.isLoadingInsurances,_that.isSavingProfile,_that.profileSaved,_that.isChangingPassword,_that.passwordChanged,_that.busyNotificationChannels,_that.failure);case _:
  return null;

}
}

}

/// @nodoc


class _SettingsState implements SettingsState {
  const _SettingsState({this.section = SettingsSection.main, final  Set<NotificationChannel> channels = const {NotificationChannel.app, NotificationChannel.sms}, this.theme = AppThemeChoice.system, this.language = AppLanguage.ar, this.coverPath, this.avatarPath, this.clinic, final  List<ClinicInsuranceModel> insurances = const <ClinicInsuranceModel>[], final  Set<int> selectedInsuranceIds = const <int>{}, this.pendingUpdate = false, this.isLoading = false, this.isLoadingInsurances = false, this.isSavingProfile = false, this.profileSaved = false, this.isChangingPassword = false, this.passwordChanged = false, final  Set<NotificationChannel> busyNotificationChannels = const <NotificationChannel>{}, this.failure}): _channels = channels,_insurances = insurances,_selectedInsuranceIds = selectedInsuranceIds,_busyNotificationChannels = busyNotificationChannels;
  

@override@JsonKey() final  SettingsSection section;
 final  Set<NotificationChannel> _channels;
@override@JsonKey() Set<NotificationChannel> get channels {
  if (_channels is EqualUnmodifiableSetView) return _channels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_channels);
}

@override@JsonKey() final  AppThemeChoice theme;
@override@JsonKey() final  AppLanguage language;
@override final  String? coverPath;
@override final  String? avatarPath;
@override final  ClinicSettingsClinicModel? clinic;
 final  List<ClinicInsuranceModel> _insurances;
@override@JsonKey() List<ClinicInsuranceModel> get insurances {
  if (_insurances is EqualUnmodifiableListView) return _insurances;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_insurances);
}

 final  Set<int> _selectedInsuranceIds;
@override@JsonKey() Set<int> get selectedInsuranceIds {
  if (_selectedInsuranceIds is EqualUnmodifiableSetView) return _selectedInsuranceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_selectedInsuranceIds);
}

@override@JsonKey() final  bool pendingUpdate;
@override@JsonKey() final  bool isLoading;
@override@JsonKey() final  bool isLoadingInsurances;
@override@JsonKey() final  bool isSavingProfile;
@override@JsonKey() final  bool profileSaved;
@override@JsonKey() final  bool isChangingPassword;
@override@JsonKey() final  bool passwordChanged;
 final  Set<NotificationChannel> _busyNotificationChannels;
@override@JsonKey() Set<NotificationChannel> get busyNotificationChannels {
  if (_busyNotificationChannels is EqualUnmodifiableSetView) return _busyNotificationChannels;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_busyNotificationChannels);
}

@override final  NetworkExceptions? failure;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SettingsStateCopyWith<_SettingsState> get copyWith => __$SettingsStateCopyWithImpl<_SettingsState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SettingsState&&(identical(other.section, section) || other.section == section)&&const DeepCollectionEquality().equals(other._channels, _channels)&&(identical(other.theme, theme) || other.theme == theme)&&(identical(other.language, language) || other.language == language)&&(identical(other.coverPath, coverPath) || other.coverPath == coverPath)&&(identical(other.avatarPath, avatarPath) || other.avatarPath == avatarPath)&&(identical(other.clinic, clinic) || other.clinic == clinic)&&const DeepCollectionEquality().equals(other._insurances, _insurances)&&const DeepCollectionEquality().equals(other._selectedInsuranceIds, _selectedInsuranceIds)&&(identical(other.pendingUpdate, pendingUpdate) || other.pendingUpdate == pendingUpdate)&&(identical(other.isLoading, isLoading) || other.isLoading == isLoading)&&(identical(other.isLoadingInsurances, isLoadingInsurances) || other.isLoadingInsurances == isLoadingInsurances)&&(identical(other.isSavingProfile, isSavingProfile) || other.isSavingProfile == isSavingProfile)&&(identical(other.profileSaved, profileSaved) || other.profileSaved == profileSaved)&&(identical(other.isChangingPassword, isChangingPassword) || other.isChangingPassword == isChangingPassword)&&(identical(other.passwordChanged, passwordChanged) || other.passwordChanged == passwordChanged)&&const DeepCollectionEquality().equals(other._busyNotificationChannels, _busyNotificationChannels)&&(identical(other.failure, failure) || other.failure == failure));
}


@override
int get hashCode => Object.hash(runtimeType,section,const DeepCollectionEquality().hash(_channels),theme,language,coverPath,avatarPath,clinic,const DeepCollectionEquality().hash(_insurances),const DeepCollectionEquality().hash(_selectedInsuranceIds),pendingUpdate,isLoading,isLoadingInsurances,isSavingProfile,profileSaved,isChangingPassword,passwordChanged,const DeepCollectionEquality().hash(_busyNotificationChannels),failure);

@override
String toString() {
  return 'SettingsState(section: $section, channels: $channels, theme: $theme, language: $language, coverPath: $coverPath, avatarPath: $avatarPath, clinic: $clinic, insurances: $insurances, selectedInsuranceIds: $selectedInsuranceIds, pendingUpdate: $pendingUpdate, isLoading: $isLoading, isLoadingInsurances: $isLoadingInsurances, isSavingProfile: $isSavingProfile, profileSaved: $profileSaved, isChangingPassword: $isChangingPassword, passwordChanged: $passwordChanged, busyNotificationChannels: $busyNotificationChannels, failure: $failure)';
}


}

/// @nodoc
abstract mixin class _$SettingsStateCopyWith<$Res> implements $SettingsStateCopyWith<$Res> {
  factory _$SettingsStateCopyWith(_SettingsState value, $Res Function(_SettingsState) _then) = __$SettingsStateCopyWithImpl;
@override @useResult
$Res call({
 SettingsSection section, Set<NotificationChannel> channels, AppThemeChoice theme, AppLanguage language, String? coverPath, String? avatarPath, ClinicSettingsClinicModel? clinic, List<ClinicInsuranceModel> insurances, Set<int> selectedInsuranceIds, bool pendingUpdate, bool isLoading, bool isLoadingInsurances, bool isSavingProfile, bool profileSaved, bool isChangingPassword, bool passwordChanged, Set<NotificationChannel> busyNotificationChannels, NetworkExceptions? failure
});


@override $ClinicSettingsClinicModelCopyWith<$Res>? get clinic;@override $NetworkExceptionsCopyWith<$Res>? get failure;

}
/// @nodoc
class __$SettingsStateCopyWithImpl<$Res>
    implements _$SettingsStateCopyWith<$Res> {
  __$SettingsStateCopyWithImpl(this._self, this._then);

  final _SettingsState _self;
  final $Res Function(_SettingsState) _then;

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? section = null,Object? channels = null,Object? theme = null,Object? language = null,Object? coverPath = freezed,Object? avatarPath = freezed,Object? clinic = freezed,Object? insurances = null,Object? selectedInsuranceIds = null,Object? pendingUpdate = null,Object? isLoading = null,Object? isLoadingInsurances = null,Object? isSavingProfile = null,Object? profileSaved = null,Object? isChangingPassword = null,Object? passwordChanged = null,Object? busyNotificationChannels = null,Object? failure = freezed,}) {
  return _then(_SettingsState(
section: null == section ? _self.section : section // ignore: cast_nullable_to_non_nullable
as SettingsSection,channels: null == channels ? _self._channels : channels // ignore: cast_nullable_to_non_nullable
as Set<NotificationChannel>,theme: null == theme ? _self.theme : theme // ignore: cast_nullable_to_non_nullable
as AppThemeChoice,language: null == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as AppLanguage,coverPath: freezed == coverPath ? _self.coverPath : coverPath // ignore: cast_nullable_to_non_nullable
as String?,avatarPath: freezed == avatarPath ? _self.avatarPath : avatarPath // ignore: cast_nullable_to_non_nullable
as String?,clinic: freezed == clinic ? _self.clinic : clinic // ignore: cast_nullable_to_non_nullable
as ClinicSettingsClinicModel?,insurances: null == insurances ? _self._insurances : insurances // ignore: cast_nullable_to_non_nullable
as List<ClinicInsuranceModel>,selectedInsuranceIds: null == selectedInsuranceIds ? _self._selectedInsuranceIds : selectedInsuranceIds // ignore: cast_nullable_to_non_nullable
as Set<int>,pendingUpdate: null == pendingUpdate ? _self.pendingUpdate : pendingUpdate // ignore: cast_nullable_to_non_nullable
as bool,isLoading: null == isLoading ? _self.isLoading : isLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingInsurances: null == isLoadingInsurances ? _self.isLoadingInsurances : isLoadingInsurances // ignore: cast_nullable_to_non_nullable
as bool,isSavingProfile: null == isSavingProfile ? _self.isSavingProfile : isSavingProfile // ignore: cast_nullable_to_non_nullable
as bool,profileSaved: null == profileSaved ? _self.profileSaved : profileSaved // ignore: cast_nullable_to_non_nullable
as bool,isChangingPassword: null == isChangingPassword ? _self.isChangingPassword : isChangingPassword // ignore: cast_nullable_to_non_nullable
as bool,passwordChanged: null == passwordChanged ? _self.passwordChanged : passwordChanged // ignore: cast_nullable_to_non_nullable
as bool,busyNotificationChannels: null == busyNotificationChannels ? _self._busyNotificationChannels : busyNotificationChannels // ignore: cast_nullable_to_non_nullable
as Set<NotificationChannel>,failure: freezed == failure ? _self.failure : failure // ignore: cast_nullable_to_non_nullable
as NetworkExceptions?,
  ));
}

/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ClinicSettingsClinicModelCopyWith<$Res>? get clinic {
    if (_self.clinic == null) {
    return null;
  }

  return $ClinicSettingsClinicModelCopyWith<$Res>(_self.clinic!, (value) {
    return _then(_self.copyWith(clinic: value));
  });
}/// Create a copy of SettingsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$NetworkExceptionsCopyWith<$Res>? get failure {
    if (_self.failure == null) {
    return null;
  }

  return $NetworkExceptionsCopyWith<$Res>(_self.failure!, (value) {
    return _then(_self.copyWith(failure: value));
  });
}
}

// dart format on
