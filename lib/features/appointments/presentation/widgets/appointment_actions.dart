import 'package:flutter/material.dart';

import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../data/models/clinic_appointment_model.dart';
import '../appointment_kind_style.dart';
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
  final requiresResult = appointment.kindValue.requiresResult;
  final result = await showModalBottomSheet<AppointmentFinishResult>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AppointmentFinishSheet(requiresResult: requiresResult),
  );
  if (result == null || !context.mounted) return;
  AppToast.show(
    context,
    title: l10n.apptStatusDone,
    message: requiresResult ? l10n.apptFinishToastLab : l10n.apptFinishToast,
    type: AppFeedbackType.success,
  );
  final id = appointment.appointmentId;
  if (id == null) return;
  if (requiresResult) {
    final filePath = result.filePath;
    if (filePath != null) cubit.uploadResult(id, filePath);
    return;
  }
  cubit.finish(id, notes: result.notes);
}
