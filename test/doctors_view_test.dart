import 'package:clinic_app/core/data/base_model.dart';
import 'package:clinic_app/core/data/remote/api_response.dart';
import 'package:clinic_app/config/theme/app_theme.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_doctor_model.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_specialization_model.dart';
import 'package:clinic_app/features/doctors/domain/clinic_doctors_repository.dart';
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
          create: (_) => DoctorsCubit(_FakeClinicDoctorsRepository()),
          child: const DoctorsView(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('الأطباء'), findsWidgets);
    expect(find.text('لا توجد نتائج مطابقة'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

class _FakeClinicDoctorsRepository implements ClinicDoctorsRepository {
  @override
  Future<ApiResponse<BaseModel<BaseModels<ClinicDoctorModel>>>> getDoctors({
    required int page,
    required int perPage,
    String? search,
    String? specializationId,
    bool? isActive,
  }) async => ApiResponse.success(
    BaseModel(result: BaseModels<ClinicDoctorModel>(list: [])),
  );

  @override
  Future<ApiResponse<BaseModel<BaseModels<ClinicSpecializationModel>>>>
  getSpecializations() async => ApiResponse.success(
    BaseModel(result: BaseModels<ClinicSpecializationModel>(list: [])),
  );

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
