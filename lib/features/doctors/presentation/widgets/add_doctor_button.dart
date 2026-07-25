import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/routes/app_routes.dart';
import '../../../../config/theme/app_shadows.dart';
import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../cubit/doctors_cubit.dart';

class AddDoctorButton extends StatelessWidget {
  const AddDoctorButton({super.key});

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: context.colors.headerGradient,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: AppShadows.primaryButton,
      ),
      child: FilledButton.icon(
        onPressed: () async {
          final result = await context.push(AppRoutes.addDoctor);
          if (result == null || !context.mounted) return;
          context.read<DoctorsCubit>().refresh();
        },
        style: FilledButton.styleFrom(
          backgroundColor: context.colors.onBrand.withValues(alpha: 0),
          shadowColor: context.colors.onBrand.withValues(alpha: 0),
          minimumSize: const Size(0, AppSizes.buttonHeightSm),
          shape: const StadiumBorder(),
        ),
        icon: const Icon(Iconsax.user_add),
        label: Text(context.l10n.doctorsAdd),
      ),
    );
  }
}
