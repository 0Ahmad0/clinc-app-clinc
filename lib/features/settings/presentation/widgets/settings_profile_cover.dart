import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';

import '../../../../config/theme/app_spacing.dart';
import '../../../../shared/extensions/context_extensions.dart';
import '../../../../shared/extensions/image_extension.dart';

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
    final coverFallback = _CoverFallback();
    final avatarFallback = _AvatarFallback();
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
                        child: _ProfileImage(
                          path: coverPath!,
                          fallback: coverFallback,
                        ),
                      )
                    : coverFallback,
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
                    gradient: colors.heroBadgeGradient,
                    border: Border.all(color: colors.bg, width: 4),
                  ),
                  alignment: Alignment.center,
                  child: avatarPath != null
                      ? SizedBox.expand(
                          child: _ProfileImage(
                            path: avatarPath!,
                            fallback: avatarFallback,
                          ),
                        )
                      : avatarFallback,
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

class _ProfileImage extends StatelessWidget {
  const _ProfileImage({required this.path, required this.fallback});

  final String path;
  final Widget fallback;

  @override
  Widget build(BuildContext context) {
    if (_isRemotePath(path)) {
      return CachedNetworkImage(
        imageUrl: path.withStorage(),
        fit: BoxFit.cover,
        placeholder: (_, __) => fallback,
        errorWidget: (_, __, ___) => fallback,
      );
    }
    return Image.file(
      File(path),
      fit: BoxFit.cover,
      errorBuilder: (_, __, ___) => fallback,
    );
  }

  bool _isRemotePath(String value) {
    final lower = value.toLowerCase();
    return lower.startsWith('http://') ||
        lower.startsWith('https://') ||
        lower.startsWith('/storage') ||
        lower.startsWith('storage') ||
        !lower.startsWith('/');
  }
}

class _CoverFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(Iconsax.gallery_add, color: colors.muted, size: AppSizes.iconLg),
        AppGaps.h8,
        Text(
          context.l10n.settingsCoverHint,
          textAlign: TextAlign.center,
          style: context.textTheme.bodySmall?.copyWith(color: colors.muted),
        ),
      ],
    );
  }
}

class _AvatarFallback extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Iconsax.hospital,
      color: context.colors.onBrand,
      size: AppSizes.iconLg + AppSpacing.xs,
    );
  }
}
