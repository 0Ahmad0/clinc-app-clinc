import 'dart:async';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';

import '../data/remote/api_response.dart';
import '../../features/notifications/domain/clinic_notifications_repository.dart';
import 'storage_service.dart';

class FcmTokenSyncService {
  FcmTokenSyncService(this._repository);

  final ClinicNotificationsRepository _repository;
  StreamSubscription<String>? _refreshSubscription;
  String? _lastSyncedToken;
  bool _initialized = false;

  Future<void> init() async {
    if (_initialized) return;
    _initialized = true;
    _refreshSubscription = FirebaseMessaging.instance.onTokenRefresh.listen(
      (token) => unawaited(syncToken(token: token)),
    );
    await syncCurrentToken();
  }

  Future<void> syncCurrentToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    await syncToken(token: token);
  }

  Future<void> syncToken({String? token}) async {
    if (token == null || token.isEmpty) return;
    if (StorageService.instance.getAccessToken().isEmpty) return;
    if (_lastSyncedToken == token) return;

    final result = await _repository.storeDeviceToken(
      token: token,
      platform: _platform,
      locale: StorageService.instance.languageCode,
    );
    if (result is Success) _lastSyncedToken = token;
  }

  Future<Map<String, dynamic>> registerPayload() async {
    final token = await FirebaseMessaging.instance.getToken();
    if (token == null || token.isEmpty) return const {};
    return {
      'fcm_token': token,
      'platform': _platform,
      'locale': StorageService.instance.languageCode,
    };
  }

  String get _platform {
    if (kIsWeb) return 'web';
    return switch (defaultTargetPlatform) {
      TargetPlatform.iOS => 'ios',
      _ => 'android',
    };
  }

  Future<void> dispose() async {
    await _refreshSubscription?.cancel();
  }
}
