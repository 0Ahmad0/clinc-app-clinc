import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppSvgWidget extends StatelessWidget {
  const AppSvgWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
    this.fit = BoxFit.contain,
  });

  final String path;
  final double? width;
  final double? height;
  final Color? color;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      path,
      width: width ?? 26,
      height: height ?? 26,
      colorFilter: color != null
          ? ColorFilter.mode(color!, BlendMode.srcIn)
          : null,
      fit: fit,
    );
  }
}
