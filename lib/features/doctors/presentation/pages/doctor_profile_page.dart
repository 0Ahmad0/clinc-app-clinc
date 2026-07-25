import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../data/models/clinic_doctor_model.dart';
import '../../domain/doctor_specialty.dart';
import '../../domain/doctor_summary.dart';
import '../cubit/doctors_cubit.dart';
import '../cubit/doctors_state.dart';
import '../widgets/doctor_profile_availability.dart';
import '../widgets/doctor_profile_cta.dart';
import '../widgets/doctor_profile_header.dart';
import '../widgets/doctor_profile_schedule.dart';
import '../widgets/doctor_profile_section_title.dart';
import '../widgets/doctor_profile_services.dart';
import '../widgets/doctor_profile_stats.dart';

class DoctorProfilePage extends StatelessWidget {
  const DoctorProfilePage({
    super.key,
    required this.doctor,
    this.initialDoctor,
  });

  final DoctorSummary doctor;
  final ClinicDoctorModel? initialDoctor;

  @override
  Widget build(BuildContext context) => BlocProvider(
    create: (_) => sl<DoctorsCubit>()..loadDoctor(doctor.doctorId),
    child: _DoctorProfileView(summary: doctor, initialDoctor: initialDoctor),
  );
}

class _DoctorProfileView extends StatelessWidget {
  const _DoctorProfileView({
    required this.summary,
    required this.initialDoctor,
  });

  final DoctorSummary summary;
  final ClinicDoctorModel? initialDoctor;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;

    return BlocBuilder<DoctorsCubit, DoctorsState>(
      builder: (context, state) {
        final model = state.selectedDoctor ?? initialDoctor;
        final doctor = model == null ? summary : _summary(model, summary);
        final available = model?.isActive ?? true;

        return Scaffold(
          backgroundColor: colors.bg,
          body: Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsetsDirectional.only(
                  bottom: AppSizes.homeBottomClearance,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    DoctorProfileHeader(
                      doctor: doctor,
                      available: available,
                      onBack: () => context.pop(),
                      onEdit: model == null
                          ? () {}
                          : () async {
                              await context.push(
                                AppRoutes.addDoctor,
                                extra: model,
                              );
                              if (!context.mounted) return;
                              context.read<DoctorsCubit>().loadDoctor(
                                model.doctorId,
                              );
                            },
                    ),
                    Transform.translate(
                      offset: const Offset(0, -AppSpacing.xl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          DoctorProfileStats(doctor: doctor),
                          DoctorProfileAvailability(
                            available: available,
                            onToggle: model == null
                                ? () {}
                                : () => context
                                      .read<DoctorsCubit>()
                                      .toggleAvailability(model),
                          ),
                          DoctorProfileSectionTitle(
                            title: l10n.doctorProfileAbout,
                          ),
                          Container(
                            margin: const EdgeInsetsDirectional.symmetric(
                              horizontal: AppSpacing.screen,
                            ),
                            padding: const EdgeInsetsDirectional.all(
                              AppSpacing.md,
                            ),
                            decoration: BoxDecoration(
                              color: colors.surface,
                              borderRadius: BorderRadius.circular(
                                AppRadius.field,
                              ),
                              border: Border.all(color: colors.line),
                              boxShadow: AppShadows.homeCard,
                            ),
                            child: Text(
                              model?.bio?.trim().isNotEmpty == true
                                  ? model!.bio!
                                  : l10n.doctorProfileAboutBody,
                              style: context.textTheme.bodySmall?.copyWith(
                                color: colors.slate,
                                height: 1.9,
                              ),
                            ),
                          ),
                          DoctorProfileSchedule(
                            schedules: model?.schedules ?? const [],
                          ),
                          const DoctorProfileServices(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: AlignmentDirectional.bottomCenter,
                child: DoctorProfileCta(
                  onBook: () => context.push(AppRoutes.appointments),
                  onCall: _hasPhone(model?.phone)
                      ? () => _openDoctorPhone(model!.phone!)
                      : null,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  DoctorSummary _summary(ClinicDoctorModel model, DoctorSummary fallback) {
    final name = model.name ?? model.nameAr ?? model.nameEn ?? fallback.name;
    return DoctorSummary(
      id: fallback.id,
      name: name,
      initials: name.characters.isEmpty ? '-' : name.characters.first,
      specialty: DoctorSpecialty.all,
      specialtyName: model.specializationName ?? fallback.specialtyName,
      experienceYears: model.experienceYears,
      fee: model.consultationFee.round(),
      imageUrl: model.imageUrl,
      rating: model.rating.toDouble(),
      patients: model.patientsCount,
      doctorId: model.doctorId ?? fallback.doctorId,
    );
  }

  bool _hasPhone(String? phone) => phone?.trim().isNotEmpty == true;

  Future<void> _openDoctorPhone(String phone) async {
    final phoneNumber = phone.trim();
    final whatsappPhone = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    final whatsappUri = Uri.parse('whatsapp://send?phone=$whatsappPhone');
    final phoneUri = Uri(scheme: 'tel', path: phoneNumber);

    try {
      final openedWhatsApp = await launchUrl(
        whatsappUri,
        mode: LaunchMode.externalApplication,
      );
      if (openedWhatsApp) return;
    } catch (_) {
      // Fallback to the dialer below.
    }

    await launchUrl(phoneUri, mode: LaunchMode.externalApplication);
  }
}
