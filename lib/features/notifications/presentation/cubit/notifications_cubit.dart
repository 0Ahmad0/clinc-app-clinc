import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../core/data/pagination/pagination_state.dart';
import '../../../../core/data/remote/api_response.dart';
import '../../../../core/domain/error_handler/network_exceptions.dart';
import '../../data/models/clinic_notification_model.dart';
import '../../domain/clinic_notifications_repository.dart';
import '../../domain/notification_tab.dart';

part 'notifications_cubit.freezed.dart';
part 'notifications_state.dart';

class NotificationsCubit extends Cubit<NotificationsState> {
  NotificationsCubit(this._repository)
    : super(
        NotificationsState(
          pagination: PaginationState<ClinicNotificationModel>(),
        ),
      ) {
    scrollController.addListener(_onScroll);
  }

  final ClinicNotificationsRepository _repository;
  final ScrollController scrollController = ScrollController();

  Future<void> loadInitial() async {
    await Future.wait([_loadPage(page: 1, reset: true), _loadCounters()]);
  }

  Future<void> refresh() => loadInitial();

  Future<void> loadMore() async {
    final pagination = state.pagination;
    if (pagination.isBusy || !pagination.hasMore) return;
    await _loadPage(page: pagination.currentPage + 1);
  }

  Future<void> selectTab(NotificationTab tab) async {
    emit(state.copyWith(tab: tab));
    await _loadPage(page: 1, reset: true);
  }

  Future<void> open(int? id) async {
    if (id == null) return;
    final currentItems = state.pagination.items.value;
    final index = currentItems.indexWhere((item) => item.id == id);
    if (index == -1) return;
    final current = currentItems[index];
    if (current.isRead) return;

    final result = await _repository.markRead(id);
    result.when(
      success: (response) {
        final updated = response.result ?? current.copyWith(isRead: true);
        _applyReadLocally(id: id, updated: updated, wasUnread: current.unread);
      },
      failure: (exception) => emit(state.copyWith(failure: exception)),
    );
  }

  Future<void> markAllRead() async {
    emit(state.copyWith(isActionLoading: true, failure: null));
    final result = await _repository.markAllRead();
    result.when(
      success: (response) {
        final unread = response.result?.unreadCount ?? 0;
        final total = state.totalCount;
        emit(
          state.copyWith(
            unreadCount: unread,
            readCount: total - unread < 0 ? 0 : total - unread,
            isActionLoading: false,
            failure: null,
          ),
        );
        _loadPage(page: 1, reset: true);
      },
      failure: (exception) =>
          emit(state.copyWith(isActionLoading: false, failure: exception)),
    );
  }

  Future<void> clearAll() async {
    emit(state.copyWith(isActionLoading: true, failure: null));
    final result = await _repository.clear();
    result.when(
      success: (response) {
        state.pagination.reset();
        final unread = response.result?.unreadCount ?? 0;
        emit(
          state.copyWith(
            unreadCount: unread,
            totalCount: 0,
            readCount: 0,
            isActionLoading: false,
            failure: null,
          ),
        );
      },
      failure: (exception) =>
          emit(state.copyWith(isActionLoading: false, failure: exception)),
    );
  }

  Future<void> deleteOne(int? id) async {
    if (id == null) return;
    final result = await _repository.delete(id);
    result.when(
      success: (_) => loadInitial(),
      failure: (exception) => emit(state.copyWith(failure: exception)),
    );
  }

  Future<void> loadUnreadCount() async {
    await _loadCounters();
  }

  List<({String label, List<ClinicNotificationModel> items})> grouped() {
    final items = state.pagination.items.value;
    final labels = <String>[];
    for (final notification in items) {
      final group = notification.group;
      if (!labels.contains(group)) labels.add(group);
    }
    return [
      for (final label in labels)
        (
          label: label,
          items: items
              .where((notification) => notification.group == label)
              .toList(growable: false),
        ),
    ];
  }

  Future<void> _loadPage({required int page, bool reset = false}) async {
    final pagination = state.pagination;
    if (pagination.isBusy && !reset) return;
    if (page == 1) pagination.isInitialLoading.value = true;
    if (page > 1) pagination.isLoadingMore.value = true;
    if (reset) pagination.reset();
    emit(state.copyWith(failure: null));

    final result = await _repository.notifications(
      page: page,
      perPage: pagination.perPage,
      isRead: _readFilter(state.tab),
    );

    result.when(
      success: (response) {
        pagination.setPage(
          data: response.result?.list ?? const [],
          page: page,
          meta: response.meta,
        );
        _clearLoading();
        emit(state.copyWith(failure: null));
      },
      failure: (exception) {
        _clearLoading();
        emit(state.copyWith(failure: exception));
      },
    );
  }

  Future<void> _loadCounters() async {
    final results = await Future.wait([
      _countFor(null),
      _countFor(false),
      _countFor(true),
    ]);
    emit(
      state.copyWith(
        totalCount: results[0],
        unreadCount: results[1],
        readCount: results[2],
        failure: null,
      ),
    );
  }

  Future<int> _countFor(bool? isRead) async {
    final result = await _repository.notifications(
      page: 1,
      perPage: 1,
      isRead: isRead,
    );
    return result.when(
      success: (response) =>
          response.meta?.total ?? response.result?.list.length ?? 0,
      failure: (_) => 0,
    );
  }

  void _applyReadLocally({
    required int id,
    required ClinicNotificationModel updated,
    required bool wasUnread,
  }) {
    final pagination = state.pagination;
    final items = [...pagination.items.value];
    final index = items.indexWhere((item) => item.id == id);
    if (index == -1) return;

    final unreadCount = wasUnread
        ? (state.unreadCount - 1 < 0 ? 0 : state.unreadCount - 1)
        : state.unreadCount;
    final readCount = wasUnread ? state.readCount + 1 : state.readCount;

    if (state.tab == NotificationTab.unread) {
      items.removeAt(index);
      pagination.items.assignAll(items);
      final currentTotal = pagination.total ?? (items.length + 1);
      pagination.total = currentTotal - 1 < 0 ? 0 : currentTotal - 1;
    } else {
      items[index] = updated.copyWith(isRead: true);
      pagination.items.assignAll(items);
    }

    emit(
      state.copyWith(
        unreadCount: unreadCount,
        readCount: readCount,
        failure: null,
      ),
    );
  }

  bool? _readFilter(NotificationTab tab) => switch (tab) {
    NotificationTab.all => null,
    NotificationTab.unread => false,
    NotificationTab.read => true,
  };

  void _clearLoading() {
    state.pagination.isInitialLoading.value = false;
    state.pagination.isLoadingMore.value = false;
    state.pagination.isRefreshing.value = false;
  }

  void _onScroll() {
    if (!scrollController.hasClients) return;
    final position = scrollController.position;
    if (position.pixels >= position.maxScrollExtent - 240) {
      loadMore();
    }
  }

  @override
  Future<void> close() {
    scrollController.dispose();
    return super.close();
  }
}
