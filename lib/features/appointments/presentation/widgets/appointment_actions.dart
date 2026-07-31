import 'package:flutter/material.dart';

import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../data/models/clinic_appointment_model.dart';
import '../cubit/appointments_cubit.dart';
import 'appointment_finish_sheet.dart';
import 'appointment_reject_sheet.dart';

Future<void> openRejectSheet(
  BuildContext context,
  AppointmentsCubit cubit,
  String id,
) async {
  final l10n = context.l10n;
  final submitted = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>
        AppointmentRejectSheet(onConfirm: (reason) => cubit.reject(id, reason)),
  );
  if (submitted != true || !context.mounted) return;
  AppToast.show(
    context,
    title: l10n.apptStatusRejected,
    message: l10n.apptRejectToast,
    type: AppFeedbackType.success,
  );
}

Future<void> openFinishSheet(
  BuildContext context,
  AppointmentsCubit cubit,
  ClinicAppointmentModel appointment,
) async {
  final l10n = context.l10n;
  final id = appointment.appointmentId;
  if (id == null) return;
  final submitted = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AppointmentFinishSheet(
      requiresResult: false,
      onConfirm: (result) => cubit.finish(id, notes: result.notes),
    ),
  );
  if (submitted != true || !context.mounted) return;
  AppToast.show(
    context,
    title: l10n.apptStatusDone,
    message: l10n.apptFinishToast,
    type: AppFeedbackType.success,
  );
}

Future<void> openResultSheet(
  BuildContext context,
  AppointmentsCubit cubit,
  ClinicAppointmentModel appointment,
) async {
  final l10n = context.l10n;
  final id = appointment.appointmentId;
  if (id == null) return;
  final submitted = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AppointmentFinishSheet(
      requiresResult: true,
      resultOnly: true,
      onConfirm: (result) {
        final filePath = result.filePath;
        if (filePath == null) return Future<void>.value();
        return cubit.uploadResult(id, filePath);
      },
    ),
  );
  if (submitted != true || !context.mounted) return;
  AppToast.show(
    context,
    title: _uploadResultTitle(context),
    message: l10n.apptFinishToastLab,
    type: AppFeedbackType.success,
  );
}

String _uploadResultTitle(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'ar'
    ? 'رفع النتيجة'
    : 'Upload result';
