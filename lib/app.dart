import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'config/routes/app_router.dart';
import 'config/theme/app_theme.dart';
import 'core/services/storage_service.dart';
import 'core/utils/dialogs/general_dialog.dart';
import 'l10n/app_localizations.dart';

/// Root application widget: themes, localization, RTL, and routing.
class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = StorageService.instance;
    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return ValueListenableBuilder<int>(
          valueListenable: storage.appPreferencesVersion,
          builder: (context, _, _) {
            return MaterialApp.router(
              onGenerateTitle: (context) =>
                  AppLocalizations.of(context).appBrand,
              debugShowCheckedModeBanner: false,
              scaffoldMessengerKey: AppRouter.scaffoldMessengerKey,
              theme: AppTheme.light,
              darkTheme: AppTheme.dark,
              themeMode: storage.appThemeMode,
              localizationsDelegates: AppLocalizations.localizationsDelegates,
              supportedLocales: AppLocalizations.supportedLocales,
              locale: storage.locale,
              routerConfig: AppRouter.router,
            );
          },
        );
      },
    );
  }
}
