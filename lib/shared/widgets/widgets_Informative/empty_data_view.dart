import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../config/assets/app_assets.dart';
import '../../extensions/context_extensions.dart';

class EmptyDataView extends StatelessWidget {
  const EmptyDataView({super.key, this.pathImage, this.text, this.height});

  final String? pathImage;
  final String? text;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final imageSize = height ?? 180.w;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _InformativeAssetView(
            assetPath: pathImage ?? AppAssets.emptyData,
            width: imageSize,
            height: imageSize,
          ),
          SizedBox(height: 10.h),
          Text(
            text ?? context.l10n.noDataYet,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.grey,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}

class _InformativeAssetView extends StatelessWidget {
  const _InformativeAssetView({
    required this.assetPath,
    this.width,
    this.height,
  });

  final String assetPath;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    final lowerPath = assetPath.toLowerCase();

    if (lowerPath.endsWith('.svg')) {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        fit: BoxFit.contain,
      );
    }

    return Image.asset(
      assetPath,
      width: width,
      height: height,
      fit: BoxFit.contain,
    );
  }
}
