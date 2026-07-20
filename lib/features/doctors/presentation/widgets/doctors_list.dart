import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/doctors_cubit.dart';
import '../cubit/doctors_state.dart';
import '../doctors_catalog.dart';
import 'doctor_card.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final doctors = localizedDoctors(context.l10n);
    final accents = [
      context.colors.dangerFg,
      context.colors.purple,
      context.colors.primary600,
      context.colors.teal,
      context.colors.warningFg,
    ];
    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        final visible = context.read<DoctorsCubit>().visibleDoctors(doctors);
        if (visible.isEmpty) {
          return Padding(
            padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
            child: Center(
              child: Text(
                context.l10n.doctorsNoResults,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: context.colors.muted,
                ),
              ),
            ),
          );
        }
        return ListView.separated(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.sm,
            AppSpacing.screen,
            AppSizes.homeBottomClearance,
          ),
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: visible.length,
          separatorBuilder: (_, __) => AppGaps.h12,
          itemBuilder: (context, index) {
            final doctor = visible[index];
            return DoctorCard(
              doctor: doctor,
              available: state.availability[doctor.id],
              accent: accents[doctor.id],
              onToggle: () =>
                  context.read<DoctorsCubit>().toggleAvailability(doctor.id),
              onTap: () =>
                  context.push(AppRoutes.doctorProfile, extra: doctor),
            );
          },
        );
      },
    );
  }
}
