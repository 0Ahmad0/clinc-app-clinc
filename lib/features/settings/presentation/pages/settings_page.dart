import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/service_locator.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import 'settings_main_view.dart';
import 'settings_password_view.dart';
import 'settings_profile_view.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<SettingsCubit>(),
    child: const _SettingsScaffold(),
  );
}

class _SettingsScaffold extends StatelessWidget {
  const _SettingsScaffold();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsCubit, SettingsState>(
      buildWhen: (previous, current) => previous.section != current.section,
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
