import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/media/media_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/media_source_sheet.dart';
import '../../domain/settings_section.dart';
import '../cubit/settings_cubit.dart';
import '../cubit/settings_state.dart';
import '../widgets/settings_group_title.dart';
import '../widgets/settings_profile_cover.dart';
import '../widgets/settings_profile_field.dart';
import '../widgets/settings_profile_header.dart';

/// The clinic profile editor: flat header, cover + avatar, editable info
/// sections and a floating save bar.
class SettingsProfileView extends StatelessWidget {
  const SettingsProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final sections = <(String, List<Widget>)>[
      (l10n.settingsClinicInfo, [
        SettingsProfileField(
          label: l10n.settingsFieldClinicName,
          icon: Iconsax.hospital,
          value: l10n.settingsClinicName,
        ),
        SettingsProfileField(
          label: l10n.settingsFieldAddress,
          icon: Iconsax.location,
          value: l10n.settingsValueAddress,
        ),
        SettingsProfileField(
          label: l10n.settingsFieldLicense,
          icon: Iconsax.medal_star,
          value: l10n.settingsValueLicense,
        ),
      ]),
      (l10n.settingsContactInfo, [
        SettingsProfileField(
          label: l10n.settingsFieldEmail,
          icon: Iconsax.sms,
          value: l10n.settingsClinicEmail,
        ),
        SettingsProfileField(
          label: l10n.settingsFieldPhone,
          icon: Iconsax.call,
          value: l10n.settingsValuePhone,
        ),
        SettingsProfileField(
          label: l10n.settingsFieldWebsite,
          icon: Iconsax.global,
          value: l10n.settingsValueWebsite,
        ),
      ]),
    ];

    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsetsDirectional.only(
            bottom: AppSizes.homeBottomClearance,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SettingsProfileHeader(),
              BlocBuilder<SettingsCubit, SettingsState>(
                buildWhen: (previous, current) =>
                    previous.coverPath != current.coverPath ||
                    previous.avatarPath != current.avatarPath,
                builder: (context, state) => SettingsProfileCover(
                  coverPath: state.coverPath,
                  avatarPath: state.avatarPath,
                  onPickCover: () => _pickImage(context, cover: true),
                  onPickAvatar: () => _pickImage(context, cover: false),
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.screen,
                  AppSpacing.md + 2,
                  AppSpacing.screen,
                  0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    for (final section in sections) ...[
                      SettingsGroupTitle(title: section.$1),
                      AppGaps.h12,
                      for (final field in section.$2)
                        Padding(
                          padding: const EdgeInsetsDirectional.only(
                            bottom: AppSpacing.sm,
                          ),
                          child: field,
                        ),
                      AppGaps.h8,
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
        PositionedDirectional(
          bottom: 0,
          start: 0,
          end: 0,
          child: Container(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              AppSpacing.sm,
              AppSpacing.screen,
              MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [context.colors.bg, context.colors.bg.withValues(alpha: 0)],
              ),
            ),
            child: AppButton(
              label: l10n.settingsProfileSave,
              icon: Iconsax.document_download,
              onPressed: () =>
                  context.read<SettingsCubit>().show(SettingsSection.main),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _pickImage(
    BuildContext context, {
    required bool cover,
  }) async {
    final cubit = context.read<SettingsCubit>();
    final source = await showModalBottomSheet<ImageSource>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => const MediaSourceSheet(),
    );
    if (source == null) return;
    final path = await sl<MediaService>().pickImage(source);
    if (path == null) return;
    cover ? cubit.setCover(path) : cubit.setAvatar(path);
  }
}
