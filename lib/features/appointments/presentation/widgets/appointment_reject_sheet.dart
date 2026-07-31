import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_bottom_sheet.dart';
import 'appointment_confirm_button.dart';
import 'appointment_reason_option.dart';

/// Bottom sheet for rejecting an appointment: pick a reason (or write one) and
/// confirm. Pops the chosen reason string, or nothing when dismissed.
class AppointmentRejectSheet extends StatefulWidget {
  const AppointmentRejectSheet({super.key, this.onConfirm});

  final Future<void> Function(String reason)? onConfirm;

  @override
  State<AppointmentRejectSheet> createState() => _AppointmentRejectSheetState();
}

class _AppointmentRejectSheetState extends State<AppointmentRejectSheet> {
  int? _selected;
  bool _isSubmitting = false;
  final TextEditingController _note = TextEditingController();

  static const int _otherIndex = 3;
  bool get _otherPicked => _selected == _otherIndex;
  bool get _canConfirm =>
      _selected != null && (!_otherPicked || _note.text.trim().isNotEmpty);

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _confirm(List<String> reasons) async {
    if (!_canConfirm || _isSubmitting) return;
    final reason = _otherPicked ? _note.text.trim() : reasons[_selected!];
    final onConfirm = widget.onConfirm;
    if (onConfirm == null) {
      Navigator.of(context).pop(reason);
      return;
    }
    setState(() => _isSubmitting = true);
    await onConfirm(reason);
    if (!mounted) return;
    Navigator.of(context).pop(true);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final reasons = [
      l10n.apptReasonFull,
      l10n.apptReasonScope,
      l10n.apptReasonIncomplete,
      l10n.apptReasonOther,
    ];
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
                  color: colors.danger.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.field),
                ),
                child: Icon(
                  Iconsax.close_circle,
                  color: colors.dangerFg,
                  size: AppSizes.iconMd,
                ),
              ),
              AppGaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.apptRejectTitle,
                      style: context.textTheme.titleMedium?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      l10n.apptRejectSub,
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
          for (var i = 0; i < reasons.length; i++)
            Padding(
              padding: const EdgeInsetsDirectional.only(bottom: AppSpacing.xs),
              child: AppointmentReasonOption(
                label: reasons[i],
                selected: _selected == i,
                onTap: () => setState(() => _selected = i),
              ),
            ),
          if (_otherPicked) ...[
            AppGaps.h8,
            TextField(
              controller: _note,
              maxLines: 3,
              minLines: 3,
              onChanged: (_) => setState(() {}),
              style: context.textTheme.bodyMedium?.copyWith(color: colors.ink),
              decoration: InputDecoration(
                filled: true,
                fillColor: colors.bg,
                hintText: l10n.apptRejectNoteHint,
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
          ],
          AppGaps.h16,
          AppointmentConfirmButton(
            label: l10n.apptRejectConfirm,
            enabled: _canConfirm && !_isSubmitting,
            isLoading: _isSubmitting,
            background: colors.dangerFg,
            onTap: () => _confirm(reasons),
          ),
        ],
      ),
    );
  }
}
