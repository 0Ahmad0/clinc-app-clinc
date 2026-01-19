import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locale_keys.g.dart';


class FooterLoadingWidget extends StatelessWidget {
  final ThemeData theme;

  const FooterLoadingWidget({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 60.h,
      left: 0,
      right: 0,
      child: Column(
        children: [
          CircularProgressIndicator.adaptive(
            valueColor: AlwaysStoppedAnimation<Color>(theme.primaryColor),
          ),
          20.verticalSpace,
          Text(
            tr(LocaleKeys.splash_powered_by),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.5),
            ),
          ),
        ],
      ),
    );
  }
}
