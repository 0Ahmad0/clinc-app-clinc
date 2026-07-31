import 'dart:async';

import 'package:clinic_app/core/data/base_model.dart';
import 'package:clinic_app/core/data/models.dart';
import 'package:clinic_app/core/data/pagination/pagination_state.dart';
import 'package:clinic_app/core/data/remote/api_response.dart';
import 'package:clinic_app/config/theme/app_theme.dart';
import 'package:clinic_app/features/appointments/data/models/clinic_appointment_model.dart';
import 'package:clinic_app/features/appointments/domain/appointment_tab.dart';
import 'package:clinic_app/features/appointments/domain/clinic_appointments_repository.dart';
import 'package:clinic_app/features/appointments/presentation/cubit/appointments_cubit.dart';
import 'package:clinic_app/features/appointments/presentation/cubit/appointments_state.dart';
import 'package:clinic_app/features/appointments/presentation/pages/appointments_view.dart';
import 'package:clinic_app/features/appointments/presentation/widgets/appointments_empty.dart';
import 'package:clinic_app/l10n/app_localizations.dart';
import 'package:clinic_app/shared/widgets/app_shimmer_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('appointments initial load updates counters', () async {
    final repository = _FakeClinicAppointmentsRepository();
    final cubit = AppointmentsCubit(repository);

    await cubit.loadInitial();

    expect(cubit.state.totalCount, 4);
    expect(cubit.state.pendingCount, 1);
    expect(cubit.state.confirmedCount, 1);
    expect(cubit.state.doneCount, 1);
    expect(cubit.state.rejectedCount, 1);
    expect(cubit.state.pagination.items.length, 4);
    await cubit.close();
  });

  test(
    'appointments open enters detail state before details finish loading',
    () async {
      final repository = _FakeClinicAppointmentsRepository();
      repository.detailCompleter = Completer();
      final cubit = AppointmentsCubit(repository);

      final openFuture = cubit.open('1');
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.selectedId, '1');
      expect(cubit.state.selected, isNull);

      repository.detailCompleter!.complete(
        ApiResponse.success(
          BaseModel(
            result: const ClinicAppointmentModel(
              appointmentId: '1',
              patientName: 'Patient',
            ),
          ),
        ),
      );
      await openFuture;

      expect(cubit.state.selected?.patientName, 'Patient');
      await cubit.close();
    },
  );

  testWidgets('appointments view shows detail shimmer while selected loads', (
    tester,
  ) async {
    final cubit = AppointmentsCubit(_FakeClinicAppointmentsRepository());
    addTearDown(cubit.close);
    cubit.emit(
      AppointmentsState(
        pagination: PaginationState<ClinicAppointmentModel>(),
        selectedId: '1',
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        theme: AppTheme.light,
        locale: const Locale('ar'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: BlocProvider.value(value: cubit, child: const AppointmentsView()),
      ),
    );

    expect(find.byType(AppShimmerPlaceholder), findsWidgets);
  });

  testWidgets(
    'appointments list shows shimmer instead of empty while fetching',
    (tester) async {
      final cubit = AppointmentsCubit(_FakeClinicAppointmentsRepository());
      addTearDown(cubit.close);
      final pagination = PaginationState<ClinicAppointmentModel>();
      pagination.isRefreshing.value = true;
      cubit.emit(AppointmentsState(pagination: pagination));

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.light,
          locale: const Locale('ar'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: BlocProvider.value(
            value: cubit,
            child: const AppointmentsView(),
          ),
        ),
      );

      expect(find.byType(AppShimmerPlaceholder), findsWidgets);
      expect(find.byType(AppointmentsEmpty), findsNothing);
    },
  );

  test(
    'appointments tabs do not reload when already selected or cached',
    () async {
      final repository = _FakeClinicAppointmentsRepository();
      final cubit = AppointmentsCubit(repository);
      await cubit.loadInitial();
      final callsAfterInitial = repository.listCalls;

      cubit.selectTab(AppointmentTab.all);
      await Future<void>.delayed(Duration.zero);
      expect(repository.listCalls, callsAfterInitial);

      cubit.selectTab(AppointmentTab.pending);
      await Future<void>.delayed(Duration.zero);
      final callsAfterPending = repository.listCalls;
      expect(cubit.state.tab, AppointmentTab.pending);
      expect(cubit.state.pagination.items.length, 1);

      cubit.selectTab(AppointmentTab.all);
      await Future<void>.delayed(Duration.zero);

      expect(repository.listCalls, callsAfterPending);
      expect(cubit.state.tab, AppointmentTab.all);
      expect(cubit.state.pagination.items.length, 4);
      await cubit.close();
    },
  );

  test(
    'appointment accept action exposes and clears button busy state',
    () async {
      final repository = _FakeClinicAppointmentsRepository();
      repository.acceptCompleter = Completer();
      final cubit = AppointmentsCubit(repository);

      final acceptFuture = cubit.accept('1');
      await Future<void>.delayed(Duration.zero);

      expect(cubit.state.busyAppointmentId, '1');
      expect(cubit.state.busyAction, AppointmentsCubit.acceptAction);

      repository.acceptCompleter!.complete(
        ApiResponse.success(
          BaseModel(
            result: const ClinicAppointmentModel(
              appointmentId: '1',
              status: 'accepted',
            ),
          ),
        ),
      );
      await acceptFuture;

      expect(cubit.state.busyAppointmentId, isNull);
      expect(cubit.state.busyAction, isNull);
      await cubit.close();
    },
  );
}

class _FakeClinicAppointmentsRepository
    implements ClinicAppointmentsRepository {
  int listCalls = 0;
  Completer<ApiResponse<BaseModel<ClinicAppointmentModel>>>? detailCompleter;
  Completer<ApiResponse<BaseModel<ClinicAppointmentModel>>>? acceptCompleter;

  final List<ClinicAppointmentModel> _items = const [
    ClinicAppointmentModel(appointmentId: '1', status: 'pending'),
    ClinicAppointmentModel(appointmentId: '2', status: 'accepted'),
    ClinicAppointmentModel(appointmentId: '3', status: 'completed'),
    ClinicAppointmentModel(appointmentId: '4', status: 'rejected'),
  ];

  @override
  Future<ApiResponse<BaseModel<BaseModels<ClinicAppointmentModel>>>>
  getAppointments({
    required int page,
    required int perPage,
    String? status,
    String? type,
    String? date,
    String? search,
  }) async {
    listCalls++;
    final filtered = status == null
        ? _items
        : _items.where((item) => item.status == status).toList();
    return ApiResponse.success(
      BaseModel(
        result: BaseModels<ClinicAppointmentModel>(list: filtered),
        meta: MetaList(
          currentPage: page,
          perPage: perPage,
          total: filtered.length,
          to: filtered.length,
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<BaseModel<ClinicAppointmentModel>>> getAppointment(
    String id,
  ) async {
    final completer = detailCompleter;
    if (completer != null) return completer.future;
    return ApiResponse.success(
      BaseModel(
        result: ClinicAppointmentModel(
          appointmentId: id,
          patientName: 'Patient $id',
        ),
      ),
    );
  }

  @override
  Future<ApiResponse<BaseModel<ClinicAppointmentModel>>> accept(String id) {
    final completer = acceptCompleter;
    if (completer != null) return completer.future;
    return Future.value(
      ApiResponse.success(
        BaseModel(
          result: ClinicAppointmentModel(appointmentId: id, status: 'accepted'),
        ),
      ),
    );
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
