import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../core/enums/app_button_variant.dart';
import '../../../../core/enums/app_feedback_type.dart';
import '../../../../core/utils/app_time_formatter.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';
import '../../../../shared/widgets/app_section_card.dart';
import '../../../../shared/widgets/app_shimmer_placeholder.dart';
import '../../../../shared/widgets/app_toast.dart';
import '../../data/models/clinic_appointment_model.dart';
import '../appointment_kind_style.dart';
import '../cubit/appointments_cubit.dart';
import '../widgets/appointment_actions.dart';
import '../widgets/appointment_detail_header.dart';
import '../widgets/appointment_info_row.dart';

class AppointmentDetailView extends StatelessWidget {
  const AppointmentDetailView({super.key, required this.appointment});

  final ClinicAppointmentModel appointment;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final cubit = context.read<AppointmentsCubit>();
    final state = context.watch<AppointmentsCubit>().state;
    final id = appointment.appointmentId;
    final isBusy = state.busyAppointmentId == id;
    final isAccepting =
        isBusy && state.busyAction == AppointmentsCubit.acceptAction;
    final isRejecting =
        isBusy && state.busyAction == AppointmentsCubit.rejectAction;
    final isFinishing =
        isBusy && state.busyAction == AppointmentsCubit.finishAction;
    final isUploading =
        isBusy && state.busyAction == AppointmentsCubit.uploadResultAction;
    final requiresResult = appointment.kindValue.requiresResult;
    final notes = appointment.notes?.trim();
    final resultUri = appointment.resultFileUri;
    final hasCompletionDetails =
        (notes != null && notes.isNotEmpty) || resultUri != null;
    final hasActions =
        appointment.status == 'pending' || appointment.status == 'accepted';
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        AppointmentDetailHeader(appointment: appointment),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.md + 2,
            AppSpacing.screen,
            AppSpacing.xl,
          ),
          child: Column(
            children: [
              AppSectionCard(
                icon: Iconsax.user,
                tint: colors.primary600,
                title: l10n.apptPatientSection,
                child: Column(
                  children: [
                    AppointmentInfoRow(
                      icon: Iconsax.user,
                      label: l10n.apptRowName,
                      value: appointment.patientName ?? '-',
                    ),
                    AppGaps.h12,
                    AppointmentInfoRow(
                      icon: Iconsax.call,
                      label: l10n.apptRowPhone,
                      value: appointment.patientPhone ?? '-',
                    ),
                  ],
                ),
              ),
              AppGaps.h16,
              AppSectionCard(
                icon: Iconsax.calendar,
                tint: colors.purple,
                title: l10n.apptDetailsSection,
                child: Column(
                  children: [
                    AppointmentInfoRow(
                      icon: Iconsax.briefcase,
                      label: l10n.apptRowService,
                      value: appointment.serviceName ?? '-',
                    ),
                    AppGaps.h12,
                    AppointmentInfoRow(
                      icon: Iconsax.calendar,
                      label: l10n.apptRowDate,
                      value: appointment.date ?? '-',
                    ),
                    AppGaps.h12,
                    AppointmentInfoRow(
                      icon: Iconsax.clock,
                      label: l10n.apptRowTime,
                      value: formatClockTime12(appointment.time),
                    ),
                    if (appointment.rejectionReason != null) ...[
                      AppGaps.h12,
                      AppointmentInfoRow(
                        icon: Iconsax.info_circle,
                        label: l10n.apptRejectReasonPrefix,
                        value: appointment.rejectionReason!,
                      ),
                    ],
                  ],
                ),
              ),
              if (hasCompletionDetails) ...[
                AppGaps.h16,
                AppSectionCard(
                  icon: Iconsax.document_text,
                  tint: colors.primary600,
                  title: _completionDetailsTitle(context),
                  child: Column(
                    children: [
                      if (notes != null && notes.isNotEmpty)
                        AppointmentInfoRow(
                          icon: Iconsax.note_text,
                          label: _notesLabel(context),
                          value: notes,
                        ),
                      if (notes != null &&
                          notes.isNotEmpty &&
                          resultUri != null)
                        AppGaps.h12,
                      if (resultUri != null)
                        AppButton(
                          label: _openResultLabel(context),
                          icon: Iconsax.document_download,
                          variant: AppButtonVariant.secondary,
                          onPressed: () => _openResult(context, resultUri),
                        ),
                    ],
                  ),
                ),
              ],
              if (hasActions) ...[
                AppGaps.h16,
                AppSectionCard(
                  icon: Iconsax.flash_1,
                  tint: colors.successFg,
                  title: l10n.apptActionsSection,
                  child: appointment.status == 'pending'
                      ? Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: l10n.apptAccept,
                                icon: Iconsax.tick_circle,
                                variant: AppButtonVariant.success,
                                isLoading: isAccepting,
                                onPressed: id == null || isBusy
                                    ? null
                                    : () => cubit.accept(id),
                              ),
                            ),
                            AppGaps.w12,
                            Expanded(
                              child: AppButton(
                                label: l10n.apptReject,
                                icon: Iconsax.close_circle,
                                variant: AppButtonVariant.danger,
                                isLoading: isRejecting,
                                onPressed: id == null || isBusy
                                    ? null
                                    : () => openRejectSheet(context, cubit, id),
                              ),
                            ),
                          ],
                        )
                      : requiresResult
                      ? Row(
                          children: [
                            Expanded(
                              child: AppButton(
                                label: l10n.apptFinish,
                                icon: Iconsax.tick_square,
                                isLoading: isFinishing,
                                onPressed: id == null || isBusy
                                    ? null
                                    : () => openFinishSheet(
                                        context,
                                        cubit,
                                        appointment,
                                      ),
                              ),
                            ),
                            AppGaps.w12,
                            Expanded(
                              child: AppButton(
                                label: _uploadResultLabel(context),
                                icon: Iconsax.document_upload,
                                variant: AppButtonVariant.secondary,
                                isLoading: isUploading,
                                onPressed: id == null || isBusy
                                    ? null
                                    : () => openResultSheet(
                                        context,
                                        cubit,
                                        appointment,
                                      ),
                              ),
                            ),
                          ],
                        )
                      : AppButton(
                          label: l10n.apptFinish,
                          icon: Iconsax.tick_square,
                          isLoading: isFinishing,
                          onPressed: id == null || isBusy
                              ? null
                              : () => openFinishSheet(
                                  context,
                                  cubit,
                                  appointment,
                                ),
                        ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }

  String _uploadResultLabel(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'رفع النتيجة'
      : 'Upload result';

  String _completionDetailsTitle(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'النتيجة والملاحظات'
      : 'Result and notes';

  String _notesLabel(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'الملاحظات'
      : 'Notes';

  String _openResultLabel(BuildContext context) =>
      Localizations.localeOf(context).languageCode == 'ar'
      ? 'فتح ملف النتيجة'
      : 'Open result file';

  Future<void> _openResult(BuildContext context, Uri uri) async {
    final opened = await launchUrl(uri, mode: LaunchMode.externalApplication);
    if (opened) return;
    if (!context.mounted) return;
    AppToast.show(
      context,
      title: context.l10n.toastFailure,
      message: uri.toString(),
      type: AppFeedbackType.danger,
    );
  }
}

class AppointmentDetailLoadingView extends StatelessWidget {
  const AppointmentDetailLoadingView({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListView(
      padding: EdgeInsets.zero,
      children: [
        Container(
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            gradient: colors.headerGradient,
            borderRadius: const BorderRadius.vertical(
              bottom: Radius.circular(AppRadius.homeHeader),
            ),
          ),
          child: Padding(
            padding: EdgeInsetsDirectional.fromSTEB(
              AppSpacing.screen,
              MediaQuery.paddingOf(context).top + AppSpacing.xs,
              AppSpacing.screen,
              AppSpacing.lg,
            ),
            child: Column(
              children: [
                Align(
                  alignment: AlignmentDirectional.centerStart,
                  child: SizedBox.square(
                    dimension: AppSizes.hitTarget,
                    child: Material(
                      color: colors.onBrand.withValues(alpha: 0.14),
                      borderRadius: BorderRadius.circular(AppRadius.field),
                      child: InkWell(
                        onTap: () =>
                            context.read<AppointmentsCubit>().closeDetail(),
                        borderRadius: BorderRadius.circular(AppRadius.field),
                        child: Icon(
                          Directionality.of(context) == TextDirection.rtl
                              ? Iconsax.arrow_right_3
                              : Iconsax.arrow_left_2,
                          color: colors.onBrand,
                          size: AppSizes.iconMd,
                        ),
                      ),
                    ),
                  ),
                ),
                const AppShimmerPlaceholder(
                  width: AppSizes.appointmentDetailAvatar,
                  height: AppSizes.appointmentDetailAvatar,
                  shape: BoxShape.circle,
                ),
                AppGaps.h12,
                const AppShimmerPlaceholder(
                  width: 148,
                  height: 22,
                  borderRadius: AppRadius.pill,
                ),
                AppGaps.h12,
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppShimmerPlaceholder(
                      width: 92,
                      height: 28,
                      borderRadius: AppRadius.pill,
                    ),
                    SizedBox(width: AppSpacing.sm),
                    AppShimmerPlaceholder(
                      width: 78,
                      height: 28,
                      borderRadius: AppRadius.pill,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.md + 2,
            AppSpacing.screen,
            AppSpacing.xl,
          ),
          child: Column(
            children: const [
              _AppointmentDetailSectionShimmer(),
              AppGaps.h16,
              _AppointmentDetailSectionShimmer(),
            ],
          ),
        ),
      ],
    );
  }
}

class _AppointmentDetailSectionShimmer extends StatelessWidget {
  const _AppointmentDetailSectionShimmer();

  @override
  Widget build(BuildContext context) => AppSectionCard(
    icon: Iconsax.user,
    tint: context.colors.primary600,
    title: '',
    child: Column(
      children: const [
        AppShimmerPlaceholder(height: 42, borderRadius: AppRadius.sm),
        AppGaps.h12,
        AppShimmerPlaceholder(height: 42, borderRadius: AppRadius.sm),
      ],
    ),
  );
}
