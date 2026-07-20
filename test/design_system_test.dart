import 'package:clinic_app/config/theme/app_theme.dart';
import 'package:clinic_app/core/enums/app_button_variant.dart';
import 'package:clinic_app/shared/widgets/app_button.dart';
import 'package:clinic_app/shared/widgets/app_loader.dart';
import 'package:clinic_app/shared/widgets/app_shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  testWidgets('shared feedback widgets render and the button handles taps', (
    tester,
  ) async {
    var tapped = false;
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        home: Scaffold(
          body: Column(
            children: [
              AppButton(
                label: 'Confirm',
                variant: AppButtonVariant.danger,
                onPressed: () => tapped = true,
              ),
              const AppLoader.small(),
              const AppShimmer(width: 100, height: 20),
            ],
          ),
        ),
      ),
    );

    await tester.tap(find.text('Confirm'));
    expect(tapped, isTrue);
    expect(find.byType(LinearProgressIndicator), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });
}
