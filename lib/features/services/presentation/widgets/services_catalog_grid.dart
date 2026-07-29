import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_section_shimmers.dart';
import '../../../../shared/widgets/shared_empty_widget.dart';
import '../../../../shared/widgets/specialization_visual.dart';
import '../../domain/service_kind.dart';
import '../cubit/services_cubit.dart';
import '../services_l10n.dart';
import 'service_card.dart';
import 'services_add_card.dart';
import 'services_add_sheet.dart';

/// Two-column grid of the facility's added sections/specialties, ending with a
/// dashed add card that opens the picker sheet.
class ServicesCatalogGrid extends StatelessWidget {
  const ServicesCatalogGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final colors = context.colors;
    final cubit = context.read<ServicesCubit>();

    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        final isLab = state.kind == ServiceKind.lab;
        final isListLoading = isLab
            ? state.enabledLabTests.isInitialLoading.value
            : state.enabledSpecializations.isInitialLoading.value;
        if (state.isCurrentFiltersLoading) {
          return const Column(
            children: [
              FiltersShimmer(),
              CardsGridShimmer(bottomPadding: AppSpacing.xl),
            ],
          );
        }
        if (isListLoading) return const CardsGridShimmer();

        final isEmpty = isLab
            ? state.visibleLabSections.isEmpty
            : state.enabledSpecializations.items.isEmpty;
        final cards = <Widget>[
          if (isLab)
            for (final section in state.visibleLabSections)
              ServiceCard(
                icon: section.iconData,
                accent: section.accent(colors),
                iconView: (section.icon ?? '').trim().isEmpty
                    ? null
                    : SpecializationIconView(
                        value: section.icon,
                        color: section.accent(colors),
                        size: AppSizes.iconLg,
                      ),
                name: section.label(context),
                sub: l10n.servicesTestsAvailable(
                  '${state.labSectionEnabledCount(section.sectionId)}',
                ),
                onTap: () => cubit.openDetail(section),
              )
          else
            for (final specialty in state.enabledSpecializations.items.value)
              ServiceCard(
                icon: specialty.iconData,
                accent: specialty.accent(colors),
                iconView: SpecializationIconView(
                  value: specialty.icon,
                  color: specialty.accent(colors),
                  size: AppSizes.iconLg,
                ),
                name: specialty.label(context),
                sub: l10n.servicesSpecialtyLabel,
              ),
          ServicesAddCard(
            label: isLab ? l10n.servicesAddSection : l10n.servicesAddSpecialty,
            onTap: () => _openSheet(context, cubit),
          ),
        ];

        return Column(
          children: [
            if (isEmpty)
              SharedEmptyWidget(
                icon: isLab
                    ? Icons.science_outlined
                    : Icons.medical_services_outlined,
                title: isLab
                    ? l10n.servicesAddSection
                    : l10n.servicesAddSpecialtyTitle,
                subtitle: isLab
                    ? l10n.servicesAddSectionSub
                    : l10n.servicesAddSpecialtySub,
                padding: const EdgeInsetsDirectional.fromSTEB(
                  AppSpacing.xl,
                  AppSpacing.xl,
                  AppSpacing.xl,
                  AppSpacing.sm,
                ),
              ),
            GridView(
              padding: const EdgeInsetsDirectional.fromSTEB(
                AppSpacing.screen,
                AppSpacing.md,
                AppSpacing.screen,
                AppSizes.homeBottomClearance,
              ),
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisExtent: AppSizes.servicesCardMinHeight,
                crossAxisSpacing: AppSpacing.sm,
                mainAxisSpacing: AppSpacing.sm,
              ),
              children: cards,
            ),
          ],
        );
      },
    );
  }

  Future<void> _openSheet(BuildContext context, ServicesCubit cubit) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) =>
          BlocProvider.value(value: cubit, child: const ServicesAddSheet()),
    );
  }
}
