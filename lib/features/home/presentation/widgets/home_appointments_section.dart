import 'package:flutter/material.dart';

import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/utils/app_time_formatter.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/shared_empty_widget.dart';
import '../../data/models/clinic_dashboard_model.dart';
import 'home_stats_section.dart';

enum HomeAppointmentTone { upcoming, done, cancelled }

/// Today's appointments list from the supplied dashboard design.
class HomeAppointmentsSection extends StatelessWidget {
  const HomeAppointmentsSection({super.key, this.appointments});

  final List<ClinicDashboardAppointmentModel>? appointments;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final fallbackAppointments = [
      (
        l10n.homeAppointment1Name,
        l10n.homeAppointment1Service,
        l10n.homeAppointment1Time,
        l10n.homeAppointmentUpcoming,
        HomeAppointmentTone.upcoming,
      ),
      (
        l10n.homeAppointment2Name,
        l10n.homeAppointment2Service,
        l10n.homeAppointment2Time,
        l10n.homeAppointmentDone,
        HomeAppointmentTone.done,
      ),
      (
        l10n.homeAppointment3Name,
        l10n.homeAppointment3Service,
        l10n.homeAppointment3Time,
        l10n.homeAppointmentUpcoming,
        HomeAppointmentTone.upcoming,
      ),
      (
        l10n.homeAppointment4Name,
        l10n.homeAppointment4Service,
        l10n.homeAppointment4Time,
        l10n.homeAppointmentCancelled,
        HomeAppointmentTone.cancelled,
      ),
      (
        l10n.homeAppointment5Name,
        l10n.homeAppointment5Service,
        l10n.homeAppointment5Time,
        l10n.homeAppointmentUpcoming,
        HomeAppointmentTone.upcoming,
      ),
    ];

    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.xl,
        AppSpacing.screen,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: HomeSectionTitle(title: l10n.homeTodayAppointments),
              ),
              TextButton(onPressed: () {}, child: Text(l10n.homeViewAll)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (appointments == null)
            for (
              var index = 0;
              index < fallbackAppointments.length;
              index++
            ) ...[
              if (index > 0) const SizedBox(height: AppSpacing.sm),
              HomeAppointmentCard(
                name: fallbackAppointments[index].$1,
                service: fallbackAppointments[index].$2,
                time: fallbackAppointments[index].$3,
                status: fallbackAppointments[index].$4,
                tone: fallbackAppointments[index].$5,
              ),
            ]
          else if (appointments!.isEmpty)
            SharedEmptyWidget(
              icon: Icons.event_busy_outlined,
              title: l10n.homeTodayAppointments,
              subtitle: context.l10n.noDataYet,
              padding: const EdgeInsetsDirectional.symmetric(
                vertical: AppSpacing.xl,
              ),
            )
          else
            for (var index = 0; index < appointments!.length; index++) ...[
              if (index > 0) const SizedBox(height: AppSpacing.sm),
              HomeAppointmentCard(
                name: appointments![index].patientName ?? '-',
                service: appointments![index].serviceName ?? '-',
                time: formatClockTime12(appointments![index].time),
                status: _statusLabel(context, appointments![index].status),
                tone: _statusTone(appointments![index].status),
              ),
            ],
        ],
      ),
    );
  }

  String _statusLabel(BuildContext context, String? status) {
    final l10n = context.l10n;
    return switch (status) {
      'completed' => l10n.homeAppointmentDone,
      'rejected' => l10n.homeAppointmentCancelled,
      'accepted' || 'pending' || _ => l10n.homeAppointmentUpcoming,
    };
  }

  HomeAppointmentTone _statusTone(String? status) {
    return switch (status) {
      'completed' => HomeAppointmentTone.done,
      'rejected' => HomeAppointmentTone.cancelled,
      _ => HomeAppointmentTone.upcoming,
    };
  }
}

class HomeAppointmentCard extends StatelessWidget {
  const HomeAppointmentCard({
    super.key,
    required this.name,
    required this.service,
    required this.time,
    required this.status,
    required this.tone,
  });

  final String name;
  final String service;
  final String time;
  final String status;
  final HomeAppointmentTone tone;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final accent = switch (tone) {
      HomeAppointmentTone.upcoming => colors.primary600,
      HomeAppointmentTone.done => colors.successFg,
      HomeAppointmentTone.cancelled => colors.dangerFg,
    };

    return Container(
      padding: const EdgeInsetsDirectional.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        border: Border.all(color: colors.line.withValues(alpha: 0.7)),
        boxShadow: AppShadows.homeCard,
      ),
      child: Row(
        children: [
          Container(
            width: AppSizes.homeAppointmentAvatar,
            height: AppSizes.homeAppointmentAvatar,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(AppRadius.field),
            ),
            child: Text(
              name.substring(0, 1),
              style: context.textTheme.titleMedium?.copyWith(color: accent),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: colors.ink,
                  ),
                ),
                Text(
                  service,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: colors.gray,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Directionality(
                textDirection: TextDirection.ltr,
                child: Text(
                  time,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: colors.ink,
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xxs),
              Container(
                padding: const EdgeInsetsDirectional.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: AppSpacing.xxs,
                ),
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  status,
                  style: context.textTheme.labelSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                    color: accent,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
