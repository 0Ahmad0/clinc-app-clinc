import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../data/models/clinic_doctor_model.dart';
import '../../domain/doctor_specialty.dart';
import '../../domain/doctor_summary.dart';
import '../cubit/doctors_cubit.dart';
import '../cubit/doctors_state.dart';
import 'doctor_card.dart';

class DoctorsList extends StatelessWidget {
  const DoctorsList({super.key});

  @override
  Widget build(BuildContext context) {
    final accents = [
      context.colors.dangerFg,
      context.colors.purple,
      context.colors.primary600,
      context.colors.teal,
      context.colors.warningFg,
    ];

    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) => SliverToBoxAdapter(
        child: AnimatedBuilder(
          animation: state.pagination.items,
          builder: (context, _) {
            final doctors = state.pagination.items.value;
            if (state.pagination.isInitialLoading.value && doctors.isEmpty) {
              return const Padding(
                padding: EdgeInsetsDirectional.all(AppSpacing.lg),
                child: Center(child: CircularProgressIndicator()),
              );
            }
            if (doctors.isEmpty) {
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
              itemCount: doctors.length + (state.pagination.hasMore ? 1 : 0),
              separatorBuilder: (_, __) => AppGaps.h12,
              itemBuilder: (context, index) {
                if (index >= doctors.length) {
                  return const Center(child: CircularProgressIndicator());
                }
                final doctor = doctors[index];
                return DoctorCard(
                  doctor: doctor,
                  accent: accents[index % accents.length],
                  onToggle: () =>
                      context.read<DoctorsCubit>().toggleAvailability(doctor),
                  onTap: () => context.push(
                    AppRoutes.doctorProfile,
                    extra: _summary(doctor, index),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  DoctorSummary _summary(ClinicDoctorModel doctor, int index) {
    final name = doctor.name ?? doctor.nameAr ?? doctor.nameEn ?? '-';
    return DoctorSummary(
      id: index,
      name: name,
      initials: name.characters.isEmpty ? '-' : name.characters.first,
      specialty: DoctorSpecialty.all,
      specialtyName: doctor.specializationName ?? '-',
      experienceYears: doctor.experienceYears,
      fee: doctor.consultationFee.round(),
      imageUrl: doctor.imageUrl,
      rating: doctor.rating.toDouble(),
      patients: doctor.patientsCount,
      doctorId: doctor.doctorId,
    );
  }
}
