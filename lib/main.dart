import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app.dart';
import 'core/di/service_locator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
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
