import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:intl/intl.dart' show NumberFormat;

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/notifications_cubit.dart';
import '../cubit/notifications_state.dart';
import '../notifications_catalog.dart';
import 'notifications_header_action.dart';

/// Blue gradient header: back button, bell with unread dot, title, unread
/// summary and the mark-all / clear-all actions.
class NotificationsHeader extends StatelessWidget {
  const NotificationsHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final all = localizedNotifications(l10n);
    final format = NumberFormat.decimalPattern(
      Localizations.localeOf(context).toLanguageTag(),
    );
    return BlocBuilder<NotificationsCubit, NotificationsState>(
      builder: (context, state) {
        final cubit = context.read<NotificationsCubit>();
        final activeIds = cubit.active(all).map((n) => n.id);
        final unread = cubit.unreadCount(all);
        return Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: colors.headerGradient,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppRadius.sheet),
            ),
          ),
          child: Stack(
            children: [
              PositionedDirectional(
                top: -AppSizes.doctorsHeaderCircleTop,
                start: -AppSizes.doctorsHeaderCircleEnd,
                child: Container(
                  width: AppSizes.doctorsHeaderCircle,
                  height: AppSizes.doctorsHeaderCircle,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: colors.onBrand.withValues(alpha: 0.12),
                      width: 1.5,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.screen,
                  MediaQuery.paddingOf(context).top + AppSpacing.md,
                  AppSpacing.screen,
                  AppSpacing.lg,
                ),
                child: Row(
                  children: [
                    NotificationsHeaderAction(
                      icon: Directionality.of(context) == TextDirection.rtl
                          ? Iconsax.arrow_right_3
                          : Iconsax.arrow_left_2,
                      onTap: () => context.pop(),
                    ),
                    AppGaps.w12,
                    Container(
                      width: AppSizes.doctorsHeaderIcon,
                      height: AppSizes.doctorsHeaderIcon,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: colors.onBrand.withValues(alpha: 0.14),
                        borderRadius: BorderRadius.circular(AppRadius.field),
                      ),
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Icon(
                            Iconsax.notification,
                            color: colors.onBrand,
                            size: AppSizes.iconLg,
                          ),
                          if (unread > 0)
                            PositionedDirectional(
                              top: AppSpacing.xs + 2,
                              end: AppSpacing.sm,
                              child: Container(
                                width: AppSpacing.xs,
                                height: AppSpacing.xs,
                                decoration: BoxDecoration(
                                  color: colors.warning,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: colors.primary600,
                                    width: 1.5,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                    AppGaps.w12,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            l10n.notifTitle,
                            style: context.textTheme.titleLarge?.copyWith(
                              color: colors.onBrand,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            unread > 0
                                ? l10n.notifUnreadLine(format.format(unread))
                                : l10n.notifAllRead,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.onBrand.withValues(alpha: 0.72),
                            ),
                          ),
                        ],
                      ),
                    ),
                    NotificationsHeaderAction(
                      icon: Iconsax.tick_square,
                      tooltip: l10n.notifMarkAllRead,
                      onTap: () => cubit.markAllRead(activeIds),
                    ),
                    AppGaps.w8,
                    NotificationsHeaderAction(
                      icon: Iconsax.trash,
                      tooltip: l10n.notifClearAll,
                      onTap: () => cubit.clearAll(activeIds),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
