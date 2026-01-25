import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../../generated/locale_keys.g.dart';
import '../../controllers/appointment_details_controller.dart';

class RejectAppointmentBottomSheet extends StatefulWidget {
  const RejectAppointmentBottomSheet({super.key});

  @override
  State<RejectAppointmentBottomSheet> createState() => _RejectAppointmentBottomSheetState();
}

class _RejectAppointmentBottomSheetState extends State<RejectAppointmentBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  String? _reasonKey;
  final TextEditingController _note = TextEditingController();

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final controller = Get.find<AppointmentDetailsController>();

    final reasons = <Map<String, String>>[
      {'key': 'doctor_unavailable', 'label': tr(LocaleKeys.appointments_reject_reasons_doctor_unavailable)},
      {'key': 'clinic_closed', 'label': tr(LocaleKeys.appointments_reject_reasons_clinic_closed)},
      {'key': 'invalid_booking', 'label': tr(LocaleKeys.appointments_reject_reasons_invalid_booking)},
      {'key': 'need_more_info', 'label': tr(LocaleKeys.appointments_reject_reasons_need_more_info)},
      {'key': 'other', 'label': "other"},
    ];

    return SafeArea(
      child: Container(
        padding: EdgeInsets.fromLTRB(16.w, 12.h, 16.w, 16.h),
        decoration: BoxDecoration(
          color: cs.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 44.w,
                  height: 4.h,
                  decoration: BoxDecoration(
                    color: cs.outlineVariant,
                    borderRadius: BorderRadius.circular(999),
                  ),
                ),
              ),
              14.verticalSpace,
              Text(tr(LocaleKeys.appointments_reject_title),
                  style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800)),
              16.verticalSpace,

              DropdownButtonFormField<String>(
                value: _reasonKey,
                items: reasons
                    .map((e) => DropdownMenuItem<String>(
                  value: e['key'],
                  child: Text(e['label']!, style: theme.textTheme.bodyMedium),
                ))
                    .toList(),
                onChanged: (v) => setState(() => _reasonKey = v),
                validator: (_) => (_reasonKey == null)
                    ? tr(LocaleKeys.appointments_reject_validation_reason_required)
                    : null,
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.appointments_reject_reason_label),
                  filled: true,
                  fillColor: cs.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),

              12.verticalSpace,

              TextFormField(
                controller: _note,
                minLines: 3,
                maxLines: 5,
                validator: (v) {
                  final txt = (v ?? '').trim();
                  if (txt.isEmpty) return tr(LocaleKeys.appointments_reject_validation_note_required);
                  return null;
                },
                decoration: InputDecoration(
                  labelText: tr(LocaleKeys.appointments_reject_note_label),
                  hintText: tr(LocaleKeys.appointments_reject_note_hint),
                  filled: true,
                  fillColor: cs.surface,
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
              ),

              16.verticalSpace,

              ElevatedButton(
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  await controller.reject(reasonKey: _reasonKey!, note: _note.text.trim());
                  Get.back();
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.error,
                  foregroundColor: cs.onError,
                  padding: EdgeInsets.symmetric(vertical: 14.h),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
                ),
                child: Text(tr(LocaleKeys.appointments_actions_save),
                    style: theme.textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w800)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}