import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';
import 'core/di/service_locator.dart';
import 'core/services/fcm_token_sync_service.dart';
import 'core/services/notification_service.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(
    clinicFirebaseMessagingBackgroundHandler,
  );
  await Future.wait([ScreenUtil.ensureScreenSize(), GetStorage.init()]);
  configureDependencies();
  unawaited(NotificationService.instance.init());
  unawaited(sl<FcmTokenSyncService>().init());
  // Warm the font cache before first frame so text doesn't pop in or jank on
  // the first navigation to each screen. Time-boxed so an offline start still
  // proceeds (it just falls back until the font arrives).
  try {
    await GoogleFonts.pendingFonts([
      GoogleFonts.ibmPlexSansArabic(),
    ]).timeout(const Duration(seconds: 3));
  } catch (_) {}
  runApp(const App());
}
