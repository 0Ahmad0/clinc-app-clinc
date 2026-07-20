import 'package:flutter/material.dart';

import '../../../../core/enums/app_feedback_type.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../domain/appointment.dart';
import '../appointment_kind_style.dart';
import '../cubit/appointments_cubit.dart';
import 'appointment_finish_sheet.dart';
import 'appointment_reject_sheet.dart';

/// Opens the reject sheet; on confirmation rejects the appointment and notifies.
Future<void> openRejectSheet(
  BuildContext context,
  AppointmentsCubit cubit,
  int id,
) async {
  final l10n = context.l10n;
  final reason = await showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => const AppointmentRejectSheet(),
  );
  if (reason == null || !context.mounted) return;
  // Toast before the mutation: rejecting can drop the card from the current
  // filter and unmount this context.
  AppToast.show(
    context,
    title: l10n.apptStatusRejected,
    message: l10n.apptRejectToast,
    type: AppFeedbackType.success,
  );
  cubit.reject(id, reason);
}

/// Opens the finish sheet; on confirmation marks the appointment done.
Future<void> openFinishSheet(
  BuildContext context,
  AppointmentsCubit cubit,
  Appointment appointment,
) async {
  final l10n = context.l10n;
  final requiresResult = appointment.kind.requiresResult;
  final done = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => AppointmentFinishSheet(requiresResult: requiresResult),
  );
  if (done != true || !context.mounted) return;
  // Toast before the mutation: finishing can drop the card from the current
  // filter and unmount this context.
  AppToast.show(
    context,
    title: l10n.apptStatusDone,
    message: requiresResult ? l10n.apptFinishToastLab : l10n.apptFinishToast,
    type: AppFeedbackType.success,
  );
  cubit.finish(appointment.id);
}
