import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';
import 'settings_main_view.dart';
import 'settings_password_view.dart';
import 'settings_profile_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<SettingsCubit>()..loadInitial(),
    child: const _SettingsScaffold(),
  );
}

class _SettingsScaffold extends StatelessWidget {
  const _SettingsScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => previous.section != current.section,
      listenWhen: (previous, current) =>
          previous.failure != current.failure ||
          previous.passwordChanged != current.passwordChanged,
      listener: (context, state) {
        if (state.failure != null) {
          AppToast.show(
            context,
            title: context.l10n.settingsProfileSave,
            message: state.failure.toString(),
            type: AppFeedbackType.danger,
          );
        }
        if (state.passwordChanged) {
          AppToast.show(
            context,
            title: context.l10n.settingsPasswordTitle,
            message: context.l10n.settingsPasswordChanged,
            type: AppFeedbackType.success,
          );
        }
      },
      builder: (context, state) {
        final onMain = state.section == SettingsSection.main;
        // Sub-views back out to the main list first; only the main list pops
        // the route.
        return PopScope(
          canPop: onMain,
          onPopInvokedWithResult: (didPop, _) {
            if (!didPop) {
              context.read<SettingsCubit>().show(SettingsSection.main);
            }
          },
          child: Scaffold(
            backgroundColor: context.colors.bg,
            body: switch (state.section) {
              SettingsSection.main => const SettingsMainView(),
              SettingsSection.profile => const SettingsProfileView(),
              SettingsSection.password => const SettingsPasswordView(),
            },
          ),
        );
      },
    );
  }
}
