import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/media/media_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/input/email_input.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/media_source_sheet.dart';
import '../cubit/settings_cubit.dart';
import '../widgets/settings_group_title.dart';
import '../widgets/settings_profile_cover.dart';
import '../widgets/settings_profile_field.dart';
import '../widgets/settings_profile_header.dart';

class SettingsProfileView extends StatefulWidget {
  const SettingsProfileView({super.key});

  @override
  State<SettingsProfileView> createState() => _SettingsProfileViewState();
}

class _SettingsProfileViewState extends State<SettingsProfileView> {
  final _name = TextEditingController();
  final _location = TextEditingController();
  final _license = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _website = TextEditingController();
  final _description = TextEditingController();
  int? _clinicId;

  @override
  void dispose() {
    _name.dispose();
    _location.dispose();
    _license.dispose();
    _email.dispose();
    _phone.dispose();
    _website.dispose();
    _description.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocBuilder<SettingsCubit, SettingsState>(
      builder: (context, state) {
        final clinic = state.clinic;
        if (clinic?.clinicId != null && clinic?.clinicId != _clinicId) {
          _clinicId = clinic!.clinicId;
          _name.text = clinic.name ?? '';
          _location.text = clinic.location ?? '';
          _license.text = clinic.licenseNumber ?? '';
          _email.text = normalizeEmailInput(clinic.email ?? '');
          _phone.text = clinic.phone ?? '';
          _website.text = clinic.website ?? '';
          _description.text = clinic.description ?? '';
        }
        final sections = <(String, List<Widget>)>[
          (
            l10n.settingsClinicInfo,
            [
              SettingsProfileField(
                label: l10n.settingsFieldClinicName,
                icon: Iconsax.hospital,
                controller: _name,
              ),
              SettingsProfileField(
                label: l10n.settingsFieldAddress,
                icon: Iconsax.location,
                controller: _location,
              ),
              SettingsProfileField(
                label: l10n.settingsFieldLicense,
                icon: Iconsax.medal_star,
                controller: _license,
                readOnly: true,
              ),
            ],
          ),
          (
            l10n.settingsContactInfo,
            [
              SettingsProfileField(
                label: l10n.settingsFieldEmail,
                icon: Iconsax.sms,
                controller: _email,
                keyboardType: TextInputType.emailAddress,
                inputFormatters: const [EmailInputFormatter()],
              ),
              SettingsProfileField(
                label: l10n.settingsFieldPhone,
                icon: Iconsax.call,
                controller: _phone,
              ),
              SettingsProfileField(
                label: l10n.settingsFieldWebsite,
                icon: Iconsax.global,
                controller: _website,
              ),
            ],
          ),
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
                  SettingsProfileCover(
                    coverPath: state.coverPath ?? clinic?.cover,
                    avatarPath: state.avatarPath ?? clinic?.logo,
                    onPickCover: () => _pickImage(context, cover: true),
                    onPickAvatar: () => _pickImage(context, cover: false),
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
                    colors: [
                      context.colors.bg,
                      context.colors.bg.withValues(alpha: 0),
                    ],
                  ),
                ),
                child: AppButton(
                  label: l10n.settingsProfileSave,
                  icon: Iconsax.document_download,
                  isLoading: state.isSavingProfile,
                  onPressed: state.isSavingProfile
                      ? null
                      : () => context.read<SettingsCubit>().updateProfile(
                          name: _name.text.trim(),
                          email: normalizeEmailInput(_email.text),
                          phone: _phone.text.trim(),
                          location: _location.text.trim(),
                          description: _description.text.trim(),
                          website: _website.text.trim(),
                        ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickImage(BuildContext context, {required bool cover}) async {
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
