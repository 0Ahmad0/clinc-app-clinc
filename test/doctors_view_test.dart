import 'package:clinic_app/core/data/base_model.dart';
import 'package:clinic_app/core/data/remote/api_response.dart';
import 'package:clinic_app/config/theme/app_theme.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_doctor_model.dart';
import 'package:clinic_app/features/doctors/data/models/clinic_specialization_model.dart';
import 'package:clinic_app/features/doctors/domain/clinic_doctors_repository.dart';
import 'package:clinic_app/features/doctors/domain/weekday.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/add_doctor_cubit.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/doctors_cubit.dart';
import 'package:clinic_app/features/doctors/presentation/cubit/doctors_state.dart';
import 'package:clinic_app/features/doctors/presentation/pages/doctors_view.dart';
import 'package:clinic_app/features/doctors/presentation/widgets/add_doctor_schedule_section.dart';
import 'package:clinic_app/features/doctors/presentation/widgets/doctor_profile_schedule.dart';
import 'package:clinic_app/features/doctors/presentation/widgets/doctors_header.dart';
import 'package:clinic_app/features/doctors/presentation/widgets/doctors_list.dart';
import 'package:clinic_app/core/data/pagination/pagination_state.dart';
import 'package:clinic_app/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

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

  testWidgets('doctors list shows shimmer while filters load', (tester) async {
    final cubit = DoctorsCubit(_FakeClinicDoctorsRepository());
    addTearDown(cubit.close);
    cubit.emit(
      DoctorsState(
        pagination: PaginationState<ClinicDoctorModel>(),
        isFiltersLoading: true,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider.value(
          value: cubit,
          child: const CustomScrollView(slivers: [DoctorsList()]),
        ),
      ),
    );

    expect(find.text('لا توجد نتائج مطابقة'), findsNothing);
    expect(find.byType(Shimmer), findsWidgets);
  });

  testWidgets('doctors header stats show shimmer while loading', (
    tester,
  ) async {
    final cubit = DoctorsCubit(_FakeClinicDoctorsRepository());
    addTearDown(cubit.close);
    cubit.emit(
      DoctorsState(
        pagination: PaginationState<ClinicDoctorModel>(),
        isFiltersLoading: true,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider.value(
          value: cubit,
          child: const SizedBox(height: 160, child: DoctorsHeader()),
        ),
      ),
    );

    expect(find.byType(Shimmer), findsWidgets);
    expect(find.text('٠'), findsNothing);
  });

  testWidgets('doctor profile schedule shows 12-hour am and pm times', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DoctorProfileSchedule(
            today: DateTime(2026, 8, 1),
            schedules: [
              ClinicDoctorScheduleModel(
                day: 'saturday',
                from: '09:00',
                to: '17:30',
                isActive: true,
              ),
              ClinicDoctorScheduleModel(
                day: 'sunday',
                from: '10:00',
                to: '20:00',
                isActive: true,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('9:00 am - 5:30 pm'), findsOneWidget);
    expect(find.text('09:00 - 17:30'), findsNothing);
    expect(find.text('10:00 am - 8:00 pm'), findsNothing);
  });

  testWidgets('doctor profile schedule shows day off for inactive today', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: DoctorProfileSchedule(
            today: DateTime(2026, 8, 1),
            schedules: [
              ClinicDoctorScheduleModel(
                day: 'saturday',
                from: '09:00',
                to: '17:30',
                isActive: false,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('يوم إجازة'), findsOneWidget);
    expect(find.text('9:00 am - 5:30 pm'), findsNothing);
  });

  testWidgets('add doctor schedule validation appears under end time field', (
    tester,
  ) async {
    final cubit = AddDoctorCubit(_FakeClinicDoctorsRepository());
    addTearDown(cubit.close);
    cubit.selectSpecialization('1');
    cubit.setStart(Weekday.saturday, const TimeOfDay(hour: 17, minute: 0));
    cubit.setEnd(Weekday.saturday, const TimeOfDay(hour: 9, minute: 0));
    await cubit.save(
      nameAr: 'طبيب',
      nameEn: '',
      phone: '',
      email: '',
      licenseNumber: '',
      experienceYears: '',
      consultationFee: '',
      bio: '',
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: SingleChildScrollView(
            child: BlocProvider.value(
              value: cubit,
              child: const AddDoctorScheduleSection(),
            ),
          ),
        ),
      ),
    );

    expect(find.text('وقت الانتهاء يجب أن يكون بعد وقت البدء'), findsOneWidget);
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
