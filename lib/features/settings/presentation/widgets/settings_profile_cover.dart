import 'dart:io';

import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';

/// Clinic cover strip with the avatar overlapping its lower edge. Both the cover
/// and the avatar's camera badge invite an image upload; picked images replace
/// their placeholders.
class SettingsProfileCover extends StatelessWidget {
  const SettingsProfileCover({
    super.key,
    required this.onPickCover,
    required this.onPickAvatar,
    this.coverPath,
    this.avatarPath,
  });

  final VoidCallback onPickCover;
  final VoidCallback onPickAvatar;
  final String? coverPath;
  final String? avatarPath;

  static const double _avatarOverflow = 48;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: AppSizes.settingsCoverHeight + _avatarOverflow,
      child: Stack(
        alignment: AlignmentDirectional.bottomCenter,
        children: [
          PositionedDirectional(
            top: 0,
            start: 0,
            end: 0,
            child: GestureDetector(
              onTap: onPickCover,
              child: Container(
                height: AppSizes.settingsCoverHeight,
                color: colors.fill,
                alignment: Alignment.center,
                padding: const EdgeInsetsDirectional.all(AppSpacing.lg),
                child: coverPath != null
                    ? SizedBox.expand(
                        child: Image.file(File(coverPath!), fit: BoxFit.cover),
                      )
                    : Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Iconsax.gallery_add,
                            color: colors.muted,
                            size: AppSizes.iconLg,
                          ),
                          AppGaps.h8,
                          Text(
                            context.l10n.settingsCoverHint,
                            textAlign: TextAlign.center,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: colors.muted,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
          SizedBox(
            width: AppSizes.settingsProfileAvatar,
            height: AppSizes.settingsProfileAvatar,
            child: Stack(
              children: [
                Container(
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: avatarPath == null ? colors.heroBadgeGradient : null,
                    border: Border.all(color: colors.bg, width: 4),
                  ),
                  alignment: Alignment.center,
                  child: avatarPath != null
                      ? SizedBox.expand(
                          child: Image.file(File(avatarPath!), fit: BoxFit.cover),
                        )
                      : Icon(
                          Iconsax.hospital,
                          color: colors.onBrand,
                          size: AppSizes.iconLg + AppSpacing.xs,
                        ),
                ),
                PositionedDirectional(
                  bottom: 0,
                  end: 0,
                  child: GestureDetector(
                    onTap: onPickAvatar,
                    child: Container(
                      width: AppSizes.settingsAvatarBadge,
                      height: AppSizes.settingsAvatarBadge,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: colors.primary600,
                        border: Border.all(color: colors.bg, width: 2),
                      ),
                      child: Icon(
                        Iconsax.camera,
                        color: colors.onBrand,
                        size: AppSizes.iconXs,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
