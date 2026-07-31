import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

class AppShimmer extends StatelessWidget {
  const AppShimmer({
    super.key,
    required this.width,
    required this.height,
    this.radius = AppRadius.sm,
  });

  final double width;
  final double height;
  final double radius;

  @override
  Widget build(BuildContext context) => ClipRRect(
    borderRadius: BorderRadius.circular(radius),
    child: SizedBox(
      width: width,
      height: height,
      child: LinearProgressIndicator(
        color: context.colors.primary300.withValues(alpha: 0.46),
        backgroundColor: context.colors.line.withValues(alpha: 0.72),
      ),
    ),
  );
}
