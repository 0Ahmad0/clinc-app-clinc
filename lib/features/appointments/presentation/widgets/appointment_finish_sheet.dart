import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../core/media/media_service.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import 'appointment_confirm_button.dart';
import 'appointment_upload_box.dart';

class AppointmentFinishResult {
  const AppointmentFinishResult({this.filePath, this.notes});

  final String? filePath;
  final String? notes;
}

/// Bottom sheet for finishing an appointment. Lab appointments must attach a
/// result PDF first (picked via `file_picker`).
class AppointmentFinishSheet extends StatefulWidget {
  const AppointmentFinishSheet({
    super.key,
    required this.requiresResult,
    this.resultOnly = false,
    this.onConfirm,
  });

  final bool requiresResult;
  final bool resultOnly;
  final Future<void> Function(AppointmentFinishResult result)? onConfirm;

  @override
  State<AppointmentFinishSheet> createState() => _AppointmentFinishSheetState();
}

class _AppointmentFinishSheetState extends State<AppointmentFinishSheet> {
  String? _fileName;
  String? _filePath;
  bool _isSubmitting = false;
  final TextEditingController _note = TextEditingController();

  bool get _canConfirm => !widget.requiresResult || _fileName != null;

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    if (_isSubmitting) return;
    final picked = await sl<MediaService>().pickPdf();
    if (picked == null) return;
    setState(() {
      _fileName = picked.name;
      _filePath = picked.path;
    });
  }

  Future<void> _confirm() async {
    if (!_canConfirm || _isSubmitting) return;
    final result = AppointmentFinishResult(
      filePath: _filePath,
      notes: _note.text.trim().isEmpty ? null : _note.text.trim(),
    );
    final onConfirm = widget.onConfirm;
    if (onConfirm == null) {
      Navigator.of(context).pop(result);
      return;
    }
    setState(() => _isSubmitting = true);
    await onConfirm(result);
    if (!mounted) return;
    Navigator.of(context).pop(true);
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
                      widget.resultOnly
                          ? _uploadResultTitle(context)
                          : widget.requiresResult
                          ? l10n.apptFinishLab
                          : l10n.apptFinish,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      widget.resultOnly
                          ? _uploadResultSubtitle(context)
                          : widget.requiresResult
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
            AppointmentUploadBox(fileName: _fileName, onTap: _pickFile),
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
            label: widget.resultOnly
                ? _uploadResultConfirm(context)
                : widget.requiresResult
                ? l10n.apptFinishConfirmLab
                : l10n.apptFinishConfirm,
            enabled: _canConfirm && !_isSubmitting,
            isLoading: _isSubmitting,
            background: colors.success,
            onTap: _confirm,
          ),
        ],
      ),
    );
  }

  String _uploadResultTitle(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'رفع النتيجة'
      : 'Upload result';

  String _uploadResultSubtitle(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'أرفق ملف نتيجة التحليل PDF'
      : 'Attach the lab result PDF';

  String _uploadResultConfirm(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'رفع النتيجة'
      : 'Upload result';
}
