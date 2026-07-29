import 'package:flutter/material.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/shared_empty_widget.dart';

/// Shown when the selected tab has no appointments.
class AppointmentsEmpty extends StatelessWidget {
  const AppointmentsEmpty({super.key});

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsetsDirectional.symmetric(vertical: AppSpacing.xxl),
    child: SharedEmptyWidget(
      icon: Icons.event_busy_outlined,
      title: context.l10n.apptEmpty,
      subtitle: context.l10n.apptTitle,
    ),
  );
}
