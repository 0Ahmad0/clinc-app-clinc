import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../core/di/service_locator.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_shimmer_placeholder.dart';
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
        if (state.isDetailsLoading) {
          return Scaffold(
            backgroundColor: colors.bg,
            body: DoctorProfileLoadingView(onBack: () => context.pop()),
          );
        }
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
                            loading:
                                model?.doctorId != null &&
                                state.busyDoctorIds.contains(model!.doctorId),
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
                          if (model?.qualificationFiles.isNotEmpty == true)
                            _DoctorProfileQualifications(
                              files: model!.qualificationFiles,
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

class _DoctorProfileQualifications extends StatelessWidget {
  const _DoctorProfileQualifications({required this.files});

  final List<String> files;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final visibleFiles = files
        .map((file) => file.trim())
        .where((file) => file.isNotEmpty)
        .toList(growable: false);
    if (visibleFiles.isEmpty) return const SizedBox.shrink();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DoctorProfileSectionTitle(title: context.l10n.addDoctorQualSection),
        Container(
          margin: const EdgeInsetsDirectional.symmetric(
            horizontal: AppSpacing.screen,
          ),
          padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(color: colors.line),
            boxShadow: AppShadows.homeCard,
          ),
          child: Column(
            children: [
              for (var index = 0; index < visibleFiles.length; index++) ...[
                _DoctorProfileQualificationTile(file: visibleFiles[index]),
                if (index != visibleFiles.length - 1)
                  Divider(height: AppSpacing.md, color: colors.line),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

class _DoctorProfileQualificationTile extends StatelessWidget {
  const _DoctorProfileQualificationTile({required this.file});

  final String file;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return InkWell(
      onTap: () => _openFile(file),
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: Padding(
        padding: const EdgeInsetsDirectional.symmetric(
          horizontal: AppSpacing.xs,
          vertical: AppSpacing.xs,
        ),
        child: Row(
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: colors.info.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppRadius.sm),
              ),
              child: Icon(
                Iconsax.document_text,
                color: colors.info,
                size: AppSizes.iconSm,
              ),
            ),
            AppGaps.w8,
            Expanded(
              child: Text(
                _fileName(file),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: context.textTheme.bodySmall?.copyWith(
                  color: colors.ink,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Icon(Iconsax.eye, color: colors.primary600, size: AppSizes.iconSm),
          ],
        ),
      ),
    );
  }

  String _fileName(String path) {
    final uri = Uri.tryParse(path);
    final segment = uri?.pathSegments.isNotEmpty == true
        ? uri!.pathSegments.last
        : path.split('/').last;
    final decoded = Uri.decodeComponent(segment).trim();
    return decoded.isEmpty ? 'qualification.pdf' : decoded;
  }

  Future<void> _openFile(String path) async {
    final uri = Uri.tryParse(path.trim());
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }
}

class DoctorProfileLoadingView extends StatelessWidget {
  const DoctorProfileLoadingView({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final rtl = Directionality.of(context) == TextDirection.rtl;

    return SingleChildScrollView(
      padding: const EdgeInsetsDirectional.only(
        bottom: AppSizes.homeBottomClearance,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            width: double.infinity,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(
              gradient: colors.headerGradient,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(AppRadius.homeHeader),
              ),
            ),
            child: Stack(
              children: [
                PositionedDirectional(
                  top: -AppSizes.homeHeaderCircleTop,
                  end: -AppSizes.homeHeaderCircleStart,
                  child: Container(
                    width: AppSizes.homeHeaderCircleSmall,
                    height: AppSizes.homeHeaderCircleSmall,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: colors.onBrand.withValues(alpha: 0.12),
                        width: 1.5,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(
                    AppSpacing.screen,
                    MediaQuery.paddingOf(context).top + AppSpacing.md,
                    AppSpacing.screen,
                    AppSpacing.xxl + AppSpacing.md,
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          _LoadingCircleButton(
                            icon: rtl ? Icons.arrow_forward : Icons.arrow_back,
                            onTap: onBack,
                          ),
                          AppShimmerPlaceholder(
                            width: 128,
                            height: 20,
                            borderRadius: AppRadius.pill,
                          ),
                          _LoadingCircleButton(
                            icon: Icons.edit_outlined,
                            onTap: null,
                          ),
                        ],
                      ),
                      AppGaps.h16,
                      AppShimmerPlaceholder(
                        width: AppSizes.addDoctorAvatar,
                        height: AppSizes.addDoctorAvatar,
                        shape: BoxShape.circle,
                      ),
                      AppGaps.h12,
                      AppShimmerPlaceholder(
                        width: 168,
                        height: 24,
                        borderRadius: AppRadius.pill,
                      ),
                      AppGaps.h8,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AppShimmerPlaceholder(
                            width: 118,
                            height: 28,
                            borderRadius: AppRadius.pill,
                          ),
                          AppGaps.w8,
                          AppShimmerPlaceholder(
                            width: 72,
                            height: 28,
                            borderRadius: AppRadius.pill,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Transform.translate(
            offset: const Offset(0, -AppSpacing.xl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                _LoadingStatsRow(),
                AppGaps.h16,
                _LoadingWideCard(height: 58),
                AppGaps.h16,
                _LoadingSectionTitle(width: 96),
                AppGaps.h8,
                _LoadingWideCard(height: 132),
                AppGaps.h16,
                _LoadingSectionTitle(width: 118),
                AppGaps.h8,
                _LoadingScheduleList(),
                AppGaps.h16,
                _LoadingSectionTitle(width: 110),
                AppGaps.h8,
                _LoadingServicesRow(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingCircleButton extends StatelessWidget {
  const _LoadingCircleButton({required this.icon, this.onTap});

  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.onBrand.withValues(alpha: 0.14),
      borderRadius: BorderRadius.circular(AppRadius.field),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: SizedBox.square(
          dimension: AppSizes.hitTarget - 2,
          child: Icon(icon, color: colors.onBrand, size: AppSizes.iconMd),
        ),
      ),
    );
  }
}

class _LoadingStatsRow extends StatelessWidget {
  const _LoadingStatsRow();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.screen,
    ),
    child: Row(
      children: [
        for (var index = 0; index < 3; index++)
          Expanded(
            child: Padding(
              padding: EdgeInsetsDirectional.only(
                end: index == 2 ? 0 : AppSpacing.xs,
              ),
              child: const _LoadingCard(
                height: 78,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppShimmerPlaceholder(
                      width: 42,
                      height: 22,
                      borderRadius: AppRadius.pill,
                    ),
                    SizedBox(height: AppSpacing.xs),
                    AppShimmerPlaceholder(
                      width: 64,
                      height: 12,
                      borderRadius: AppRadius.pill,
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    ),
  );
}

class _LoadingWideCard extends StatelessWidget {
  const _LoadingWideCard({required this.height});

  final double height;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.screen,
    ),
    child: _LoadingCard(
      height: height,
      child: Padding(
        padding: const EdgeInsetsDirectional.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const AppShimmerPlaceholder(
              width: double.infinity,
              height: 14,
              borderRadius: AppRadius.pill,
            ),
            if (height > 80) ...[
              AppGaps.h12,
              const AppShimmerPlaceholder(
                width: double.infinity,
                height: 14,
                borderRadius: AppRadius.pill,
              ),
              AppGaps.h12,
              const AppShimmerPlaceholder(
                width: 190,
                height: 14,
                borderRadius: AppRadius.pill,
              ),
            ],
          ],
        ),
      ),
    ),
  );
}

class _LoadingSectionTitle extends StatelessWidget {
  const _LoadingSectionTitle({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.screen,
    ),
    child: Row(
      children: [
        AppShimmerPlaceholder(
          width: AppSizes.homeSectionMarkerWidth,
          height: AppSizes.homeSectionMarkerHeight,
          borderRadius: AppRadius.sm,
        ),
        AppGaps.w8,
        AppShimmerPlaceholder(
          width: width,
          height: 18,
          borderRadius: AppRadius.pill,
        ),
      ],
    ),
  );
}

class _LoadingScheduleList extends StatelessWidget {
  const _LoadingScheduleList();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.screen,
    ),
    child: Column(
      children: const [
        _LoadingCard(height: 58, child: _LoadingScheduleLine()),
        AppGaps.h8,
        _LoadingCard(height: 58, child: _LoadingScheduleLine()),
        AppGaps.h8,
        _LoadingCard(height: 58, child: _LoadingScheduleLine()),
      ],
    ),
  );
}

class _LoadingScheduleLine extends StatelessWidget {
  const _LoadingScheduleLine();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
    child: Row(
      children: const [
        AppShimmerPlaceholder(
          width: 82,
          height: 18,
          borderRadius: AppRadius.pill,
        ),
        Spacer(),
        AppShimmerPlaceholder(
          width: 118,
          height: 18,
          borderRadius: AppRadius.pill,
        ),
      ],
    ),
  );
}

class _LoadingServicesRow extends StatelessWidget {
  const _LoadingServicesRow();

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(
      horizontal: AppSpacing.screen,
    ),
    child: Row(
      children: const [
        Expanded(child: _LoadingCard(height: 86, child: SizedBox.shrink())),
        AppGaps.w12,
        Expanded(child: _LoadingCard(height: 86, child: SizedBox.shrink())),
      ],
    ),
  );
}

class _LoadingCard extends StatelessWidget {
  const _LoadingCard({required this.height, required this.child});

  final double height;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(AppRadius.homeQuickAction),
        border: Border.all(color: colors.line),
        boxShadow: AppShadows.homeCard,
      ),
      child: child,
    );
  }
}
