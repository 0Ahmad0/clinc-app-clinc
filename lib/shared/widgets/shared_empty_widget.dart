import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../config/assets/app_assets.dart';
import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

class SharedEmptyWidget extends StatelessWidget {
  const SharedEmptyWidget({
    super.key,
    required this.title,
    this.subtitle,
    this.assetPath,
    this.icon,
    this.image,
    this.padding = const EdgeInsetsDirectional.all(AppSpacing.xl),
  });

  final String title;
  final String? subtitle;
  final String? assetPath;
  final IconData? icon;
  final Widget? image;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Center(
      child: Padding(
        padding: padding,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            image ?? _EmptyVisual(assetPath: assetPath, icon: icon),
            const SizedBox(height: AppSpacing.md),
            Text(
              title,
              textAlign: TextAlign.center,
              style: context.textTheme.titleMedium?.copyWith(
                color: colors.ink,
                fontWeight: FontWeight.w700,
              ),
            ),
            if (subtitle != null && subtitle!.trim().isNotEmpty) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                subtitle!,
                textAlign: TextAlign.center,
                style: context.textTheme.bodyMedium?.copyWith(
                  color: colors.muted,
                  height: 1.35,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _EmptyVisual extends StatelessWidget {
  const _EmptyVisual({this.assetPath, this.icon});

  final String? assetPath;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final path = assetPath;

    if (path != null && path.trim().isNotEmpty) {
      final lowerPath = path.toLowerCase();
      if (lowerPath.endsWith('.svg')) {
        return SvgPicture.asset(path, width: 118, height: 118);
      }
      return Image.asset(path, width: 118, height: 118, fit: BoxFit.contain);
    }

    return Container(
      width: 92,
      height: 92,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: colors.fill,
        borderRadius: BorderRadius.circular(AppRadius.card),
        border: Border.all(color: colors.line),
      ),
      child: Icon(
        icon ?? Icons.inbox_outlined,
        size: 38,
        color: colors.primary600,
      ),
    );
  }
}

class DefaultEmptyAsset {
  const DefaultEmptyAsset._();

  static const path = AppAssets.emptyData;
}
