import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/media/media_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import 'appointment_confirm_button.dart';
import 'appointment_upload_box.dart';

/// Bottom sheet for finishing an appointment. Lab appointments must attach a
/// result PDF first (picked via `file_picker`). Pops `true` on confirm, nothing
/// when dismissed.
class AppointmentFinishSheet extends StatefulWidget {
  const AppointmentFinishSheet({super.key, required this.requiresResult});

  final bool requiresResult;

  @override
  State<AppointmentFinishSheet> createState() => _AppointmentFinishSheetState();
}

class _AppointmentFinishSheetState extends State<AppointmentFinishSheet> {
  String? _fileName;
  final TextEditingController _note = TextEditingController();

  bool get _canConfirm => !widget.requiresResult || _fileName != null;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    final picked = await sl<MediaService>().pickPdf();
    if (picked == null) return;
    setState(() => _fileName = picked.name);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    return AppBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Container(
                width: AppSizes.hitTarget - 2,
                height: AppSizes.hitTarget - 2,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.success.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.field),
                ),
                child: Icon(
                  Iconsax.tick_square,
                  color: colors.successFg,
                  size: AppSizes.iconMd,
                ),
              ),
              AppGaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.requiresResult
                          ? l10n.apptFinishLab
                          : l10n.apptFinish,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.requiresResult
                          ? l10n.apptFinishSubLab
                          : l10n.apptFinishSub,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          AppGaps.h16,
          if (widget.requiresResult) ...[
            AppointmentUploadBox(
              fileName: _fileName,
              onTap: _pickFile,
            ),
            AppGaps.h12,
          ],
          TextField(
            controller: _note,
            maxLines: 3,
            minLines: 3,
            style: context.textTheme.bodyMedium?.copyWith(color: colors.ink),
            decoration: InputDecoration(
              filled: true,
              fillColor: colors.bg,
              hintText: l10n.apptFinishNoteHint,
              hintStyle: context.textTheme.bodyMedium?.copyWith(
                color: colors.muted,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.field),
                borderSide: BorderSide(color: colors.line, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(AppRadius.field),
                borderSide: BorderSide(color: colors.line, width: 1.5),
              ),
            ),
          ),
          AppGaps.h16,
          AppointmentConfirmButton(
            label: widget.requiresResult
                ? l10n.apptFinishConfirmLab
                : l10n.apptFinishConfirm,
            enabled: _canConfirm,
            background: colors.success,
            onTap: () => Navigator.of(context).pop(true),
          ),
        ],
      ),
    );
  }
}
