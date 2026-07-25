import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../data/models/clinic_service_model.dart';
import '../cubit/services_cubit.dart';
import '../services_l10n.dart';
import 'service_test_card.dart';

/// Scrollable list of a section's tests, each with its enable toggle and price.
class ServicesDetailList extends StatelessWidget {
  const ServicesDetailList({super.key, required this.section});

  final ClinicLabSectionModel section;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ServicesCubit>();
    final accent = section.accent(context.colors);

    return BlocBuilder<ServicesCubit, ServicesState>(
      builder: (context, state) {
        if (state.availableLabTests.isInitialLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        final tests = state.availableLabTests.items.value;
        return ListView.separated(
          padding: const EdgeInsetsDirectional.fromSTEB(
            AppSpacing.screen,
            AppSpacing.md,
            AppSpacing.screen,
            AppSpacing.xl,
          ),
          itemCount: tests.length,
          separatorBuilder: (_, __) => AppGaps.h12,
          itemBuilder: (context, index) {
            final test = tests[index];
            final testState = state.testState(test.labTestId);
            final testAccent = test.accent(context.colors, fallback: accent);
            return ServiceTestCard(
              key: ValueKey(test.labTestId ?? test.code),
              test: test,
              accent: testAccent,
              enabled: testState.enabled,
              price: testState.price,
              onToggle: () => cubit.toggleTest(test.labTestId),
              onPriceChanged: (value) =>
                  cubit.setTestPrice(test.labTestId, value),
            );
          },
        );
      },
    );
  }
}
