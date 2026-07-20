import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// The small square back button on the signup / forgot layers. The arrow flips
/// with text direction so it always points "back".
class AuthBackButton extends StatelessWidget {
  const AuthBackButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.sm),
        onTap: onTap,
        child: Container(
          width: AppSizes.iconBox,
          height: AppSizes.iconBox,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.sm),
            border: Border.all(color: colors.line, width: 1.5),
          ),
          child: Icon(
            Directionality.of(context) == TextDirection.rtl
                ? Iconsax.arrow_right
                : Iconsax.arrow_left,
            size: 19,
            color: colors.ink,
          ),
        ),
      ),
    );
  }
}
