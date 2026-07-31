import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../domain/app_language.dart';
import '../../domain/app_theme_choice.dart';
import '../../domain/notification_channel.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../settings_choice_labels.dart';
import '../widgets/settings_group.dart';
import '../widgets/settings_language_sheet.dart';
import '../widgets/settings_main_header.dart';
import '../widgets/settings_row.dart';
import '../widgets/settings_theme_sheet.dart';

class SettingsMainView extends StatelessWidget {
  const SettingsMainView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final cubit = context.read<SettingsCubit>();
        return SingleChildScrollView(
          child: Column(
            children: [
              const SettingsMainHeader(),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.screen,
                  AppSpacing.md + 2,
                  AppSpacing.screen,
                  AppSpacing.xl,
                ),
                child: Column(
                  children: [
                    SettingsGroup(
                      title: l10n.settingsGroupAccount,
                      rows: [
                        SettingsRow(
                          icon: Iconsax.user,
                          tint: colors.primary600,
                          name: l10n.settingsProfile,
                          sub: l10n.settingsProfileSub,
                          onTap: () => cubit.show(SettingsSection.profile),
                        ),
                        SettingsRow(
                          icon: Iconsax.lock_1,
                          tint: colors.info,
                          name: l10n.settingsPassword,
                          sub: l10n.settingsPasswordSub,
                          onTap: () => cubit.show(SettingsSection.password),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md + 2),
                    SettingsGroup(
                      title: l10n.settingsGroupNotifications,
                      rows: [
                        SettingsRow(
                          icon: Iconsax.notification,
                          tint: colors.warningFg,
                          name: l10n.settingsNotifApp,
                          toggleValue: state.isOn(NotificationChannel.app),
                          onToggle: () =>
                              cubit.toggleChannel(NotificationChannel.app),
                        ),
                        SettingsRow(
                          icon: Iconsax.sms,
                          tint: colors.successFg,
                          name: l10n.settingsNotifEmail,
                          toggleValue: state.isOn(NotificationChannel.email),
                          onToggle: () =>
                              cubit.toggleChannel(NotificationChannel.email),
                        ),
                        SettingsRow(
                          icon: Iconsax.message,
                          tint: colors.info,
                          name: l10n.settingsNotifSms,
                          toggleValue: state.isOn(NotificationChannel.sms),
                          onToggle: () =>
                              cubit.toggleChannel(NotificationChannel.sms),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md + 2),
                    SettingsGroup(
                      title: l10n.settingsGroupAppearance,
                      rows: [
                        SettingsRow(
                          icon: Iconsax.global,
                          tint: colors.successFg,
                          name: l10n.settingsLanguage,
                          sub: state.language.label(l10n),
                          onTap: () => _pickLanguage(context, cubit, state),
                        ),
                        SettingsRow(
                          icon: Iconsax.brush_2,
                          tint: colors.warningFg,
                          name: l10n.settingsTheme,
                          sub: state.theme.label(l10n),
                          onTap: () => _pickTheme(context, cubit, state),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md + 2),
                    SettingsGroup(
                      title: l10n.settingsGroupSupport,
                      rows: [
                        SettingsRow(
                          icon: Iconsax.message_question,
                          tint: colors.primary600,
                          name: l10n.settingsHelp,
                          sub: l10n.settingsHelpSub,
                          onTap: () => context.push(AppRoutes.contact),
                        ),
                        SettingsRow(
                          icon: Iconsax.shield_tick,
                          tint: colors.purple,
                          name: l10n.settingsPrivacy,
                          onTap: () => context.push(AppRoutes.privacy),
                        ),
                        SettingsRow(
                          icon: Iconsax.info_circle,
                          tint: colors.gray,
                          name: l10n.settingsAbout,
                          sub: l10n.settingsVersion,
                          onTap: () => context.push(AppRoutes.about),
                        ),
                      ],
                    ),
                    AppGaps.h16,
                    AppButton(
                      label: l10n.settingsLogout,
                      icon: Iconsax.logout,
                      variant: AppButtonVariant.danger,
                      onPressed: () => context.go(AppRoutes.auth),
                    ),
                    AppGaps.h16,
                    Text(
                      l10n.settingsVersion,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
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

  Future<void> _pickTheme(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) async {
    final choice = await showModalBottomSheet<AppThemeChoice>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SettingsThemeSheet(current: state.theme),
    );
    if (choice != null) cubit.setTheme(choice);
  }

  Future<void> _pickLanguage(
    BuildContext context,
    SettingsCubit cubit,
    SettingsState state,
  ) async {
    final choice = await showModalBottomSheet<AppLanguage>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => SettingsLanguageSheet(current: state.language),
    );
    if (choice != null) cubit.setLanguage(choice);
  }
}
