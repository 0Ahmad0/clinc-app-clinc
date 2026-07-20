import 'package:flutter/material.dart';

import '../../config/theme/app_spacing.dart';
import '../extensions/context_extensions.dart';

class AppLoader extends StatelessWidget {
  const AppLoader.small({super.key, this.semanticsLabel})
    : size = AppSizes.iconSm,
      strokeWidth = 2;

  const AppLoader.medium({super.key, this.semanticsLabel})
    : size = AppSizes.iconBox,
      strokeWidth = 3;

  const AppLoader.large({super.key, this.semanticsLabel})
    : size = AppSizes.logoSm,
      strokeWidth = 4;

  final String? semanticsLabel;
  final double size;
  final double strokeWidth;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: size,
    child: CircularProgressIndicator(
      semanticsLabel: semanticsLabel,
      strokeWidth: strokeWidth,
      color: context.colors.primary500,
      backgroundColor: context.colors.primary500.withValues(alpha: 0.15),
    ),
  );
}
