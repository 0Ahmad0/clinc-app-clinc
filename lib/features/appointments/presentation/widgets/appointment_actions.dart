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
  final reason = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AppointmentRejectSheet(),
  );
  if (reason == null || !context.mounted) return;
  AppToast.show(
    context,
    title: l10n.apptStatusRejected,
    message: l10n.apptRejectToast,
    type: AppFeedbackType.success,
  );
  cubit.reject(id, reason);
}

Future<void> openFinishSheet(
  BuildContext context,
  AppointmentsCubit cubit,
  ClinicAppointmentModel appointment,
) async {
  final l10n = context.l10n;
  final result = await showModalBottomSheet<AppointmentFinishResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AppointmentFinishSheet(requiresResult: false),
  );
  if (result == null || !context.mounted) return;
  AppToast.show(
    context,
    title: l10n.apptStatusDone,
    message: l10n.apptFinishToast,
    type: AppFeedbackType.success,
  );
  final id = appointment.appointmentId;
  if (id == null) return;
  cubit.finish(id, notes: result.notes);
}

Future<void> openResultSheet(
  BuildContext context,
  AppointmentsCubit cubit,
  ClinicAppointmentModel appointment,
) async {
  final l10n = context.l10n;
  final result = await showModalBottomSheet<AppointmentFinishResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>
        const AppointmentFinishSheet(requiresResult: true, resultOnly: true),
  );
  if (result == null || !context.mounted) return;
  final id = appointment.appointmentId;
  final filePath = result.filePath;
  if (id == null || filePath == null) return;
  AppToast.show(
    context,
    title: _uploadResultTitle(context),
    message: l10n.apptFinishToastLab,
    type: AppFeedbackType.success,
  );
  cubit.uploadResult(id, filePath);
}

String _uploadResultTitle(BuildContext context) =>
    Localizations.localeOf(context).languageCode == 'ar'
    ? 'رفع النتيجة'
    : 'Upload result';
