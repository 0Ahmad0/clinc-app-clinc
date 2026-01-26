import 'package:clinc_app_clinc/app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../app/core/widgets/app_svg_widget.dart';
import '../../../../generated/locale_keys.g.dart';

class RegisterHeaderWidget extends StatelessWidget {
  const RegisterHeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AppSvgWidget(
          path: AppAssets.emergencyIcon, // مسار افتراضي
          height: 80.h,
          width: 80.w,
        ),
        24.verticalSpace,
        Text(
          tr(LocaleKeys.register_title),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        8.verticalSpace,
        Text(
          tr(LocaleKeys.register_subtitle),
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: Colors.grey,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}