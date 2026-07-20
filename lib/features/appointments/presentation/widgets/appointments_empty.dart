import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Shown when the selected tab has no appointments.
class AppointmentsEmpty extends StatelessWidget {
  const AppointmentsEmpty({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.xxl),
    child: Center(
      child: Text(
        context.l10n.apptEmpty,
        style: context.textTheme.bodyMedium?.copyWith(
          color: context.colors.muted,
        ),
      ),
    ),
  );
}
