import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../app/core/configuration/locator.dart';
import '../../../app/core/helper/response_helper.dart';
import '../../../app/core/widgets/widgets_Informative/error_view.dart';
import '../../../app/core/widgets/widgets_Informative/loading_data_view.dart';
import '../../../app/data/enums/loading.dart';
import '../../../app/data/notification_model.dart';
import '../../../app/domain/error_handler/network_exceptions.dart';
import '../domain/notifications_repository.dart';
import '../views/widgets/empty_notifications.dart';

enum NotificationsFilter { all, unread, read }

class NotificationsController extends GetxController {
  final Rx<GeneralLoading> notificationsLoading = GeneralLoading.initial.obs;
  final RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  final Rx<NotificationsFilter> selectedFilter = NotificationsFilter.all.obs;
  final RxSet<String> loadingReadIds = <String>{}.obs;
  final RxSet<String> loadingDeleteIds = <String>{}.obs;
  final RxBool isLoadingMore = false.obs;
  final RxBool isMarkingAll = false.obs;
  final RxBool isDeletingAll = false.obs;
  final ScrollController scrollController = ScrollController();
  late final NotificationsRepository _repository;
  int _currentPage = 0;
  int _total = 0;

  bool get hasMore => notifications.length < _total;

  final RxBool isLoading = false.obs;
  // final RxString selectedFilter = 'all'.obs;

  void changeFilter(NotificationsFilter filter) =>
      selectedFilter.value = filter;

  int get unreadCount =>
      notifications.where((n) => n.status == NotificationStatus.unread).length;

  List<NotificationModel> get filteredNotifications {
    switch (selectedFilter.value) {
      case NotificationsFilter.unread:
        return notifications
            .where((n) => n.status == NotificationStatus.unread)
            .toList();
      case NotificationsFilter.read:
        return notifications
            .where((n) => n.status == NotificationStatus.read)
            .toList();
      case NotificationsFilter.all:
        return notifications.toList();
    }
  }

  Map<String, List<NotificationModel>> get filteredGroupedNotifications {
    final Map<String, List<NotificationModel>> groups = {};
    for (final notification in filteredNotifications) {
      final dateKey = notification.formattedDate;
      if (!groups.containsKey(dateKey)) groups[dateKey] = [];
      groups[dateKey]!.add(notification);
    }
    final sortedKeys = groups.keys.toList()
      ..sort((a, b) {
        if (a == 'اليوم') return -1;
        if (b == 'اليوم') return 1;
        if (a == 'البارحة') return -1;
        if (b == 'البارحة') return 1;
        return b.compareTo(a);
      });
    final sortedGroups = <String, List<NotificationModel>>{};
    for (final key in sortedKeys) sortedGroups[key] = groups[key]!;
    return sortedGroups;
  }

  @override
  void onInit() {
    _repository = locator<NotificationsRepository>();
    scrollController.addListener(_onScroll);
    getNotifications(pageKey: 1);
    super.onInit();
  }

  void _onScroll() {
    if (scrollController.position.extentAfter < 240 &&
        hasMore &&
        !isLoadingMore.value) {
      getNotifications(pageKey: _currentPage + 1);
    }
  }

  Future<void> onRefresh() => getNotifications(pageKey: 1);

  Future<void> selectFilter(NotificationsFilter filter) async {
    if (selectedFilter.value == filter) return;
    selectedFilter.value = filter;
    await getNotifications(pageKey: 1);
  }

  Future<void> getNotifications({required int pageKey}) async {
    final isFirstPage = pageKey == 1;
    if (isFirstPage) {
      notificationsLoading.value = GeneralLoading.loading;
    } else {
      isLoadingMore.value = true;
    }

    final response = await _repository.getNotifications(
      page: pageKey,
      isRead: _filterValue,
    );

    response.when(
      success: (model) {
        if (model.status != 'success') {
          _handleListFailure(
            NetworkExceptions.defaultError(model.message ?? ''),
            isFirstPage,
          );
          return;
        }
        final pageItems =
            model.result?.list.whereType<NotificationModel>() ?? [];
        if (isFirstPage) notifications.clear();
        notifications.addAll(pageItems);
        _currentPage = model.meta?.currentPage ?? pageKey;
        _total = model.meta?.total ?? notifications.length;
        notificationsLoading.value = notifications.isEmpty
            ? GeneralLoading.empty
            : GeneralLoading.success;
        isLoadingMore.value = false;
      },
      failure: (exception) => _handleListFailure(exception, isFirstPage),
    );
  }

