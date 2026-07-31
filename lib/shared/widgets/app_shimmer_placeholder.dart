import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

import '../../config/theme/app_colors.dart';
import '../extensions/context_extensions.dart';

class AppShimmerPlaceholder extends StatelessWidget {
  const AppShimmerPlaceholder({
    super.key,
    this.width,
    this.height,
    this.borderRadius = 12,
    this.shape = BoxShape.rectangle,
  });

  final double? width;
  final double? height;
  final double borderRadius;
  final BoxShape shape;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final baseColor = isDark
        ? Color.lerp(colors.fill, colors.line, 0.55)!
        : Color.lerp(colors.fill, colors.line, 0.72)!;

    return Shimmer(
      duration: const Duration(milliseconds: 1250),
      interval: const Duration(milliseconds: 120),
      color: AppColors.white,
      colorOpacity: isDark ? .14 : .62,
      enabled: true,
      direction: const ShimmerDirection.fromLTRB(),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: baseColor,
          shape: shape,
          borderRadius: shape == BoxShape.circle
              ? null
              : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}
