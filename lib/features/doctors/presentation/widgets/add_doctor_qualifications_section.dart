import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_section_card.dart';
import '../cubit/add_doctor_cubit.dart';

class AddDoctorQualificationsSection extends StatelessWidget {
  const AddDoctorQualificationsSection({super.key, required this.onPickPdf});

  final VoidCallback onPickPdf;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return AppSectionCard(
      icon: Iconsax.document_upload,
      tint: colors.info,
      title: l10n.addDoctorQualSection,
      child: BlocBuilder<AddDoctorCubit, AddDoctorState>(
        builder: (context, state) => Column(
          children: [
            Material(
              color: colors.surface.withValues(alpha: 0),
              child: InkWell(
                onTap: onPickPdf,
                borderRadius: BorderRadius.circular(AppRadius.button),
                child: Container(
                  width: double.infinity,
                  constraints: const BoxConstraints(
                    minHeight: AppSizes.addDoctorUploadHeight,
                  ),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: colors.primary500.withValues(alpha: 0.04),
                    borderRadius: BorderRadius.circular(AppRadius.button),
                    border: Border.all(
                      color: colors.primary500.withValues(alpha: 0.35),
                      width: 2,
                    ),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.document_upload,
                        size: AppSizes.iconLg + AppSpacing.xs,
                        color: colors.primary600,
                      ),
                      AppGaps.h8,
                      Text(
                        l10n.addDoctorUploadTitle,
                        style: context.textTheme.bodyMedium?.copyWith(
                          color: colors.primary600,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Text(
                        l10n.addDoctorUploadHint,
                        style: context.textTheme.labelSmall?.copyWith(
                          color: colors.muted,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (state.qualificationFiles.isNotEmpty) ...[
              AppGaps.h12,
              for (final file in state.qualificationFiles)
                Padding(
                  padding: const EdgeInsetsDirectional.only(
                    bottom: AppSpacing.xs,
                  ),
                  child: _PickedPdfTile(file: file),
                ),
            ],
          ],
        ),
      ),
    );
  }
}

class _PickedPdfTile extends StatelessWidget {
  const _PickedPdfTile({required this.file});

  final DoctorPickedQualification file;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: colors.bg,
        borderRadius: BorderRadius.circular(AppRadius.field),
        border: Border.all(color: colors.line),
      ),
      child: Row(
        children: [
          Icon(
            Iconsax.document_text,
            color: colors.info,
            size: AppSizes.iconSm,
          ),
          AppGaps.w8,
          Expanded(
            child: Text(
              file.name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: context.textTheme.bodySmall?.copyWith(
                color: colors.ink,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          IconButton(
            onPressed: _isRemote(file.path)
                ? () => _openFile(file.path)
                : () => context.read<AddDoctorCubit>().removeQualificationFile(
                    file.path,
                  ),
            icon: Icon(
              _isRemote(file.path) ? Iconsax.eye : Iconsax.trash,
              color: _isRemote(file.path) ? colors.primary600 : colors.dangerFg,
              size: AppSizes.iconSm,
            ),
          ),
        ],
      ),
    );
  }

  bool _isRemote(String path) {
    final uri = Uri.tryParse(path.trim());
    return uri?.hasScheme == true && uri?.hasAuthority == true;
  }

  Future<void> _openFile(String path) async {
    final uri = Uri.tryParse(path.trim());
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}
