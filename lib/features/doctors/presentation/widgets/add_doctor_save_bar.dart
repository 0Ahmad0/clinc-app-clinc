import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/widgets/app_button.dart';

/// Bottom save bar that fades over the scrolling form (save wired once the
/// endpoint exists).
class AddDoctorSaveBar extends StatelessWidget {
  const AddDoctorSaveBar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      padding: EdgeInsetsDirectional.fromSTEB(
        AppSpacing.screen,
        AppSpacing.sm,
        AppSpacing.screen,
        MediaQuery.paddingOf(context).bottom + AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [colors.bg.withValues(alpha: 0), colors.bg],
          stops: const [0, 0.55],
        ),
      ),
      child: AppButton(
        label: context.l10n.addDoctorSave,
        icon: Iconsax.save_2,
        onPressed: () {},
      ),
    );
  }
}
