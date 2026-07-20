import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../domain/service_kind.dart';
import '../cubit/services_cubit.dart';
import '../cubit/services_state.dart';
import '../services_catalog.dart';
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
    final catalog = localizedLabTests(l10n);

    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        final isLab = state.kind == ServiceKind.lab;
        final cards = <Widget>[
          if (isLab)
            for (final section in state.sections)
              ServiceCard(
                icon: section.icon,
                accent: section.accent(colors),
                name: section.label(l10n),
                sub: l10n.servicesTestsAvailable(
                  '${catalog[section]!.length}',
                ),
                onTap: () => cubit.openDetail(section),
              )
          else
            for (final specialty in state.specialties)
              ServiceCard(
                icon: specialty.icon,
                accent: specialty.accent(colors),
                name: specialty.label(l10n),
                sub: l10n.servicesSpecialtyLabel,
              ),
          ServicesAddCard(
            label: isLab ? l10n.servicesAddSection : l10n.servicesAddSpecialty,
            onTap: () => _openSheet(context, cubit),
          ),
        ];

        return GridView(
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
        );
      },
    );
  }

  Future<void> _openSheet(BuildContext context, ServicesCubit cubit) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) => BlocProvider.value(
        value: cubit,
        child: const ServicesAddSheet(),
      ),
    );
  }
}
