import 'package:clinic_app/config/theme/app_theme.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/doctors_cubit.dart';
import 'package:clinic_app/features/doctors/presentation/pages/doctors_view.dart';
import 'package:clinic_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('doctors fits the 390 by 844 reference viewport', (tester) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider(
          create: (_) => DoctorsCubit(),
          child: const DoctorsView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('الأطباء'), findsWidgets);
    expect(find.text('د. أحمد محمد علي'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}
