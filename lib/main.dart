import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/bindings/initial_binding.dart';
import 'app/controllers/settings_app_controller.dart';
import 'app/core/constants/app_constants.dart';
import 'app/core/theme/app_theme.dart';
import 'app/routes/app_pages.dart';
import 'app/routes/app_routes.dart';
import 'generated/codegen_loader.g.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.wait([
    EasyLocalization.ensureInitialized(),
    ScreenUtil.ensureScreenSize(),
    GetStorage.init(),
  ]);
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  Get.put(SettingsAppController(), permanent: true);
  runApp(
    EasyLocalization(
      supportedLocales: const [
        Locale(AppConstants.arLang),
        Locale(AppConstants.enLang),
      ],
      startLocale: Locale(AppConstants.arLang),
      fallbackLocale: const Locale(AppConstants.arLang),
      path: AppConstants.translationPath,
      assetLoader: const CodegenLoader(),
      child: const App(),
    ),
  );
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(
        AppConstants.designWidth,
        AppConstants.designHeight,
      ),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetBuilder<SettingsAppController>(
          id: 'app_localization',
          builder: (settingsController) {
            return GetMaterialApp(
              initialBinding: InitialBinding(),
              theme: AppTheme.lightTheme(context.locale.languageCode),
              darkTheme: AppTheme.darkTheme(context.locale.languageCode),
              themeMode: settingsController.themeMode,
              locale: context.locale,
              supportedLocales: context.supportedLocales,
              localizationsDelegates: [
                ...context.localizationDelegates,
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
              ],
              defaultTransition: Transition.upToDown,
              debugShowCheckedModeBanner: false,
              getPages: AppPages.routes,
              initialRoute: AppRoutes.mainLayout,
              builder: (context, child) {
                return MediaQuery(
                  data: MediaQuery.of(
                    context,
                  ).copyWith(textScaler: TextScaler.linear(1.0)),
                  child: child!,
                );
              },
            );
          },
        );
      },
    );
  }
}
