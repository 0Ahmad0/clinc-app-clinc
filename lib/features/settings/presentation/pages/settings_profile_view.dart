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
import '../../data/models/clinic_settings_model.dart';
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
  void initState() {
    super.initState();
    context.read<SettingsCubit>().loadInsurances();
  }

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
        final insuranceSection = _ProfileInsuranceSection(
          isLoading: state.isLoadingInsurances,
          insurances: state.insurances,
          selectedIds: state.selectedInsuranceIds,
          onToggle: context.read<SettingsCubit>().toggleInsurance,
        );

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
                        SettingsGroupTitle(title: l10n.settingsInsurances),
                        AppGaps.h12,
                        insuranceSection,
                        AppGaps.h8,
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
                          insuranceIds: state.selectedInsuranceIds,
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

class _ProfileInsuranceSection extends StatelessWidget {
  const _ProfileInsuranceSection({
    required this.isLoading,
    required this.insurances,
    required this.selectedIds,
    required this.onToggle,
  });

  final bool isLoading;
  final List<ClinicInsuranceModel> insurances;
  final Set<int> selectedIds;
  final ValueChanged<int> onToggle;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(
          color: colors.ink.withValues(alpha: 0.08),
          width: 1.5,
        ),
      ),
      child: isLoading
          ? Row(
              children: [
                SizedBox(
                  width: AppSizes.iconSm,
                  height: AppSizes.iconSm,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: colors.primary500,
                  ),
                ),
                AppGaps.w8,
                Text(
                  context.l10n.settingsInsurancesLoading,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.muted,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            )
          : insurances.isEmpty
          ? Text(
              context.l10n.settingsInsurancesEmpty,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.muted,
                fontWeight: FontWeight.w600,
              ),
            )
          : Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final insurance in insurances)
                  _InsuranceChip(
                    label: _insuranceName(context, insurance),
                    selected: selectedIds.contains(insurance.id),
                    enabled: insurance.isActive,
                    onTap: () => onToggle(insurance.id),
                  ),
              ],
            ),
    );
  }

  String _insuranceName(BuildContext context, ClinicInsuranceModel insurance) {
    final isArabic = Localizations.localeOf(context).languageCode == 'ar';
    if (isArabic) {
      return insurance.nameAr ?? insurance.name ?? insurance.nameEn ?? '-';
    }
    return insurance.nameEn ?? insurance.name ?? insurance.nameAr ?? '-';
  }
}

class _InsuranceChip extends StatelessWidget {
  const _InsuranceChip({
    required this.label,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final foreground = selected
        ? colors.onBrand
        : enabled
        ? colors.gray
        : colors.muted;

    return GestureDetector(
      onTap: enabled ? onTap : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsetsDirectional.fromSTEB(
          AppSpacing.sm,
          AppSpacing.xs + 1,
          AppSpacing.md,
          AppSpacing.xs + 1,
        ),
        decoration: BoxDecoration(
          color: selected
              ? null
              : colors.fill.withValues(alpha: enabled ? 1 : 0.55),
          gradient: selected ? colors.ctaGradient : null,
          borderRadius: BorderRadius.circular(AppRadius.pill),
          border: Border.all(
            color: selected ? colors.onBrand.withValues(alpha: 0) : colors.line,
            width: 1.5,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              selected ? Iconsax.tick_circle : Iconsax.shield_tick,
              size: AppSizes.filterChipIcon,
              color: foreground,
            ),
            AppGaps.w8,
            Text(
              label,
              style: context.textTheme.bodySmall?.copyWith(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: foreground,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
