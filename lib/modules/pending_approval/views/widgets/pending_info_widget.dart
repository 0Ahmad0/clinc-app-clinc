import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../generated/locale_keys.g.dart';

class PendingInfoWidget extends StatelessWidget {
  const PendingInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          tr(LocaleKeys.pending_approval_title),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
          textAlign: TextAlign.center,
        ),
        12.verticalSpace,
        Text(
          tr(LocaleKeys.pending_approval_subtitle),
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Theme.of(context).primaryColor,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.center,
        ),
        16.verticalSpace,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Text(
            tr(LocaleKeys.pending_approval_description),
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.grey[600],
              height: 1.6, // مسافة مريحة للقراءة
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}