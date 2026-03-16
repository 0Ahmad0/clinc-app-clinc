import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SettingsDivider extends StatelessWidget {
  const SettingsDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Divider(
      height: 1,
      thickness: 1,
      indent: 68.w,
      endIndent: 0,
      color: Theme.of(context)
          .colorScheme
          .outlineVariant
          .withValues(alpha: 0.2),
    );
  }
}
