import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/doctor_summary.dart';
import '../widgets/doctor_profile_availability.dart';
import '../widgets/doctor_profile_cta.dart';
import '../widgets/doctor_profile_header.dart';
import '../widgets/doctor_profile_schedule.dart';
import '../widgets/doctor_profile_section_title.dart';
import '../widgets/doctor_profile_services.dart';
import '../widgets/doctor_profile_stats.dart';

/// Read-only doctor profile reached by tapping a doctor card. The availability
/// toggle is local view state (no persistence yet).
class DoctorProfilePage extends StatefulWidget {
  const DoctorProfilePage({super.key, required this.doctor});

  final DoctorSummary doctor;

  @override
  State<DoctorProfilePage> createState() => _DoctorProfilePageState();
}

class _DoctorProfilePageState extends State<DoctorProfilePage> {
  bool _available = true;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final l10n = context.l10n;
    final doctor = widget.doctor;

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
                  available: _available,
                  onBack: () => context.pop(),
                ),
                // Pull the content up so the stat row overlaps the hero.
                Transform.translate(
                  offset: const Offset(0, -AppSpacing.xl),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DoctorProfileStats(doctor: doctor),
                      DoctorProfileAvailability(
                        available: _available,
                        onToggle: () =>
                            setState(() => _available = !_available),
                      ),
                      DoctorProfileSectionTitle(title: l10n.doctorProfileAbout),
                      Container(
                        margin: const EdgeInsetsDirectional.symmetric(
                          horizontal: AppSpacing.screen,
                        ),
                        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
                        decoration: BoxDecoration(
                          color: colors.surface,
                          borderRadius: BorderRadius.circular(AppRadius.field),
                          border: Border.all(color: colors.line),
                          boxShadow: AppShadows.homeCard,
                        ),
                        child: Text(
                          l10n.doctorProfileAboutBody,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: colors.slate,
                            height: 1.9,
                          ),
                        ),
                      ),
                      const DoctorProfileSchedule(),
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
            ),
          ),
        ],
      ),
    );
  }
}
