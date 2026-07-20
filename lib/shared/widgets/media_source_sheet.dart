import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';
import 'app_bottom_sheet.dart';

/// Sheet that lets the user choose where an image comes from. Pops the chosen
/// [ImageSource], or nothing on dismiss.
class MediaSourceSheet extends StatelessWidget {
  const MediaSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return AppBottomSheet(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.mediaSourceTitle,
            style: context.textTheme.titleMedium?.copyWith(
              color: context.colors.ink,
              fontWeight: FontWeight.w700,
            ),
          ),
          AppGaps.h16,
          _SourceTile(
            icon: Iconsax.camera,
            title: l10n.mediaSourceCamera,
            sub: l10n.mediaSourceCameraSub,
            onTap: () => Navigator.of(context).pop(ImageSource.camera),
          ),
          AppGaps.h12,
          _SourceTile(
            icon: Iconsax.gallery,
            title: l10n.mediaSourceGallery,
            sub: l10n.mediaSourceGallerySub,
            onTap: () => Navigator.of(context).pop(ImageSource.gallery),
          ),
        ],
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.icon,
    required this.title,
    required this.sub,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String sub;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Material(
      color: colors.surface,
      borderRadius: BorderRadius.circular(AppRadius.field),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.field),
        child: Container(
          padding: const EdgeInsetsDirectional.all(AppSpacing.sm),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.field),
            border: Border.all(color: colors.line),
          ),
          child: Row(
            children: [
              Container(
                width: AppSizes.iconBox,
                height: AppSizes.iconBox,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: colors.primary500.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Icon(icon, color: colors.primary600, size: AppSizes.iconSm),
              ),
              AppGaps.w12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium?.copyWith(
                        color: colors.ink,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      sub,
                      style: context.textTheme.labelSmall?.copyWith(
                        color: colors.muted,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
