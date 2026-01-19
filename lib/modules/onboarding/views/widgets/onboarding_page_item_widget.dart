import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locale_keys.g.dart';

class OnboardingPageItem extends StatelessWidget {
  final int index;
  final ThemeData theme;

  const OnboardingPageItem({
    super.key,
    required this.index,
    required this.theme,
  });

  @override
  Widget build(BuildContext context) {
    final List<IconData> icons = [
      Icons.event_note_rounded,
      Icons.person_add_alt_1_rounded,
      Icons.query_stats_rounded,
    ];

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(40.r),
            decoration: BoxDecoration(
              color: theme.primaryColor.withOpacity(0.1),
              // الاعتماد على primaryColor
              shape: BoxShape.circle,
            ),
            child: Icon(icons[index], size: 100.sp, color: theme.primaryColor),
          ),
          50.verticalSpace,
          Text(
            tr("${LocaleKeys.onboarding_titles_0}_$index"),
            textAlign: TextAlign.center,
            style: theme.textTheme.displayLarge?.copyWith(
              fontSize: 26.sp,
              color:
                  theme.colorScheme.onSurface, // الاعتماد على الـ ColorScheme
            ),
          ),

          20.verticalSpace,

          // الوصف
          Text(
            tr("${LocaleKeys.onboarding_descriptions}_$index"),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurface.withOpacity(0.7),
              // سحب اللون من الثيم
              height: 1.5, // لزيادة مقروئية النص العربي
            ),
          ),
        ],
      ),
    );
  }
}
