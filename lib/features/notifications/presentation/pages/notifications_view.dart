import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/notifications_cubit.dart';
import '../widgets/notification_group.dart';
import '../widgets/notifications_empty.dart';
import '../widgets/notifications_header.dart';
import '../widgets/notifications_tabs.dart';

class NotificationsView extends StatelessWidget {
  const NotificationsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colors.bg,
      body: Column(
        children: [
          const NotificationsHeader(),
          const NotificationsTabs(),
          Expanded(
            child: BlocBuilder<NotificationsCubit, NotificationsState>(
              builder: (context, state) {
                return AnimatedBuilder(
                  animation: state.pagination.items,
                  builder: (context, _) {
                    if (state.pagination.isInitialLoading.value &&
                        state.pagination.items.isEmpty) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final groups = context.read<NotificationsCubit>().grouped();
                    if (groups.isEmpty) return const NotificationsEmpty();
                    return RefreshIndicator(
                      onRefresh: context.read<NotificationsCubit>().refresh,
                      child: ListView(
                        controller: context
                            .read<NotificationsCubit>()
                            .scrollController,
                        padding: const EdgeInsetsDirectional.fromSTEB(
                          AppSpacing.screen,
                          AppSpacing.xs,
                          AppSpacing.screen,
                          AppSpacing.xl,
                        ),
                        children: [
                          for (final group in groups)
                            NotificationGroup(
                              label: group.label,
                              items: group.items,
                            ),
                          if (state.pagination.isLoadingMore.value)
                            const Padding(
                              padding: EdgeInsets.all(AppSpacing.md),
                              child: Center(child: CircularProgressIndicator()),
                            ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
