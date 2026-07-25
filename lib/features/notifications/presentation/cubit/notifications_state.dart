part of 'notifications_cubit.dart';

@freezed
abstract class NotificationsState with _$NotificationsState {
  const factory NotificationsState({
    @Default(NotificationTab.all) NotificationTab tab,
    @Default(0) int unreadCount,
    @Default(0) int totalCount,
    @Default(0) int readCount,
    @Default(false) bool isActionLoading,
    NetworkExceptions? failure,
    required PaginationState<ClinicNotificationModel> pagination,
  }) = _NotificationsState;
}