  bool? get _filterValue {
    switch (selectedFilter.value) {
      case NotificationsFilter.all:
        return null;
      case NotificationsFilter.unread:
        return false;
      case NotificationsFilter.read:
        return true;
    }
  }

  void _handleListFailure(NetworkExceptions exception, bool isFirstPage) {
    isLoadingMore.value = false;
    if (isFirstPage) {
      notificationsLoading.value = GeneralLoading.failure;
    }
    ResponseHelper.onNetworkFailure(networkException: exception);
  }

  Future<void> markAsRead(String id) async {
    final index = notifications.indexWhere((item) => item.id == id);
    if (index == -1 || notifications[index].isRead) return;
    loadingReadIds.add(id);
    final result = await _repository.markAsRead(id);
    loadingReadIds.remove(id);
    result.when(
      success: (model) {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        if (selectedFilter.value == NotificationsFilter.unread) {
          notifications.removeAt(index);
        } else {
          notifications[index] = notifications[index].copyWith(
            status: NotificationStatus.read,
          );
        }
        _updateEmptyState();
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  Future<void> markAllAsRead() async {
    if (isMarkingAll.value || notifications.isEmpty) return;
    isMarkingAll.value = true;
    final result = await _repository.markAllAsRead();
    isMarkingAll.value = false;
    result.when(
      success: (model) {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        if (selectedFilter.value == NotificationsFilter.unread) {
          notifications.clear();
        } else {
          for (var index = 0; index < notifications.length; index++) {
            notifications[index] = notifications[index].copyWith(
              status: NotificationStatus.read,
            );
          }
        }
        _updateEmptyState();
        ResponseHelper.onSuccess(message: model.message);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  Future<void> deleteNotification(String id) async {
    if (loadingDeleteIds.contains(id)) return;
    loadingDeleteIds.add(id);
    final result = await _repository.deleteNotification(id);
    loadingDeleteIds.remove(id);
    result.when(
      success: (model) {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        notifications.removeWhere((item) => item.id == id);
        _total = (_total - 1).clamp(0, _total);
        _updateEmptyState();
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  Future<void> deleteAllNotifications() async {
    if (isDeletingAll.value || notifications.isEmpty) return;
    isDeletingAll.value = true;
    final result = await _repository.deleteAllNotifications();
    isDeletingAll.value = false;
    result.when(
      success: (model) {
        if (model.status != 'success') {
          ResponseHelper.onFailure(message: model.message);
          return;
        }
        notifications.clear();
        _total = 0;
        _updateEmptyState();
        ResponseHelper.onSuccess(message: model.message);
      },
      failure: (exception) =>
          ResponseHelper.onNetworkFailure(networkException: exception),
    );
  }

  void _updateEmptyState() {
    notificationsLoading.value = notifications.isEmpty
        ? GeneralLoading.empty
        : GeneralLoading.success;
  }

  Map<DateTime, List<NotificationModel>> get groupedNotifications {
    final groups = <DateTime, List<NotificationModel>>{};
    for (final notification in notifications) {
      final date = notification.createdAt.toLocal();
      final key = DateTime(date.year, date.month, date.day);
      groups.putIfAbsent(key, () => []).add(notification);
    }
    return Map.fromEntries(
      groups.entries.toList()..sort((a, b) => b.key.compareTo(a.key)),
    );
  }

  Widget buildNotifications(Widget child) {
    return notificationsLoading.value.maybeWhen(
      loading: () => const SliverFillRemaining(child: LoadingDataView()),
      failure: () => const SliverFillRemaining(child: ErrorView()),
      empty: () => const SliverFillRemaining(child: EmptyNotifications()),
      success: () => child,
      orElse: () => const SliverToBoxAdapter(child: SizedBox.shrink()),
    );
  }

  @override
  void onClose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.onClose();
  }
}
