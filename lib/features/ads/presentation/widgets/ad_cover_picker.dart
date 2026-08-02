import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Cover-image drop zone: a dashed placeholder until an image is picked, then a
/// preview with a change affordance.
class AdCoverPicker extends StatelessWidget {
  const AdCoverPicker({
    super.key,
    required this.coverPath,
    required this.onTap,
  });

  final String? coverPath;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final radius = BorderRadius.circular(AppRadius.field + 2);
    return Material(
      color: coverPath == null
          ? colors.primary500.withValues(alpha: 0.05)
          : colors.surface,
      borderRadius: radius,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        child: Ink(
          height: AppSizes.adCoverHeight,
          decoration: BoxDecoration(
            borderRadius: radius,
            border: Border.all(
              color: colors.primary500.withValues(alpha: 0.35),
              width: 1.5,
            ),
          ),
          child: coverPath == null
              ? _Placeholder(text: context.l10n.adsCoverPlaceholder)
              : ClipRRect(
                  borderRadius: radius,
                  child: Image.file(
                    File(coverPath!),
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
        ),
      ),
    );
  }
}

class _Placeholder extends StatelessWidget {
  const _Placeholder({required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Iconsax.gallery_add,
          size: AppSizes.iconLg + AppSpacing.xs,
          color: colors.primary600,
        ),
        AppGaps.h8,
        Text(
          text,
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(color: colors.muted),
        ),
      ],
    );
  }
}
